//
//  BestScoreScreen.swift
//  natto
//
//  Created by 佐川 晴海 on 2020/10/04.
//  Copyright © 2020 佐川　晴海. All rights reserved.
//

import SwiftUI

struct BestScoreScreen: View {
    let score: String
    let onDismiss: () -> Void
    let onShare: () -> Void

    var body: some View {
        ZStack {
            Color.black.opacity(0.4)
                .ignoresSafeArea()

            VStack(spacing: 0) {
                VStack(spacing: 0) {
                    Text(localizeString(key: LocalizeKeys.BestScore.title))
                        .font(.scaled(30, weight: .bold))
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.horizontal, 8)
                        .padding(.top, 4)

                    Image("bestScore")
                        .resizable()
                        .scaledToFit()
                        .padding(.horizontal, 16)
                        .padding(.top, 4)

                    Text(score)
                        .font(.scaled(32))
                        .frame(maxWidth: .infinity)
                        .padding(.horizontal, 16)
                        .padding(.top, 4)
                        .padding(.bottom, 8)
                }

                HStack(spacing: 8) {
                    Button(action: onDismiss) {
                        Text(localizeString(key: LocalizeKeys.BestScore.close))
                            .font(.scaledCustom("HelveticaNeue", size: 22))
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity, minHeight: 45)
                            .background(Color.orange)
                            .cornerRadius(4)
                    }
                    .buttonStyle(.plain)

                    Button(action: onShare) {
                        Text(localizeString(key: LocalizeKeys.BestScore.share))
                            .font(.scaledCustom("HelveticaNeue", size: 22))
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity, minHeight: 45)
                            .background(Color.orange)
                            .cornerRadius(4)
                    }
                    .buttonStyle(.plain)
                }
                .padding(.horizontal, 8)
                .padding(.top, 8)
                .padding(.bottom, 16)
            }
            .background(Color(.systemBackground))
            .cornerRadius(16)
            .padding(.horizontal, 32)
            .frame(maxHeight: UIScreen.main.bounds.height * 0.6)
        }
    }
}

#Preview {
    BestScoreScreen(
        score: "1,234",
        onDismiss: {},
        onShare: {}
    )
}
