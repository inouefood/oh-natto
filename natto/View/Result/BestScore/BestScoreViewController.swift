//
//  BestScoreViewController.swift
//  natto
//
//  Created by 佐川 晴海 on 2020/10/04.
//  Copyright © 2020 佐川　晴海. All rights reserved.
//

import UIKit
import SwiftUI
import SceneKit

// MARK: - SwiftUI View

private struct BestScoreView: View {
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
                        .font(.system(size: 30, weight: .bold))
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.horizontal, 8)
                        .padding(.top, 4)

                    Image("bestScore")
                        .resizable()
                        .scaledToFit()
                        .padding(.horizontal, 16)
                        .padding(.top, 4)

                    Text(score)
                        .font(.system(size: 32))
                        .frame(maxWidth: .infinity)
                        .padding(.horizontal, 16)
                        .padding(.top, 4)
                        .padding(.bottom, 8)
                }

                HStack(spacing: 8) {
                    Button(action: onDismiss) {
                        Text(localizeString(key: LocalizeKeys.BestScore.close))
                            .font(.custom("HelveticaNeue", size: 22))
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity, minHeight: 45)
                            .background(Color.orange)
                            .cornerRadius(4)
                    }
                    .buttonStyle(.plain)

                    Button(action: onShare) {
                        Text(localizeString(key: LocalizeKeys.BestScore.share))
                            .font(.custom("HelveticaNeue", size: 22))
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

// MARK: - UIViewController

#Preview {
    BestScoreView(
        score: "1,234",
        onDismiss: {},
        onShare: {}
    )
}

class BestScoreViewController: UIViewController {
    private var bestScoreParticle: SCNView!
    private let bestScore: String

    init(score: Int) {
        bestScore = score.description
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func loadView() {
        view = UIView()
        view.backgroundColor = .clear
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupSwiftUI()
        createParticle()
        view.addSubview(bestScoreParticle)
    }

    private func setupSwiftUI() {
        let swiftUIView = BestScoreView(
            score: bestScore,
            onDismiss: { [weak self] in self?.dismissAction() },
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

    private func createParticle() {
        bestScoreParticle = nil

        let scene = SCNScene()

        let cameraNode = SCNNode()
        cameraNode.camera = SCNCamera()
        cameraNode.position = SCNVector3(x: 0, y: -6, z: 10)
        scene.rootNode.addChildNode(cameraNode)

        let confetti = SCNParticleSystem(named: "Contiffi.scnp", inDirectory: "")!
        scene.rootNode.addParticleSystem(confetti)
        let screenSize: CGSize = UIScreen.main.nativeBounds.size
        let scnView = SCNView(frame: CGRect(x: 0,
                                            y: 0,
                                            width: screenSize.width,
                                            height: screenSize.height))
        scnView.scene = scene
        scnView.backgroundColor = UIColor.clear
        scnView.autoenablesDefaultLighting = true
        scnView.isUserInteractionEnabled = false
        bestScoreParticle = scnView
    }

    private func dismissAction() {
        bestScoreParticle.removeFromSuperview()
        dismiss(animated: false, completion: nil)
    }

    private func shareAction() {
        bestScoreParticle.removeFromSuperview()
        let shareImage = view.convertToImage()
        let text = "\(localizeString(key: LocalizeKeys.Result.tweet)) https://itunes.apple.com/us/app/oh-natto/id1457049172?mt=8"
        let activityItems: [Any] = [shareImage, text]
        let activityVc = UIActivityViewController(activityItems: activityItems, applicationActivities: nil)
        DispatchQueue.main.async {
            activityVc.modalPresentationStyle = .fullScreen
            self.present(activityVc, animated: true) {
                self.createParticle()
                self.view.addSubview(self.bestScoreParticle)
            }
        }
    }
}
