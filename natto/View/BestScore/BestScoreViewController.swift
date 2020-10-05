//
//  BestScoreViewController.swift
//  natto
//
//  Created by 佐川 晴海 on 2020/10/04.
//  Copyright © 2020 佐川　晴海. All rights reserved.
//

import UIKit
import SceneKit

class BestScoreViewController: UIViewController {
    @IBOutlet weak var titleLabel: UILabel! {
        didSet {
            titleLabel.text = localizeString(key: LocalizeKeys.BestScore.title)
        }
    }
    @IBOutlet weak var closeButton: UIButton! {
        didSet {
            closeButton.setTitle(localizeString(key: LocalizeKeys.BestScore.close), for: .normal)
            closeButton.layer.cornerRadius = 4
        }
    }
    
    @IBOutlet weak var shareButton: UIButton! {
        didSet {
            shareButton.setTitle(localizeString(key:LocalizeKeys.BestScore.share),
                                 for: .normal)
            shareButton.layer.cornerRadius = 4
        }
    }
    
    @IBOutlet weak var scoreBaseView: UIView! {
        didSet {
            scoreBaseView.layer.cornerRadius = 16
        }
    }
    @IBOutlet weak var scoreLabel: UILabel!
    
    lazy var bestScoreParticle:SCNView! = {
        let scene = SCNScene()

        let cameraNode = SCNNode()
        cameraNode.camera = SCNCamera()
        cameraNode.position = SCNVector3(x: 0, y: -6, z: 10)
        scene.rootNode.addChildNode(cameraNode)

        let confetti = SCNParticleSystem(named: "Contiffi.scnp", inDirectory: "")!
        scene.rootNode.addParticleSystem(confetti)

        let view = SCNView(frame: CGRect(x: 0,
                                         y: 0,
                                         width: self.view.frame.width,
                                         height: self.view.frame.height))
        view.scene = scene
        view.backgroundColor = UIColor.clear
        view.autoenablesDefaultLighting = true
        view.isUserInteractionEnabled = false
        return view
    }()
    
    private let bestScore: String
    
    init(score: Int) {
        bestScore = score.description
        super.init(nibName: String(describing: BestScoreViewController.self), bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        scoreLabel.text = bestScore
        self.view.backgroundColor = UIColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 0.7)
        self.view?.addSubview(bestScoreParticle)
    }
    
    @IBAction func dismissAction(_ sender: Any) {
        self.bestScoreParticle.removeFromSuperview()
        self.dismiss(animated: false, completion: nil)
    }

    @IBAction func shareAction(_ sender: Any) {
        
        let activityItems: [Any] = [SNSShareData.shared.message]
        let activityVc = UIActivityViewController(activityItems: activityItems, applicationActivities: nil)
        activityVc.modalPresentationStyle = .fullScreen
        self.present(activityVc, animated: true, completion: nil)
    }
    
}
