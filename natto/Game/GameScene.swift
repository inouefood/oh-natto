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
    var timer:Timer?

    var nattoSprite:[SKSpriteNode] = []
    var nattoCount = 400
    let ohashi = SKSpriteNode(imageNamed: "ohashi")
    var stickyLevel:Int = 0
    var cells = [Int](repeating: 0, count: 108)
    var count = 0
    let ohashiCategory: UInt32 = 0x1 << 0
    let nattoCategory: UInt32 = 0x1 << 1
    var presenter: GamePresenter = GamePresenterImpl()
    
    override func didMove(to view: SKView) {
        // init
        presenter.loadEffectAudio1(resourceName: "voice_5", resourceType: "wav")
        presenter.loadEffectAudio2(resourceName: "voice_5_pitchup", resourceType: "wav")
        //衝突判定のデリゲートをselfにする
        self.physicsWorld.contactDelegate = self
        
        self.physicsWorld.gravity = CGVector(dx: 0, dy: 0)
        self.physicsBody = SKPhysicsBody(edgeLoopFrom: self.frame)

        //タイマー
        self.timer = Timer.scheduledTimer(timeInterval: 10, target: self, selector: #selector(GameScene.timerCounter), userInfo: nil, repeats: true)
        //原点の変更
        self.anchorPoint = CGPoint(x: 0, y: 0)
        self.backgroundColor = SKColor.gray
        
        //お箸
        ohashi.physicsBody = SKPhysicsBody(circleOfRadius: 50)
        //お箸の初期ポジションを画面外設定
        ohashi.position = CGPoint(x: self.frame.midX, y: self.frame.midY)
        ohashi.name = "ohashi"
        ohashi.physicsBody?.categoryBitMask = ohashiCategory
        ohashi.physicsBody?.contactTestBitMask = nattoCategory
        self.addChild(ohashi)
        
        for _ in 0..<nattoCount{
            let natto = SKSpriteNode(imageNamed:"mame")
            let X = Int(arc4random_uniform(UInt32(self.frame.size.width)))
            let Y = Int(arc4random_uniform(UInt32(self.frame.size.height)))
            let r = CGFloat(arc4random_uniform(UInt32(2.0 * Double.pi)))
            natto.position = CGPoint(x: X, y: Y)
            natto.physicsBody = SKPhysicsBody(circleOfRadius: 20)
            natto.physicsBody!.affectedByGravity = false
            natto.zRotation = r
            natto.name = "natto"
            natto.physicsBody?.categoryBitMask = nattoCategory
            natto.physicsBody?.contactTestBitMask = ohashiCategory
            self.addChild(natto)
            nattoSprite.append(natto)
        }
    }
    
    func touchDown(atPoint pos : CGPoint) {
        presenter.playEffect1()
        presenter.playEffect2()
    }
    
    func touchMoved(toPoint pos : CGPoint) {
        print(pos)
        let px = pos.x
        let py = pos.y - 50
        ohashi.position = CGPoint(x: px, y: py)
    }
    
    func touchUp(atPoint pos : CGPoint) {
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchDown(atPoint: t.location(in: self)) }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchMoved(toPoint: t.location(in: self)) }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchUp(atPoint: t.location(in: self)) }
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchUp(atPoint: t.location(in: self)) }
    }
    
    override func update(_ currentTime: TimeInterval) {
        for i in 0..<nattoCount{
            if(nattoSprite[i].position.x > self.frame.size.width || nattoSprite[i].position.x < 0){
                let X = self.frame.size.width/2
                let Y = self.frame.size.height/2
                nattoSprite[i].position = CGPoint(x: X, y: Y)
            }
            if(nattoSprite[i].position.y > self.frame.size.height || nattoSprite[i].position.y < 0){
                let X = self.frame.size.width/2
                let Y = self.frame.size.height/2
                nattoSprite[i].position = CGPoint(x: X, y: Y)
            }
        }
    }
    
    @objc func timerCounter(){
        presenter.stopEffect1()
        presenter.stopEffect2()
        
        self.timer?.invalidate()
        let scene = PullNattoScene(size: self.size, sticky: stickyLevel)
        scene.scaleMode = SKSceneScaleMode.resizeFill
        self.view!.presentScene(scene)
    }
    
    //衝突した時に呼ばれる関数
    func didBegin(_ contact: SKPhysicsContact) {
        var firstBody, secondBody: SKPhysicsBody
        
        if contact.bodyA.categoryBitMask < contact.bodyB.categoryBitMask {
            firstBody = contact.bodyA
            secondBody = contact.bodyB
        } else {
            firstBody = contact.bodyA
            secondBody = contact.bodyB
        }
        //衝突時の処理
        if firstBody.categoryBitMask & ohashiCategory != 0 && secondBody.categoryBitMask & nattoCategory != 0 {
            let path = CGMutablePath()
            path.move(to: ohashi.position)
            path.addLine(to:(secondBody.node?.position)!)
            path.closeSubpath()
            count+=1
            if count < 500{
            count = 0
            }
            let curve = SKShapeNode(path: path)
            curve.strokeColor = .white
            curve.lineWidth = 4
            curve.alpha = 0.2
            curve.zPosition = 1.0
            curve.name = "curve"
            curve.isUserInteractionEnabled = false
            self.addChild(curve)
            stickyLevel += 1
        }
    }
}

