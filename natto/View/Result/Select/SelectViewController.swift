//
//  SelectViewController.swift
//  natto
//
//  Created by 佐川 晴海 on 2020/10/13.
//  Copyright © 2020 佐川　晴海. All rights reserved.
//

import UIKit
import SwiftUI
import GameKit

// MARK: - SwiftUI View

private struct SelectView: View {
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

// MARK: - UIViewController

private class PassThroughView: UIView {
    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        let result = super.hitTest(point, with: event)
        return result == self ? nil : result
    }
}

class SelectViewController: UIViewController {
    var shareImage: UIImage?

    override func loadView() {
        view = PassThroughView()
        view.backgroundColor = .clear
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupSwiftUI()
    }

    private func setupSwiftUI() {
        let swiftUIView = SelectView(
            onDismiss: { [weak self] in
                self?.willMove(toParent: nil)
                self?.view.removeFromSuperview()
                self?.removeFromParent()
            },
            onStorePage: { [weak self] in self?.openStorePage() },
            onLeaderBoard: { [weak self] in self?.openLeaderBoard() },
            onTotalEatPage: { [weak self] in self?.openTotalEatPage() },
            onSettingPage: { [weak self] in self?.openSettingPage() },
            onShare: { [weak self] in self?.shareAction() }
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

    private func openStorePage() {
        let vc = StoreViewController()
        vc.modalPresentationStyle = .overCurrentContext
        present(vc, animated: true)
    }

    private func openLeaderBoard() {
        let player = GKLocalPlayer.local
        if player.isAuthenticated {
            openLeaderBordScoreLanking()
        } else {
            authenticateLocalPlayer()
        }
    }

    private func openTotalEatPage() {
        let vc = TotalEatViewController()
        vc.modalPresentationStyle = .overCurrentContext
        present(vc, animated: false)
    }

    private func openSettingPage() {
        present(SettingViewController(), animated: true)
    }

    private func shareAction() {
        var activityItems: [Any] = []
        if let image = shareImage {
            activityItems = ["\(localizeString(key: LocalizeKeys.Result.tweet)) https://itunes.apple.com/us/app/oh-natto/id1457049172?mt=8", image]
        } else {
            activityItems = ["\(localizeString(key: LocalizeKeys.Result.tweet)) https://itunes.apple.com/us/app/oh-natto/id1457049172?mt=8"]
        }
        let activityVc = UIActivityViewController(activityItems: activityItems, applicationActivities: nil)
        if traitCollection.horizontalSizeClass == .regular && traitCollection.verticalSizeClass == .regular {
            activityVc.popoverPresentationController?.sourceView = self.view
            activityVc.popoverPresentationController?.sourceRect = CGRect(x: self.view.bounds.size.width,
                                                                          y: self.view.bounds.size.height,
                                                                          width: 1.0,
                                                                          height: 1.0)
        }
        present(activityVc, animated: true)
    }

    private func authenticateLocalPlayer() {
        let player = GKLocalPlayer.local
        player.authenticateHandler = { [weak self] (viewController, _) in
            if let vc = viewController {
                self?.present(vc, animated: true)
            }
        }
    }

    private func openLeaderBordScoreLanking() {
        let gcvc = GKGameCenterViewController(leaderboardID: Constant.LeaderBoard.id,
                                              playerScope: .global,
                                              timeScope: .allTime)
        gcvc.gameCenterDelegate = self
        present(gcvc, animated: true)
    }
}

extension SelectViewController: GKGameCenterControllerDelegate {
    func gameCenterViewControllerDidFinish(_ gameCenterViewController: GKGameCenterViewController) {
        dismiss(animated: true)
    }
}
