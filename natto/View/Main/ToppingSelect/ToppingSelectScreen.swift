//
//  ToppingSelectScreen.swift
//  natto
//
//  Created by 佐川 晴海 on 2020/10/13.
//  Copyright © 2020 佐川　晴海. All rights reserved.
//

import SwiftUI

// MARK: - SwiftUI Views

struct ToppingItemView: View {
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
                .font(.scaled(13))
                .minimumScaleFactor(0.6)
                .lineLimit(1)
                .frame(width: 28 * Font.fontScale, height: 28 * Font.fontScale)
                .background(Color(.systemGray))
                .foregroundColor(.primary)
                .clipShape(Circle())
                .padding(4)
        }
    }
}

struct ToppingSelectScreen: View {
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
                    .font(.scaled(16, weight: .bold))
                    .foregroundColor(.white)
                    .frame(width: 200, height: 36)
                    .background(Color.yellow)
                    .cornerRadius(6)
            }
            .buttonStyle(.plain)
            .padding(.top, 16)

            Button(action: onReset) {
                Text(localizeString(key: LocalizeKeys.ToppingSelect.reset))
                    .font(.scaled(15, weight: .semibold))
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

#Preview("トッピング選択（空）") {
    ToppingSelectScreen(
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

// MARK: - Array safe subscript helper

extension Array {
    subscript(safe index: Int) -> Element? {
        guard index >= 0, index < count else { return nil }
        return self[index]
    }
}
