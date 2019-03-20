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
        for i in 0...3 {
            let mame = SKSpriteNode(imageNamed: "mame")
            

            
            mame.position = CGPoint(x:CGFloat(Int.random(in: 50...Int(self.frame.width))-50),
                                    y: CGFloat(Int.random(in: Int(self.frame.height)...Int(self.frame.height+100 ))))
            mame.physicsBody = SKPhysicsBody(rectangleOf: mame.size)
            mame.physicsBody?.categoryBitMask = 0x1 << 1
            mame.physicsBody?.collisionBitMask = 0x1 << 0
            self.addChild(mame)
        }
        
        
        self.anchorPoint = CGPoint(x: 0, y: 0)
        self.physicsWorld.gravity = CGVector(dx: 0.0, dy: -1.5)
        startLabel.fontSize = 100
        startLabel.fontColor = .white
        startLabel.text = "START"
        startLabel.physicsBody = SKPhysicsBody(circleOfRadius: startLabel.frame.maxX)
        startLabel.physicsBody?.affectedByGravity = false
        startLabel.physicsBody?.categoryBitMask = 0x1 << 0
        startLabel.physicsBody?.collisionBitMask = 0x1 << 2
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
            } else {
                let mame = SKSpriteNode(imageNamed: "mame")
                mame.position = location
                mame.physicsBody = SKPhysicsBody(rectangleOf: mame.size)
                mame.physicsBody?.categoryBitMask = 0x1 << 1
                mame.physicsBody?.collisionBitMask = 0x1 << 0
                self.addChild(mame)
            }
        }
    }
}

