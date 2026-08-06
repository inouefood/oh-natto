//
//  SettingViewController.swift
//  natto
//
//  Created by 佐川 晴海 on 2020/10/26.
//  Copyright © 2020 佐川　晴海. All rights reserved.
//

import UIKit
import SwiftUI
import SafariServices

// MARK: - SwiftUI View

private struct SettingView: View {
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

// MARK: - UIViewController

#Preview {
    SettingView(
        hapticEnabled: true,
        onDismiss: {},
        onPrivacyPolicy: {},
        onReview: {},
        onNotificationSettings: {}
    )
}

class SettingViewController: UIViewController {
    override func loadView() {
        view = UIView()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupSwiftUI()
    }

    private func setupSwiftUI() {
        let swiftUIView = SettingView(
            hapticEnabled: UserStore.hapticSetting,
            onDismiss: { [weak self] in self?.dismiss(animated: true) },
            onPrivacyPolicy: { [weak self] in self?.openPrivacyPolicy() },
            onReview: { [weak self] in self?.openAppStoreReview() },
            onNotificationSettings: { [weak self] in self?.openNotificationSettings() }
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

    private func openPrivacyPolicy() {
        let safariVC = SFSafariViewController(url: URL(string: "https://inouefood.github.io/inouefood/privacypolicy.html")!)
        present(safariVC, animated: true)
    }

    private func openAppStoreReview() {
        if let url = URL(string: "itms-apps://itunes.apple.com/app/id1457049172?action=write-review") {
            UIApplication.shared.open(url, options: [:])
        }
    }

    private func openNotificationSettings() {
        if let url = URL(string: UIApplication.openSettingsURLString) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
    }
}
