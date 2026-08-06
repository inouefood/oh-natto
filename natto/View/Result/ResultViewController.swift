//
//  ResultViewController.swift
//  natto
//
//  Created by 佐川 晴海 on 2020/10/04.
//  Copyright © 2020 佐川　晴海. All rights reserved.
//

import UIKit
import SwiftUI
import StoreKit
import AVFoundation
import GameKit

// MARK: - SwiftUI Content for screenshot area

private struct ResultScreenContent: View {
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
                            .font(.system(size: 22, weight: .medium))
                            .foregroundColor(.white)
                        Text(tipsText)
                            .font(.system(size: 20))
                            .foregroundColor(.white)
                            .multilineTextAlignment(.center)
                            .frame(maxWidth: .infinity)
                            .minimumScaleFactor(0.75)
                            .lineLimit(3)
                    }
                    .padding(.leading, 64)
                    .padding(.trailing, 32)
                    .padding(.top, 42)
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
                            .font(.system(size: 24, weight: .medium))
                            .foregroundColor(.white)
                            .minimumScaleFactor(0.5)
                        Text(scoreText)
                            .font(.system(size: 48, weight: .bold))
                            .foregroundColor(.white)
                    }
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            }
        }
        .background(Color("background"))
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

// MARK: - Bottom buttons bar

private struct ResultBottomButtonsView: View {
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

// MARK: - UIViewController

class ResultViewController: UIViewController {
    var audio: AVAudioPlayer!
    private let score: Int
    private let tipsList: [String] = [
        localizeString(key: LocalizeKeys.Tips.a),
        localizeString(key: LocalizeKeys.Tips.b),
        localizeString(key: LocalizeKeys.Tips.c),
        localizeString(key: LocalizeKeys.Tips.d),
        localizeString(key: LocalizeKeys.Tips.e),
        localizeString(key: LocalizeKeys.Tips.f),
        localizeString(key: LocalizeKeys.Tips.g),
        localizeString(key: LocalizeKeys.Tips.h),
        localizeString(key: LocalizeKeys.Tips.i),
        localizeString(key: LocalizeKeys.Tips.j),
        localizeString(key: LocalizeKeys.Tips.k),
        localizeString(key: LocalizeKeys.Tips.l),
        localizeString(key: LocalizeKeys.Tips.m),
        localizeString(key: LocalizeKeys.Tips.n),
        localizeString(key: LocalizeKeys.Tips.o),
        localizeString(key: LocalizeKeys.Tips.p),
    ]

    var dismissHandler: (() -> ())?
    let screenShotView = UIView()

    init(score: Int) {
        self.score = score
        UserStore.saveEatPoint(natto: score)
        UserStore.totalNattoCount += score
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func loadView() {
        view = UIView()
        view.backgroundColor = AppColor.background.color
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        loadAudio(resourceName: "natto_bgm_score.wav", resourceType: "")
        setupLayout()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        sendLeaderboardWithID(ID: Constant.LeaderBoard.id, rate: Int64(score))

        if UserStore.totalNattoCount > 1000 && UserStore.isNeedDisplayedReviewAlert {
            UserStore.isNeedDisplayedReviewAlert = false
            if let scene = view.window?.windowScene {
                AppStore.requestReview(in: scene)
            }
        }

        guard let bestScore = UserStore.bestScore else {
            UserStore.bestScore = score
            return
        }
        if score > bestScore {
            UserStore.bestScore = score
            let vc = BestScoreViewController(score: score)
            vc.modalPresentationStyle = .overCurrentContext
            present(vc, animated: false)
        }
    }

    // MARK: - Private

    private func setupLayout() {
        let safeArea = view.safeAreaLayoutGuide

        // Bottom buttons bar
        let bottomButtons = ResultBottomButtonsView(
            onLeaderBoard: { [weak self] in self?.openLeaderBoard() },
            onSettings: { [weak self] in self?.openSettingPage() },
            onStore: { [weak self] in self?.openStorePage() },
            onTotalEat: { [weak self] in self?.openTotalEatPage() },
            onShare: { [weak self] in self?.shareAction() }
        )
        let bottomHC = UIHostingController(rootView: bottomButtons)
        bottomHC.view.backgroundColor = .clear
        addChild(bottomHC)
        view.addSubview(bottomHC.view)
        bottomHC.view.translatesAutoresizingMaskIntoConstraints = false
        bottomHC.didMove(toParent: self)

        // screenShotView
        screenShotView.backgroundColor = AppColor.background.color
        screenShotView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(screenShotView)

        // SwiftUI content embedded inside screenShotView
        let content = ResultScreenContent(
            tipsTitle: localizeString(key: LocalizeKeys.Result.tipsTitle),
            tipsText: tipsList.randomElement() ?? "",
            scoreTitle: localizeString(key: LocalizeKeys.Result.scoreTitle),
            scoreText: String(score) + localizeString(key: LocalizeKeys.Result.score)
        )
        let contentHC = UIHostingController(rootView: content)
        contentHC.view.backgroundColor = .clear
        addChild(contentHC)
        screenShotView.addSubview(contentHC.view)
        contentHC.view.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            contentHC.view.topAnchor.constraint(equalTo: screenShotView.topAnchor),
            contentHC.view.leadingAnchor.constraint(equalTo: screenShotView.leadingAnchor),
            contentHC.view.trailingAnchor.constraint(equalTo: screenShotView.trailingAnchor),
            contentHC.view.bottomAnchor.constraint(equalTo: screenShotView.bottomAnchor),
        ])
        contentHC.didMove(toParent: self)

        // Retry button
        let retryButton = UIButton(type: .system)
        retryButton.titleLabel?.font = UIFont(name: "Verdana-bold", size: 35)
        retryButton.setTitle(localizeString(key: LocalizeKeys.Result.buttonRelpay), for: .normal)
        retryButton.setTitleColor(.white, for: .normal)
        retryButton.translatesAutoresizingMaskIntoConstraints = false
        retryButton.addTarget(self, action: #selector(retryTapped), for: .touchUpInside)
        view.addSubview(retryButton)

        NSLayoutConstraint.activate([
            bottomHC.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            bottomHC.view.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            bottomHC.view.bottomAnchor.constraint(equalTo: view.bottomAnchor),

            retryButton.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 16),
            retryButton.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -16),
            retryButton.heightAnchor.constraint(equalToConstant: 36),
            retryButton.bottomAnchor.constraint(equalTo: bottomHC.view.topAnchor, constant: -12),

            screenShotView.topAnchor.constraint(equalTo: view.topAnchor),
            screenShotView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
            screenShotView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor),
            screenShotView.bottomAnchor.constraint(equalTo: retryButton.topAnchor, constant: -8),
        ])
    }

    private func loadAudio(resourceName: String, resourceType: String) {
        let path = Bundle.main.path(forResource: resourceName, ofType: resourceType)
        let url = URL(fileURLWithPath: path!)
        do { try audio = AVAudioPlayer(contentsOf: url) }
        catch { fatalError() }
        audio.numberOfLoops = -1
        audio.prepareToPlay()
        audio.play()
    }

    func sendLeaderboardWithID(ID: String, rate: Int64) {
        guard GKLocalPlayer.local.isAuthenticated else {
            print("GameCenterにログインしていません")
            return
        }
        GKLeaderboard.submitScore(Int(rate), context: 0, player: GKLocalPlayer.local, leaderboardIDs: [ID]) { error in
            if let error = error {
                print("error: \(error)")
            }
        }
    }

    @objc private func retryTapped() {
        dismissHandler?()
    }

    // MARK: - Navigation

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
        let image = screenShotView.convertToImage()
        let text = "\(localizeString(key: LocalizeKeys.Result.tweet)) https://itunes.apple.com/us/app/oh-natto/id1457049172?mt=8"
        let activityVc = UIActivityViewController(activityItems: [text, image], applicationActivities: nil)
        if traitCollection.horizontalSizeClass == .regular && traitCollection.verticalSizeClass == .regular {
            activityVc.popoverPresentationController?.sourceView = view
            activityVc.popoverPresentationController?.sourceRect = CGRect(
                x: view.bounds.size.width, y: view.bounds.size.height, width: 1, height: 1
            )
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

extension ResultViewController: GKGameCenterControllerDelegate {
    func gameCenterViewControllerDidFinish(_ gameCenterViewController: GKGameCenterViewController) {
        dismiss(animated: true)
    }
}
