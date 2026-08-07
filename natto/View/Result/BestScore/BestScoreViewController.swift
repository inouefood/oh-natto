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

// MARK: - UIViewController

class BestScoreViewController: UIViewController {
    private var bestScoreParticle: SCNView?
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
        if let particle = bestScoreParticle {
            view.addSubview(particle)
        }
    }

    private func setupSwiftUI() {
        let swiftUIView = BestScoreScreen(
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

        guard let confetti = SCNParticleSystem(named: "Contiffi.scnp", inDirectory: "") else { return }
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
        bestScoreParticle?.removeFromSuperview()
        dismiss(animated: false, completion: nil)
    }

    private func shareAction() {
        bestScoreParticle?.removeFromSuperview()
        let shareImage = view.convertToImage()
        let text = "\(localizeString(key: LocalizeKeys.Result.tweet)) https://itunes.apple.com/us/app/oh-natto/id1457049172?mt=8"
        let activityItems: [Any] = [shareImage, text]
        let activityVc = UIActivityViewController(activityItems: activityItems, applicationActivities: nil)
        DispatchQueue.main.async {
            activityVc.modalPresentationStyle = .fullScreen
            self.present(activityVc, animated: true) {
                self.createParticle()
                if let particle = self.bestScoreParticle {
                    self.view.addSubview(particle)
                }
            }
        }
    }
}
