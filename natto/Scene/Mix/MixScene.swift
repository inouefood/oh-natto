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
    //MARK: - NodeInitialize
    
    lazy var nattoSprite:[SKSpriteNode] = {
        var sprites: [SKSpriteNode] = []
        for _ in 0..<Constant.SpriteCount.natto{
            let r = CGFloat(arc4random_uniform(UInt32(2.0 * Double.pi)))
            
            let nattoBody = SKPhysicsBody().make(circleOfRadius: width/40, category: Constant.CollisionBody.natto, contact: Constant.CollisionBody.ohashi, isGravity: false)
            let natto = SKSpriteNode(image: "mame", pos: CGPoint(x: randX, y: randY), body: nattoBody, rotate: r, size: CGSize(width: width/15, height: width/15))
            sprites.append(natto)
        }
        return sprites
    }()

    lazy var ohashi = SKSpriteNode(image: "ohashi", pos: CGPoint(x: self.frame.midX, y: self.frame.midY), body: SKPhysicsBody().make(circleOfRadius: width/20, category: Constant.CollisionBody.ohashi, contact: Constant.CollisionBody.natto, isGravity: false))
    
    // MARK: - Priperty
    
    var stickyLevel:Int = 0
    var cells = [Int](repeating: 0, count: 108)
    var timer:Timer?
    
    fileprivate lazy var presenter: MixPresenter! = {
        let presenter = MixPresenterImpl(output: self, model: MixModel())
        presenter.loadEffectAudio1(resourceName: "voice_5", resourceType: "wav")
        presenter.loadEffectAudio2(resourceName: "voice_5_pitchup", resourceType: "wav")
        return presenter
    }()
    
    //MARK: - Initializer
    
    override init(size: CGSize) {
        super.init(size: size)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - LifeCycle
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
        
        self.addChild(ohashi)
        nattoSprite.forEach({
            self.addChild($0)
        })
    }
    // MARK:- Event
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        presenter.playEffect1()
        presenter.playEffect2()
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        let pos = touches.first!.location(in: self)
        presenter.updateOhashiPosition(touchPosX: Float(pos.x), touchPosY: Float(pos.y), ohashiRadius: Float(width/20))
    }
    
    @objc func timerCounter(){
        presenter.stopEffect1()
        presenter.stopEffect2()
        
        self.timer?.invalidate()
        let scene = PullNattoScene(size: self.size, sticky: stickyLevel)
        self.view!.presentScene(scene)
    }
}

// MARK: - SKPhysicsContactDelegate

extension MixScene: SKPhysicsContactDelegate {
    //衝突した時に呼ばれる関数
    func didBegin(_ contact: SKPhysicsContact) {
        let pos: CGPoint? = presenter.contactOhashiToNatto(contact: contact)
        guard pos != nil else { return }
        addStickyLine(pos: pos!)
        stickyLevel += 1
    }
    
    func addStickyLine(pos: CGPoint) {
        let stickyPath = CGMutablePath().make(start: ohashi.position, end: pos)
        let stickyLine = SKShapeNode(path: stickyPath, color: .white, lineWid: 4, alpha: 0.2, zPos: 1.0, isInteractive: false)
        self.addChild(stickyLine)
    }
}

extension MixScene: MixPresenterOutput {
    func showUpdateOhashi(objPos: ObjectPosition) {
        ohashi.position = CGPoint(x: CGFloat(objPos.x), y: CGFloat(objPos.y))
    }
}
