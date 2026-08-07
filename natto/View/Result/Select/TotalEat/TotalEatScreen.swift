//
//  TotalEatScreen.swift
//  natto
//
//  Created by 佐川 晴海 on 2020/10/13.
//  Copyright © 2020 佐川　晴海. All rights reserved.
//

import SwiftUI

struct TotalEatScreen: View {
    let totalNattoCount: Int
    let onDismiss: () -> Void

    private var iconName: String {
        if totalNattoCount < 3000 { return "totalEat-one" }
        else if totalNattoCount < 6000 { return "totalEat-two" }
        else if totalNattoCount < 20000 { return "totalEat-three" }
        else { return "totalEat-four" }
    }

    private var nextGrouthText: String {
        if totalNattoCount < 3000 {
            return localizeString(key: LocalizeKeys.TotalEat.grouth, 3000 - totalNattoCount)
        } else if totalNattoCount < 6000 {
            return localizeString(key: LocalizeKeys.TotalEat.grouth, 6000 - totalNattoCount)
        } else if totalNattoCount < 20000 {
            return localizeString(key: LocalizeKeys.TotalEat.grouth, 20000 - totalNattoCount)
        } else {
            return ""
        }
    }

    private var verdanaBoldFont25: Font { .scaledCustom("Verdana-bold", size: 25) }

    var body: some View {
        ZStack {
            Color("background").ignoresSafeArea()

            VStack(spacing: 0) {
                Text(localizeString(key: LocalizeKeys.TotalEat.eatNatto))
                    .font(verdanaBoldFont25)
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity, alignment: .center)
                    .padding(.horizontal, 16)
                    .padding(.top, 16)

                HStack(spacing: 0) {
                    Spacer()
                    VStack(alignment: .trailing, spacing: 0) {
                        Text(localizeString(key: LocalizeKeys.TotalEat.grain, totalNattoCount))
                            .font(verdanaBoldFont25)
                            .foregroundColor(.white)
                        Rectangle()
                            .fill(Color(red: 0.637, green: 0.944, blue: 0.5))
                            .frame(height: 1)
                    }
                    .padding(.trailing, 36)
                }
                .padding(.top, 8)

                Spacer()

                Image(iconName)
                    .resizable()
                    .scaledToFit()
                    .padding(.horizontal, 24)

                Spacer()

                if !nextGrouthText.isEmpty {
                    Text(nextGrouthText)
                        .font(verdanaBoldFont25)
                        .foregroundColor(.white)
                        .multilineTextAlignment(.leading)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.horizontal, 16)
                        .padding(.bottom, 8)
                }

                Button(action: onDismiss) {
                    Text(localizeString(key: LocalizeKeys.UpdateLeast.buttonClose))
                        .font(.system(size: 20, weight: .bold))
                        .foregroundColor(.white)
                        .frame(width: 200, height: 36)
                        .background(Color("button"))
                        .cornerRadius(4)
                }
                .buttonStyle(.plain)
                .padding(.bottom, 24)
            }
        }
    }
}

#Preview("初心者 (500粒)") {
    TotalEatScreen(totalNattoCount: 500, onDismiss: {})
}

#Preview("中級者 (4000粒)") {
    TotalEatScreen(totalNattoCount: 4000, onDismiss: {})
}

#Preview("上級者 (12000粒)") {
    TotalEatScreen(totalNattoCount: 12000, onDismiss: {})
}

#Preview("MAX (25000粒)") {
    TotalEatScreen(totalNattoCount: 25000, onDismiss: {})
}
