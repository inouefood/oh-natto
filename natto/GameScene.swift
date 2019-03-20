//
//  GameScene.swift
//  natto
//
//  Created by 佐川　晴海 on 2018/03/09.
//  Copyright © 2018年 佐川　晴海. All rights reserved.
//
import SpriteKit
import GameplayKit

class GameScene: SKScene, SKPhysicsContactDelegate {
    override func didMove(to view: SKView) {
        let scene = MixScene(size: self.size)
        self.view!.presentScene(scene)
        // init
//        presenter.loadEffectAudio1(resourceName: "voice_5", resourceType: "wav")
//        presenter.loadEffectAudio2(resourceName: "voice_5_pitchup", resourceType: "wav")
//        //衝突判定のデリゲートをselfにする
//        self.physicsWorld.contactDelegate = self
//
//        self.physicsWorld.gravity = CGVector(dx: 0, dy: 0)
//        self.physicsBody = SKPhysicsBody(edgeLoopFrom: self.frame)
//
//        //タイマー
//        self.timer = Timer.scheduledTimer(timeInterval: 10, target: self, selector: #selector(GameScene.timerCounter), userInfo: nil, repeats: true)
//        //原点の変更
//        self.anchorPoint = CGPoint(x: 0, y: 0)
//        self.backgroundColor = SKColor.gray
//
//        //お箸
//        ohashi.physicsBody = SKPhysicsBody(circleOfRadius: 50)
//        //お箸の初期ポジションを画面外設定
//        ohashi.position = CGPoint(x: self.frame.midX, y: self.frame.midY)
//        ohashi.name = "ohashi"
//        ohashi.physicsBody?.categoryBitMask = ohashiCategory
//        ohashi.physicsBody?.contactTestBitMask = nattoCategory
//        self.addChild(ohashi)
//
//        for _ in 0..<nattoCount{
//            let natto = SKSpriteNode(imageNamed:"mame")
//            let X = Int(arc4random_uniform(UInt32(self.frame.size.width)))
//            let Y = Int(arc4random_uniform(UInt32(self.frame.size.height)))
//            let r = CGFloat(arc4random_uniform(UInt32(2.0 * Double.pi)))
//            natto.position = CGPoint(x: X, y: Y)
//            natto.physicsBody = SKPhysicsBody(circleOfRadius: 20)
//            natto.physicsBody!.affectedByGravity = false
//            natto.zRotation = r
//            natto.name = "natto"
//            natto.physicsBody?.categoryBitMask = nattoCategory
//            natto.physicsBody?.contactTestBitMask = ohashiCategory
//            self.addChild(natto)
//            nattoSprite.append(natto)
//        }
    }
}

