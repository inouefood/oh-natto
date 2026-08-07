//
//  StoreViewController.swift
//  natto
//
//  Created by 佐川 晴海 on 2020/10/11.
//  Copyright © 2020 佐川　晴海. All rights reserved.
//

import UIKit
import SwiftUI

// MARK: - UIViewController

class StoreViewController: UIViewController {
    var dismissHandler: (() -> Void)?

    override func loadView() {
        view = UIView()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupSwiftUI()
    }

    private func setupSwiftUI() {
        let swiftUIView = StoreScreen(
            onDismiss: { [weak self] in
                self?.dismiss(animated: true, completion: self?.dismissHandler)
            },
            onSelectItem: { [weak self] topping in
                let vc = ItemBuyViewController()
                vc.buyItem = topping
                vc.modalPresentationStyle = .overCurrentContext
                self?.present(vc, animated: false)
            }
        )
        let hc = UIHostingController(rootView: swiftUIView)
        hc.view.backgroundColor = .clear
        addChild(hc)
        view.addSubview(hc.view)
        hc.view.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            hc.view.topAnchor.constraint(equalTo: view.topAnchor),
            hc.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            hc.view.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            hc.view.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
        hc.didMove(toParent: self)
    }
}
