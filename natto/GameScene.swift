//
//  GameScene.swift
//  natto
//
//  Created by 佐川　晴海 on 2018/03/09.
//  Copyright © 2018年 佐川　晴海. All rights reserved.
//
import SpriteKit
import GameplayKit

class GameScene: SKScene {
    var startLabel = SKLabelNode(fontNamed: "Verdana-bold")
    override func didMove(to view: SKView) {
        self.anchorPoint = CGPoint(x: 0, y: 0)
        print(self.frame.midX)
        startLabel.fontSize = 100
        startLabel.fontColor = .white
        startLabel.text = "START"
        startLabel.position = CGPoint(x: self.frame.midX, y: self.frame.midY/3)
        self.addChild(startLabel)
       
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touches:AnyObject in touches{
            print(self.atPoint(touches.previousLocation(in: self)))
            let location = touches.previousLocation(in: self)
            let touchNode = self.atPoint(location)
            if touchNode == startLabel{
                let scene = MixScene(size: self.size)
                self.view!.presentScene(scene)
            }
        }
    }
}

