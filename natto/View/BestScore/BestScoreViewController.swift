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
    
    @IBOutlet weak var scoreBaseView: UIView! {
        didSet {
            scoreBaseView.layer.cornerRadius = 16
        }
    }
    
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
    

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .clear
        
//        self.view?.addSubview(bestScoreParticle)

    }
    
}
