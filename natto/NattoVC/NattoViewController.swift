//
//  NattoViewController.swift
//  natto
//
//  Created by 佐川晴海 on 2019/04/12.
//  Copyright © 2019 佐川　晴海. All rights reserved.
//

import UIKit
import SpriteKit

class NattoViewController: UIViewController {

    
    override func loadView() {
        // viewをSKViewに設定
        let skView = SKView(frame: UIScreen.main.bounds)
        self.view = skView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let skView = self.view as! SKView
        skView.ignoresSiblingOrder = true
        let size = CGSize(width: skView.bounds.size.width*2, height: skView.bounds.size.height*2)
        let scene = GameScene(size: size)
        skView.presentScene(scene)
    }
}
