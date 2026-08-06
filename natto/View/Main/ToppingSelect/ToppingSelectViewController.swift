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

// MARK: - SwiftUI Views

private struct ToppingItemView: View {
    let viewModel: ToppingSelectCollectionViewCell.ViewModel

    var body: some View {
        ZStack(alignment: .topTrailing) {
            Image(uiImage: viewModel.image)
                .resizable()
                .scaledToFit()
                .padding(8)
                .background(Color(.systemGray5))
                .cornerRadius(8)

            Text(viewModel.count.description)
                .font(.system(size: 17))
                .frame(width: 28, height: 28)
                .background(Color(.systemGray))
                .foregroundColor(.primary)
                .clipShape(Circle())
        }
    }
}

private struct ToppingSelectView: View {
    let toppings: [ToppingSelectCollectionViewCell.ViewModel]
    let selectedImages: [UIImage?]
    let onDecision: () -> Void
    let onReset: () -> Void
    let onOpenShop: () -> Void
    let onSelectTopping: (Int) -> Void
    let onAlertItemLess: () -> Void
    let onAlertSelectOver: () -> Void

    private let columns = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible()),
    ]

    var body: some View {
        VStack(spacing: 0) {
            HStack {
                Button(action: onOpenShop) {
                    Image("shopIcon")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 50, height: 50)
                }
                .buttonStyle(.plain)
                Spacer()
                Button(action: onDecision) {
                    Image("close")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 50, height: 50)
                }
                .buttonStyle(.plain)
            }
            .padding(.horizontal, 8)
            .padding(.top, 12)

            ScrollView {
                LazyVGrid(columns: columns, spacing: 15) {
                    ForEach(Array(toppings.enumerated()), id: \.offset) { idx, topping in
                        ToppingItemView(viewModel: topping)
                            .onTapGesture { onSelectTopping(idx) }
                    }
                }
                .padding(15)
            }
            .frame(maxHeight: UIScreen.main.bounds.height * 0.28)

            ZStack {
                Image("toppingPlate")
                    .resizable()
                    .scaledToFit()
                    .frame(maxWidth: .infinity)

                GeometryReader { geo in
                    let w = geo.size.width
                    let h = geo.size.height
                    Group {
                        if let img = selectedImages[safe: 0] ?? nil {
                            Image(uiImage: img)
                                .resizable()
                                .scaledToFit()
                                .frame(width: 130, height: 130)
                                .position(x: w / 2 - 80, y: h / 2 - 80)
                        }
                        if let img = selectedImages[safe: 2] ?? nil {
                            Image(uiImage: img)
                                .resizable()
                                .scaledToFit()
                                .frame(width: 130, height: 130)
                                .position(x: w / 2, y: h / 2 - 60)
                        }
                        if let img = selectedImages[safe: 1] ?? nil {
                            Image(uiImage: img)
                                .resizable()
                                .scaledToFit()
                                .frame(width: 130, height: 130)
                                .position(x: w / 2 + 70, y: h / 2 - 80)
                        }
                    }
                }
            }
            .frame(maxWidth: .infinity)
            .frame(maxHeight: UIScreen.main.bounds.height * 0.38)

            Button(action: onDecision) {
                Text(localizeString(key: LocalizeKeys.ToppingSelect.decision))
                    .font(.system(size: 16, weight: .bold))
                    .foregroundColor(.white)
                    .frame(width: 200, height: 36)
                    .background(Color.yellow)
                    .cornerRadius(6)
            }
            .buttonStyle(.plain)
            .padding(.top, 16)

            Button(action: onReset) {
                Text(localizeString(key: LocalizeKeys.ToppingSelect.reset))
                    .font(.system(size: 15, weight: .semibold))
                    .foregroundColor(.white)
                    .frame(width: 200, height: 36)
                    .background(Color(.systemGray))
                    .cornerRadius(6)
            }
            .buttonStyle(.plain)
            .padding(.top, 8)
            .padding(.bottom, 24)
        }
        .background(Color(.systemBackground))
        .ignoresSafeArea(edges: .top)
    }
}

// MARK: - UIViewController

#Preview("トッピング選択（空）") {
    ToppingSelectView(
        toppings: [],
        selectedImages: [nil, nil, nil],
        onDecision: {},
        onReset: {},
        onOpenShop: {},
        onSelectTopping: { _ in },
        onAlertItemLess: {},
        onAlertSelectOver: {}
    )
}

class ToppingSelectViewController: UIViewController {
    private var toppings: [ToppingSelectCollectionViewCell.ViewModel] = []
    private var selectedImages: [UIImage?] = [nil, nil, nil]
    private var hostingController: UIHostingController<ToppingSelectView>?

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
        let view = ToppingSelectView(
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
        let updatedView = ToppingSelectView(
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

// MARK: - Array safe subscript helper

private extension Array {
    subscript(safe index: Int) -> Element? {
        guard index >= 0, index < count else { return nil }
        return self[index]
    }
}
