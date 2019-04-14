//
//  MixScene.swift
//  natto
//
//  Created by 佐川晴海 on 2019/03/20.
//  Copyright © 2019 佐川　晴海. All rights reserved.
//

import SpriteKit
import GameplayKit

class MixScene: SKScene{
    var timer:Timer?
    
    var nattoSprite:[SKSpriteNode] = []
    var ohashi = SKSpriteNode()
    var stickyLevel:Int = 0
    var cells = [Int](repeating: 0, count: 108)
    
    fileprivate lazy var presenter: MixPresenter! = {
        let presenter = MixPresenterImpl(output: self, model: MixModel())
        presenter.loadEffectAudio1(resourceName: "voice_5", resourceType: "wav")
        presenter.loadEffectAudio2(resourceName: "voice_5_pitchup", resourceType: "wav")
        return presenter
    }()
    
    override init(size: CGSize) {
        super.init(size: size)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func didMove(to view: SKView) {
        //衝突判定のデリゲートをselfにする
        self.physicsWorld.contactDelegate = self
        self.physicsWorld.gravity = CGVector(dx: 0, dy: 0)
        self.physicsBody = SKPhysicsBody(edgeLoopFrom: self.frame)
        
        //タイマー
        self.timer = Timer.scheduledTimer(timeInterval: 10, target: self, selector: #selector(MixScene.timerCounter), userInfo: nil, repeats: true)
        //原点の変更
        self.anchorPoint = CGPoint(x: 0, y: 0)
        self.backgroundColor = SKColor.gray
        
        //お箸
        let ohashiBody = SKPhysicsBody().make(circleOfRadius: 50, category: Constant.CollisionBody.ohashi, contact: Constant.CollisionBody.natto, isGravity: false)
        ohashi = SKSpriteNode(image: "ohashi", pos: CGPoint(x: self.frame.midX, y: self.frame.midY), body: ohashiBody)
        self.addChild(ohashi)
        
        //納豆
        for _ in 0..<Constant.SpriteCount.natto{
            let X = Int(arc4random_uniform(UInt32(self.frame.size.width)))
            let Y = Int(arc4random_uniform(UInt32(self.frame.size.height)))
            let r = CGFloat(arc4random_uniform(UInt32(2.0 * Double.pi)))
            
            let nattoBody = SKPhysicsBody().make(circleOfRadius: 20, category: Constant.CollisionBody.natto, contact: Constant.CollisionBody.ohashi, isGravity: false)
            let natto = SKSpriteNode(image: "mame", pos: CGPoint(x: X, y: Y), body: nattoBody, rotate: r)
            self.addChild(natto)
            nattoSprite.append(natto)
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        presenter.playEffect1()
        presenter.playEffect2()
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        let pos = touches.first!.location(in: self)
        presenter.updateOhashiPosition(touchPosX: Float(pos.x), touchPosY: Float(pos.y), ohashiRadius: 50)
    }
    
    override func update(_ currentTime: TimeInterval) {
    }
    
    @objc func timerCounter(){
        presenter.stopEffect1()
        presenter.stopEffect2()
        
        self.timer?.invalidate()
        let scene = PullNattoScene(size: self.size, sticky: stickyLevel)
        self.view!.presentScene(scene)
    }
}

extension MixScene: SKPhysicsContactDelegate {
    //衝突した時に呼ばれる関数
    func didBegin(_ contact: SKPhysicsContact) {
        var firstBody, secondBody: SKPhysicsBody
        
        if contact.bodyA.categoryBitMask < contact.bodyB.categoryBitMask {
            firstBody = contact.bodyA
            secondBody = contact.bodyB
        } else {
            firstBody = contact.bodyB
            secondBody = contact.bodyA
        }
        //衝突時の処理
        if firstBody.categoryBitMask & Constant.CollisionBody.ohashi != 0 && secondBody.categoryBitMask & Constant.CollisionBody.natto != 0 {
            guard (secondBody.node?.position.x != 0.0 && secondBody.node?.position.y != 0.0) else { return }
            addStickyLine(pos: secondBody.node!.position)
            stickyLevel += 1
        }
    }
    func addStickyLine(pos: CGPoint){
        let path = CGMutablePath()
        path.move(to: ohashi.position)
        path.addLine(to: pos)
        path.closeSubpath()
        let curve = SKShapeNode(path: path)
        curve.strokeColor = .white
        curve.lineWidth = 4
        curve.alpha = 0.2
        curve.zPosition = 1.0
        curve.name = "curve"
        curve.isUserInteractionEnabled = false
        self.addChild(curve)
    }
}

extension MixScene: MixPresenterOutput {
    func showUpdateOhashi(objPos: ObjectPosition) {
        ohashi.position = CGPoint(x: CGFloat(objPos.x), y: CGFloat(objPos.y))
    }
}
