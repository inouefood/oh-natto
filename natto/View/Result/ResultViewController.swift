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
                ZStack(alignment: .topLeading) {
                    Image("tipsBoard")
                        .resizable()
                        .scaledToFill()
                        .frame(width: geo.size.width, height: geo.size.height * 0.4)
                        .clipped()

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
                .frame(height: geo.size.height * 0.4)

                ZStack {
                    Image("scoreMame")
                        .resizable()
                        .scaledToFill()
                        .frame(width: geo.size.width, height: geo.size.height * 0.6)
                        .clipped()

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
                .frame(height: geo.size.height * 0.6)
            }
        }
        .background(Color("background"))
    }
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

        // Info / select button
        let infoButton = UIButton(type: .custom)
        infoButton.setImage(UIImage(named: "infoIcon"), for: .normal)
        infoButton.translatesAutoresizingMaskIntoConstraints = false
        infoButton.addTarget(self, action: #selector(openSelectTapped), for: .touchUpInside)
        view.addSubview(infoButton)

        NSLayoutConstraint.activate([
            screenShotView.topAnchor.constraint(equalTo: view.topAnchor),
            screenShotView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
            screenShotView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor),
            screenShotView.bottomAnchor.constraint(equalTo: retryButton.topAnchor, constant: -8),

            retryButton.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 16),
            retryButton.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -16),
            retryButton.heightAnchor.constraint(equalToConstant: 36),

            infoButton.topAnchor.constraint(equalTo: retryButton.bottomAnchor, constant: 20),
            infoButton.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -40),
            infoButton.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor, constant: -32),
            infoButton.widthAnchor.constraint(equalToConstant: 46),
            infoButton.heightAnchor.constraint(equalToConstant: 46),
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

    @objc private func openSelectTapped() {
        let vc = SelectViewController()
        vc.shareImage = screenShotView.convertToImage()
        vc.modalPresentationStyle = .overCurrentContext
        present(vc, animated: false)
    }
}
