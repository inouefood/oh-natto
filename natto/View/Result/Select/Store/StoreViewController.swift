//
//  StoreViewController.swift
//  natto
//
//  Created by 佐川 晴海 on 2020/10/11.
//  Copyright © 2020 佐川　晴海. All rights reserved.
//

import UIKit
import SwiftUI

// MARK: - SwiftUI View

private struct StoreView: View {
    let toppingArr: [ToppingType] = [.negi, .okura, .sirasu]
    let onDismiss: () -> Void
    let onSelectItem: (ToppingType) -> Void

    var body: some View {
        ZStack(alignment: .topTrailing) {
            VStack(spacing: 0) {
                Image("storeTop")
                    .resizable()
                    .scaledToFit()
                    .frame(maxWidth: .infinity)

                HStack(spacing: 15) {
                    ForEach(toppingArr, id: \.keyName) { topping in
                        Button(action: { onSelectItem(topping) }) {
                            Image(uiImage: topping.image)
                                .resizable()
                                .scaledToFit()
                                .aspectRatio(1, contentMode: .fit)
                                .cornerRadius(4)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 4)
                                        .stroke(Color.white, lineWidth: 2)
                                )
                        }
                        .buttonStyle(.plain)
                    }
                }
                .padding(.horizontal, 28)
                .padding(.vertical, 15)
                .frame(maxWidth: .infinity)
                .background(Color("gamePlayBackground"))

                Image("storeBottom")
                    .resizable()
                    .scaledToFit()
                    .frame(maxWidth: .infinity)

                Spacer(minLength: 0)
            }

            Button(action: onDismiss) {
                Image("close")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 48, height: 48)
            }
            .buttonStyle(.plain)
            .padding(.top, 16)
            .padding(.trailing, 16)
        }
        .background(Color(.systemBackground))
        .ignoresSafeArea(edges: .bottom)
    }
}

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
        let swiftUIView = StoreView(
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
