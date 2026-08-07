//
//  SelectScreen.swift
//  natto
//
//  Created by 佐川 晴海 on 2020/10/13.
//  Copyright © 2020 佐川　晴海. All rights reserved.
//

import SwiftUI

struct SelectScreen: View {
    let onDismiss: () -> Void
    let onStorePage: () -> Void
    let onLeaderBoard: () -> Void
    let onTotalEatPage: () -> Void
    let onSettingPage: () -> Void
    let onShare: () -> Void

    var body: some View {
        ZStack(alignment: .bottomTrailing) {
            // pass-through background (full screen including safe area)
            Color.clear
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .ignoresSafeArea()
                .allowsHitTesting(false)

            VStack(alignment: .trailing, spacing: 10) {
                HStack(spacing: 5) {
                    iconButton("mametisikiIcon", size: 50, action: onLeaderBoard)
                    iconButton("settingIcon", size: 45, action: onSettingPage)
                }
                HStack(alignment: .center, spacing: 0) {
                    iconButton("totalEatNattoIcon", size: 50, action: onTotalEatPage)
                        .padding(.trailing, 24)
                    iconButton("shopIcon", size: 80, action: onStorePage)
                }
                HStack(spacing: 0) {
                    iconButton("shareIcon", size: 50, action: onShare)
                        .padding(.trailing, 82)
                    iconButton("infoIcon", size: 46, action: onDismiss)
                }
            }
            .padding(.trailing, 40)
            .padding(.bottom, 32)  // safeArea.bottom 基準になる
        }
        // ignoresSafeArea をここには付けない → ボタンが safeArea.bottom から 32pt の位置に
    }

    private func iconButton(_ imageName: String, size: CGFloat, action: @escaping () -> Void) -> some View {
        Button(action: action) {
            Image(imageName)
                .resizable()
                .scaledToFit()
                .frame(width: size, height: size)
        }
        .buttonStyle(.plain)
    }
}

#Preview {
    SelectScreen(
        onDismiss: {},
        onStorePage: {},
        onLeaderBoard: {},
        onTotalEatPage: {},
        onSettingPage: {},
        onShare: {}
    )
    .background(Color.black.opacity(0.3))
}
