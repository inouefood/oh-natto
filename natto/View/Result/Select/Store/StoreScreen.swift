//
//  StoreScreen.swift
//  natto
//
//  Created by 佐川 晴海 on 2020/10/11.
//  Copyright © 2020 佐川　晴海. All rights reserved.
//

import SwiftUI

struct StoreScreen: View {
    let toppingArr: [ToppingType] = [.negi, .okura, .sirasu]
    let onDismiss: () -> Void
    let onSelectItem: (ToppingType) -> Void

    var body: some View {
        GeometryReader { geo in
            let storeBottomH = geo.size.width / 3
            let collectionH = geo.size.height * 0.2

            ZStack(alignment: .bottom) {
                Color(.systemBackground)

                // storeTop: background, bottom overlaps storeBottom by 10pt
                Image("storeTop")
                    .resizable()
                    .scaledToFit()
                    .frame(width: geo.size.width)
                    .padding(.bottom, storeBottomH - 10)

                // storeBottom: pinned to screen bottom
                Image("storeBottom")
                    .resizable()
                    .scaledToFit()
                    .frame(width: geo.size.width)

                // Items: overlaid on storeTop, just above storeBottom
                HStack(spacing: 15) {
                    ForEach(toppingArr, id: \.keyName) { topping in
                        Button(action: { onSelectItem(topping) }) {
                            Image(uiImage: topping.image)
                                .resizable()
                                .scaledToFit()
                                .aspectRatio(1, contentMode: .fit)
                                .frame(maxWidth: .infinity)
                                .cornerRadius(4)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 4)
                                        .stroke(Color.white, lineWidth: 2)
                                )
                        }
                        .buttonStyle(.plain)
                    }
                }
                .frame(width: geo.size.width - 56, height: collectionH)
                .background(Color("gamePlayBackground"))
                .padding(.bottom, storeBottomH + 8)
            }
        }
        .ignoresSafeArea(edges: .bottom)
        .overlay(alignment: .topTrailing) {
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
    }
}

#Preview {
    StoreScreen(
        onDismiss: {},
        onSelectItem: { _ in }
    )
}
