//
//  SettingScreen.swift
//  natto
//
//  Created by 佐川 晴海 on 2020/10/26.
//  Copyright © 2020 佐川　晴海. All rights reserved.
//

import SwiftUI

struct SettingScreen: View {
    @State private var hapticEnabled: Bool
    let onDismiss: () -> Void
    let onPrivacyPolicy: () -> Void
    let onReview: () -> Void
    let onNotificationSettings: () -> Void

    init(hapticEnabled: Bool,
         onDismiss: @escaping () -> Void,
         onPrivacyPolicy: @escaping () -> Void,
         onReview: @escaping () -> Void,
         onNotificationSettings: @escaping () -> Void) {
        _hapticEnabled = State(initialValue: hapticEnabled)
        self.onDismiss = onDismiss
        self.onPrivacyPolicy = onPrivacyPolicy
        self.onReview = onReview
        self.onNotificationSettings = onNotificationSettings
    }

    private var appVersionString: String {
        let v = Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as? String ?? ""
        return "v" + v
    }

    var body: some View {
        NavigationView {
            List {
                Section(header: Text(localizeString(key: LocalizeKeys.Setting.sectionArrSetting))) {
                    HStack {
                        Text(localizeString(key: LocalizeKeys.Setting.cellArrVibration))
                        Spacer()
                        Toggle("", isOn: $hapticEnabled)
                            .onChange(of: hapticEnabled) { _, value in
                                UserStore.hapticSetting = value
                            }
                    }
                }

                Section(header: Text(localizeString(key: LocalizeKeys.Setting.sectionArrOther))) {
                    Button(action: onPrivacyPolicy) {
                        HStack {
                            Text(localizeString(key: LocalizeKeys.Setting.cellArrPrivacyPolicy))
                                .foregroundColor(.primary)
                            Spacer()
                            Image(systemName: "chevron.right")
                                .foregroundColor(.secondary)
                                .font(.caption)
                        }
                    }

                    Button(action: onReview) {
                        HStack {
                            Text(localizeString(key: LocalizeKeys.Setting.cellArrReview))
                                .foregroundColor(.primary)
                            Spacer()
                            Image(systemName: "chevron.right")
                                .foregroundColor(.secondary)
                                .font(.caption)
                        }
                    }

                    Button(action: onNotificationSettings) {
                        HStack {
                            Text(localizeString(key: LocalizeKeys.Setting.cellArrPushNortification))
                                .foregroundColor(.primary)
                            Spacer()
                            Image(systemName: "chevron.right")
                                .foregroundColor(.secondary)
                                .font(.caption)
                        }
                    }

                    HStack {
                        Text(localizeString(key: LocalizeKeys.Setting.cellArrVersion))
                        Spacer()
                        Text(appVersionString)
                            .foregroundColor(.secondary)
                    }
                }
            }
            .listStyle(.grouped)
            .navigationBarItems(trailing:
                Button(action: onDismiss) {
                    Image("close")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 36, height: 36)
                }
            )
        }
    }
}

#Preview {
    SettingScreen(
        hapticEnabled: true,
        onDismiss: {},
        onPrivacyPolicy: {},
        onReview: {},
        onNotificationSettings: {}
    )
}
