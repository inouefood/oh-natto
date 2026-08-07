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

// MARK: - UIViewController

class SettingViewController: UIViewController {
    override func loadView() {
        view = UIView()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupSwiftUI()
    }

    private func setupSwiftUI() {
        let swiftUIView = SettingScreen(
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
