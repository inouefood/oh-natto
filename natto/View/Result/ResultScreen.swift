//
//  ResultScreen.swift
//  natto
//
//  Created by 佐川 晴海 on 2020/10/04.
//  Copyright © 2020 佐川　晴海. All rights reserved.
//

import SwiftUI

// MARK: - Screenshot area content

struct ResultScreenContent: View {
    let tipsTitle: String
    let tipsText: String
    let scoreTitle: String
    let scoreText: String

    var body: some View {
        GeometryReader { geo in
            VStack(spacing: 0) {
                // チップス: 画像のアスペクト比に合わせた自然な高さ
                ZStack(alignment: .topLeading) {
                    TimelineView(.periodic(from: .now, by: 1.0 / 8.0)) { context in
                        let frame = Int(context.date.timeIntervalSinceReferenceDate * 8) % 8
                        Image("natto_tips_\(frame)")
                            .resizable()
                            .scaledToFit()
                            .frame(width: geo.size.width)
                    }

                    VStack(alignment: .leading, spacing: 8) {
                        Text(tipsTitle)
                            .font(.scaled(22, weight: .medium))
                            .foregroundColor(.white)
                        Text(tipsText)
                            .font(.scaled(20))
                            .foregroundColor(.white)
                            .multilineTextAlignment(.center)
                            .frame(maxWidth: .infinity)
                            .minimumScaleFactor(0.75)
                            .lineLimit(3)
                    }
                    .padding(.leading, 64 * Font.fontScale)
                    .padding(.trailing, 32 * Font.fontScale)
                    .padding(.top, 42 * Font.fontScale)
                }
                .frame(width: geo.size.width)
                .clipped()

                // スコア: 残りの高さを全て使う
                ZStack {
                    TimelineView(.periodic(from: .now, by: 1.0 / 8.0)) { context in
                        let frame = Int(context.date.timeIntervalSinceReferenceDate * 8) % 8
                        Image("natto_wachawacha_\(frame)")
                            .resizable()
                            .scaledToFit()
                            .frame(width: geo.size.width)
                    }

                    VStack(spacing: 16) {
                        Text(scoreTitle)
                            .font(.scaled(24, weight: .medium))
                            .foregroundColor(.white)
                            .minimumScaleFactor(0.5)
                        Text(scoreText)
                            .font(.scaled(48, weight: .bold))
                            .foregroundColor(.white)
                    }
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            }
        }
        .background(Color("background"))
    }
}

// MARK: - Bottom buttons bar

struct ResultBottomButtonsView: View {
    let onLeaderBoard: () -> Void
    let onSettings: () -> Void
    let onStore: () -> Void
    let onTotalEat: () -> Void
    let onShare: () -> Void

    var body: some View {
        HStack(spacing: 0) {
            Spacer()
            iconButton("mametisikiIcon", size: 50, action: onLeaderBoard)
            Spacer()
            iconButton("settingIcon", size: 45, action: onSettings)
            Spacer()
            iconButton("shopIcon", size: 60, action: onStore)
            Spacer()
            iconButton("totalEatNattoIcon", size: 50, action: onTotalEat)
            Spacer()
            iconButton("shareIcon", size: 50, action: onShare)
            Spacer()
        }
        .padding(.top, 10)
        .padding(.bottom, 10)
        .frame(maxWidth: .infinity)
        .background(Color("background").ignoresSafeArea(edges: .bottom))
    }

    private func iconButton(_ name: String, size: CGFloat, action: @escaping () -> Void) -> some View {
        Button(action: action) {
            Image(name)
                .resizable()
                .scaledToFit()
                .frame(width: size, height: size)
        }
        .buttonStyle(.plain)
    }
}

#Preview("Result全体") {
    VStack(spacing: 0) {
        ResultScreenContent(
            tipsTitle: "豆知識",
            tipsText: "弥生時代にはすでに納豆はあったらしいよ",
            scoreTitle: "今回のスコア",
            scoreText: "1234点"
        )

        Text("もういちど")
            .font(Font(UIFont(name: "Verdana-bold", size: 35) ?? .boldSystemFont(ofSize: 35)))
            .foregroundColor(.white)
            .padding(.vertical, 12)
            .background(Color("background"))

        ResultBottomButtonsView(
            onLeaderBoard: {},
            onSettings: {},
            onStore: {},
            onTotalEat: {},
            onShare: {}
        )
    }
    .background(Color("background"))
    .ignoresSafeArea(edges: .bottom)
}

#Preview("スコア画面コンテンツ") {
    ResultScreenContent(
        tipsTitle: "豆知識",
        tipsText: "弥生時代にはすでに納豆はあったらしいよ",
        scoreTitle: "今回のスコア",
        scoreText: "1234点"
    )
}

#Preview("ボタンバー") {
    ResultBottomButtonsView(
        onLeaderBoard: {},
        onSettings: {},
        onStore: {},
        onTotalEat: {},
        onShare: {}
    )
    .frame(maxHeight: .infinity, alignment: .bottom)
    .background(Color.black)
}
