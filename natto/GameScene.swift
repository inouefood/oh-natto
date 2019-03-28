//
//  GameScene.swift
//  natto
//
//  Created by 佐川　晴海 on 2018/03/09.
//  Copyright © 2018年 佐川　晴海. All rights reserved.
//
import SpriteKit
import GameplayKit
import UIKit

class GameScene: SKScene {
    let tutorialButton = UIButton()
    let scrollView = UIScrollView()
    let closeButton = UIButton()
    
    var startLabel = SKLabelNode(fontNamed: "Verdana-bold")
    override func didMove(to view: SKView) {
        
        

        
        

        tutorialButton.backgroundColor = .red
        tutorialButton.frame.size = CGSize(width: 80, height: 80)
        tutorialButton.layer.position = CGPoint(x: (self.view?.frame.width)! - tutorialButton.frame.width * 1.1, y: 100)
        tutorialButton.titleLabel!.font = UIFont.systemFont(ofSize: 40)
        tutorialButton.setTitle("?", for: .normal)
        tutorialButton.layer.cornerRadius = tutorialButton.frame.width/2
        tutorialButton.addTarget(self, action: #selector(showTutorial(_:)), for: .touchDown)
        view.addSubview(tutorialButton)
        
        
        
        for _ in 0...3 {
            let mame = SKSpriteNode(imageNamed: "mame")
            mame.position = CGPoint(x:CGFloat(Int.random(in: 100...Int(self.frame.width))-100),
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
    
    @objc func showTutorial(_ sender:UIButton){
        print("tap")
        scrollView.frame = CGRect(x: 25, y: 50, width: (self.view?.frame.width)! - 50, height: (self.view?.frame.height)! - 100)
        scrollView.backgroundColor = .gray
        scrollView.contentSize = CGSize(width: (self.view?.frame.width)! - 100, height: 3000)
        self.view?.addSubview(scrollView)
        
        closeButton.frame.size = CGSize(width: (self.view?.frame.width)!/9, height:  (self.view?.frame.width)!/9)
        
        closeButton.layer.position = CGPoint(x: self.view!.frame.width/2, y: self.view!.frame.height - 100)
        closeButton.backgroundColor = .red
        closeButton.layer.cornerRadius = closeButton.frame.width/2
        closeButton.setTitle("X", for: .normal)
        closeButton.titleLabel!.font = UIFont.systemFont(ofSize: 40)
        closeButton.addTarget(self, action: #selector(closeTutorial(_:)), for: .touchDown)
        self.view!.addSubview(closeButton)
    }
    @objc func closeTutorial(_ sender: UIButton){
        closeButton.removeFromSuperview()
        scrollView.removeFromSuperview()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touches:AnyObject in touches{
            print(self.atPoint(touches.previousLocation(in: self)))
            let location = touches.previousLocation(in: self)
            let touchNode = self.atPoint(location)
            if touchNode == startLabel{
                tutorialButton.removeFromSuperview()
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

