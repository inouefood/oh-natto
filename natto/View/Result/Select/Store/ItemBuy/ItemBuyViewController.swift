//
//  ItemBuyViewController.swift
//  natto
//
//  Created by 佐川 晴海 on 2020/12/05.
//  Copyright © 2020 佐川　晴海. All rights reserved.
//

import UIKit
import SwiftUI

// MARK: - SwiftUI View

private struct ItemBuyView: View {
    let buyItem: ToppingType
    let onDismiss: () -> Void

    @State private var quantity = 0
    @State private var nattoPoint = 0
    @State private var showingConfirmation = false

    private var maxQuantity: Int {
        guard buyItem.price > 0 else { return 0 }
        return nattoPoint / buyItem.price
    }

    var body: some View {
        ZStack {
            Color(white: 0.5).opacity(0.8)
                .ignoresSafeArea()

            VStack(spacing: 20) {
                Image(uiImage: buyItem.image)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 128, height: 128)

                Text(buyItem.name)
                    .font(.system(size: 17))

                Text(localizeString(key: LocalizeKeys.ItemBuy.ownedLabelText, nattoPoint))
                    .font(.system(size: 17))

                // ±ステッパー
                HStack(spacing: 8) {
                    stepperButton("－", enabled: quantity > 0) {
                        quantity -= 1
                    }
                    Text(quantity.description)
                        .frame(width: 64, height: 52)
                        .font(.system(size: 28, weight: .medium))
                        .multilineTextAlignment(.center)
                    stepperButton("＋", enabled: quantity < maxQuantity) {
                        quantity += 1
                    }
                }

                // アクションボタン横並び
                HStack(spacing: 12) {
                    actionButton("とじる", color: Color("gamePlayBackground")) {
                        onDismiss()
                    }
                    actionButton("かう", color: Color("button"), isDisabled: quantity == 0) {
                        showingConfirmation = true
                    }
                }
            }
            .padding(20)
            .background(Color(.systemBackground))
            .cornerRadius(12)
            .frame(maxWidth: 560)
            .padding(.horizontal, 24)
        }
        .onAppear { loadPoint() }
        .alert(
            localizeString(key: LocalizeKeys.ItemBuy.alertTitle),
            isPresented: $showingConfirmation
        ) {
            Button(localizeString(key: LocalizeKeys.ItemBuy.alertYesButton)) {
                executePurchase()
            }
            Button(localizeString(key: LocalizeKeys.ItemBuy.alertNoButton), role: .cancel) {}
        } message: {
            Text(localizeString(key: LocalizeKeys.ItemBuy.alertMessage,
                                buyItem.price * quantity, buyItem.name, quantity))
        }
    }

    @ViewBuilder
    private func stepperButton(_ label: String, enabled: Bool, action: @escaping () -> Void) -> some View {
        Button {
            action()
        } label: {
            Text(label)
                .font(.system(size: 28))
                .foregroundColor(.white)
                .frame(maxWidth: .infinity, minHeight: 52)
                .background(enabled ? Color("button") : Color(.systemGray3))
                .cornerRadius(4)
                .contentShape(Rectangle())
        }
        .buttonStyle(.plain)
        .allowsHitTesting(enabled)
    }

    @ViewBuilder
    private func actionButton(_ label: String, color: Color, isDisabled: Bool = false, action: @escaping () -> Void) -> some View {
        Button {
            action()
        } label: {
            Text(label)
                .font(.system(size: 19))
                .foregroundColor(.white)
                .frame(maxWidth: .infinity, minHeight: 44)
                .background(isDisabled ? Color(.systemGray3) : color)
                .cornerRadius(4)
                .contentShape(Rectangle())
        }
        .buttonStyle(.plain)
        .allowsHitTesting(!isDisabled)
    }

    private func loadPoint() {
        let eatKey = "natto"
        guard let eatPoint = UserStore.eatPoint,
              let point = eatPoint[eatKey] else { return }
        nattoPoint = point
    }

    private func executePurchase() {
        let totalPoint = buyItem.price * quantity
        let eatKey = "natto"
        guard let eatPoint = UserStore.eatPoint,
              let currentPoint = eatPoint[eatKey] else { return }

        let newNattoPoint = currentPoint - totalPoint
        UserStore.eatPoint?.updateValue(newNattoPoint, forKey: eatKey)

        let existing = UserStore.ownedItem
        switch buyItem {
        case .negi:
            UserStore.ownedItem = OwnedItem(negi: (existing?.negi ?? 0) + quantity,
                                             okura: existing?.okura ?? 0,
                                             sirasu: existing?.sirasu ?? 0)
        case .okura:
            UserStore.ownedItem = OwnedItem(negi: existing?.negi ?? 0,
                                             okura: (existing?.okura ?? 0) + quantity,
                                             sirasu: existing?.sirasu ?? 0)
        case .sirasu:
            UserStore.ownedItem = OwnedItem(negi: existing?.negi ?? 0,
                                             okura: existing?.okura ?? 0,
                                             sirasu: (existing?.sirasu ?? 0) + quantity)
        }

        nattoPoint = newNattoPoint
        quantity = min(quantity, maxQuantity)
    }
}

// MARK: - UIViewController Wrapper

class ItemBuyViewController: UIViewController {
    var buyItem: ToppingType!

    override func loadView() {
        view = UIView()
        view.backgroundColor = .clear
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        let swiftUIView = ItemBuyView(buyItem: buyItem) { [weak self] in
            self?.dismiss(animated: false)
        }

        let hc = UIHostingController(rootView: swiftUIView)
        hc.view.backgroundColor = .clear
        addChild(hc)
        view.addSubview(hc.view)
        hc.view.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            hc.view.topAnchor.constraint(equalTo: view.topAnchor),
            hc.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            hc.view.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            hc.view.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        hc.didMove(toParent: self)
    }
}
