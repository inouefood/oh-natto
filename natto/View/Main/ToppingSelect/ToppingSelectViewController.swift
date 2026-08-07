//
//  ToppingSelectViewController.swift
//  natto
//
//  Created by 佐川 晴海 on 2020/10/13.
//  Copyright © 2020 佐川　晴海. All rights reserved.
//

import UIKit
import SwiftUI

class ToppingManager: NSObject {
    var selectedItem: [Topping] = []
    static let shared: ToppingManager = ToppingManager()
    private override init() {}
}

// MARK: - UIViewController

class ToppingSelectViewController: UIViewController {
    private var toppings: [ToppingSelectCollectionViewCell.ViewModel] = []
    private var selectedImages: [UIImage?] = [nil, nil, nil]
    private var hostingController: UIHostingController<ToppingSelectScreen>?

    override func loadView() {
        view = UIView()
        view.backgroundColor = UIColor.systemBackground
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        toppings = UserStore.ownedItem?.createItemList(alreadySelect: ToppingManager.shared.selectedItem) ?? []

        for (i, item) in ToppingManager.shared.selectedItem.enumerated() {
            if i < 3 { selectedImages[i] = item.type.image }
        }

        setupSwiftUI()
    }

    private func setupSwiftUI() {
        let view = ToppingSelectScreen(
            toppings: toppings,
            selectedImages: selectedImages,
            onDecision: { [weak self] in self?.dismiss(animated: true) },
            onReset: { [weak self] in self?.resetAction() },
            onOpenShop: { [weak self] in self?.openShopAction() },
            onSelectTopping: { [weak self] idx in self?.selectTopping(at: idx) },
            onAlertItemLess: {},
            onAlertSelectOver: {}
        )
        let hc = UIHostingController(rootView: view)
        hc.view.backgroundColor = .clear
        hostingController = hc
        addChild(hc)
        self.view.addSubview(hc.view)
        hc.view.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            hc.view.topAnchor.constraint(equalTo: self.view.topAnchor),
            hc.view.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            hc.view.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            hc.view.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
        ])
        hc.didMove(toParent: self)
    }

    private func refreshView() {
        let updatedView = ToppingSelectScreen(
            toppings: toppings,
            selectedImages: selectedImages,
            onDecision: { [weak self] in self?.dismiss(animated: true) },
            onReset: { [weak self] in self?.resetAction() },
            onOpenShop: { [weak self] in self?.openShopAction() },
            onSelectTopping: { [weak self] idx in self?.selectTopping(at: idx) },
            onAlertItemLess: {},
            onAlertSelectOver: {}
        )
        hostingController?.rootView = updatedView
    }

    private func resetAction() {
        ToppingManager.shared.selectedItem = []
        selectedImages = [nil, nil, nil]
        toppings = UserStore.ownedItem?.createItemList(alreadySelect: ToppingManager.shared.selectedItem) ?? []
        refreshView()
    }

    private func openShopAction() {
        let vc = StoreViewController()
        vc.modalPresentationStyle = .overCurrentContext
        vc.dismissHandler = { [weak self] in
            guard let self else { return }
            self.toppings = UserStore.ownedItem?.createItemList(alreadySelect: ToppingManager.shared.selectedItem) ?? []
            self.refreshView()
        }
        present(vc, animated: true)
    }

    private func selectTopping(at index: Int) {
        guard index < toppings.count else { return }
        let topping = toppings[index]
        let count = topping.count - 1
        if count < 0 {
            showInformation(message: localizeString(key: LocalizeKeys.ToppingSelect.alertItemLess),
                            closeButtonText: localizeString(key: LocalizeKeys.UpdateLeast.buttonClose))
            return
        }

        let filledCount = selectedImages.filter { $0 != nil }.count
        if filledCount >= 3 {
            showInformation(message: localizeString(key: LocalizeKeys.ToppingSelect.alertSelectOver),
                            closeButtonText: localizeString(key: LocalizeKeys.UpdateLeast.buttonClose))
            return
        }

        toppings[index] = ToppingSelectCollectionViewCell.ViewModel(
            image: topping.image,
            count: count,
            instance: topping.instance
        )
        ToppingManager.shared.selectedItem.append(topping.instance)

        if selectedImages[0] == nil {
            selectedImages[0] = topping.instance.type.image
        } else if selectedImages[2] == nil {
            selectedImages[2] = topping.instance.type.image
        } else if selectedImages[1] == nil {
            selectedImages[1] = topping.instance.type.image
        }

        refreshView()
    }
}
