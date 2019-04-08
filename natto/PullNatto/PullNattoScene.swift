
//
//  PullNattoScene.swift
//  natto
//
//  Created by 佐川　晴海 on 2018/03/10.
//  Copyright © 2018年 佐川　晴海. All rights reserved.
//
import SpriteKit
import GameplayKit

class PullNattoScene: SKScene{
    
    var timer:Timer?
    var score:Int = 0
    var count = 0
    var stickyLevel:Float
    var nattoCount = 500
    var nattoSprite:[SKSpriteNode] = []
    let ohashi = SKSpriteNode(imageNamed: "pullOhashi")
    var mameflag = false
    fileprivate lazy var presenter: PullNattoPresenter! = {
        let presenter = PullNattoPresenterImpl(output: self, model: PullNattoModel())
        presenter.loadBgmAudio(resourceName:"natto_bgm_game", resourceType: "wav")
        presenter.loadEffectAudio(resourceName: "paku", resourceType: "wav")
        return presenter
    }()
    
    var targetNatto: SKSpriteNode!
    
    init(size: CGSize, sticky: Int) {
        stickyLevel = Float(sticky) * 0.0002
        super.init(size: size)
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func didMove(to view: SKView) {
        //音楽の再生
        presenter.playBgm()
        //タイマー
        self.timer = Timer.scheduledTimer(timeInterval: 25, target: self, selector: #selector(MixScene.timerCounter), userInfo: nil, repeats: true)
        //原点の変更
        self.anchorPoint = CGPoint(x: 0, y: 0)
        self.backgroundColor = SKColor.gray
        
        //ワールドの設定
        self.physicsWorld.gravity = CGVector(dx: 0.0, dy: -0.5)
        self.physicsBody = SKPhysicsBody(edgeLoopFrom: self.frame)
        
        addMouthImage()
        
        let ohashiScale = (self.view?.bounds.width)! / ohashi.size.width
        //お箸の初期ポジション
        ohashi.position = CGPoint(x: self.frame.midX, y: self.frame.midY)
        ohashi.size = CGSize(width: ohashi.size.width * ohashiScale / 2, height: ohashi.size.height * ohashiScale/2 )
        ohashi.zPosition = 1.25
        self.addChild(ohashi)
        
        //納豆の初期設定
        for _ in 0..<nattoCount{
            let natto = SKSpriteNode(imageNamed:"mame")
            let X = Int(arc4random_uniform(UInt32(self.frame.size.width)))
            let Y = Int(arc4random_uniform(UInt32(self.frame.size.height / 4.0)))
            let r = CGFloat(arc4random_uniform(UInt32(2.0 * .pi)))
            natto.position = CGPoint(x: X, y: Y)
            natto.physicsBody = SKPhysicsBody(circleOfRadius: 20)
            natto.zRotation = r
            self.addChild(natto)
            nattoSprite.append(natto)
        }
    }
    func addMouthImage() {
        let mouth = SKSpriteNode(imageNamed: "pakupaku")
        let scale = (self.view?.bounds.width)! / mouth.size.width
        //お口
        mouth.position = CGPoint(x: self.frame.midX, y: self.frame.maxY - (mouth.size.height * scale * 2.0) / 2.0)
        mouth.size = CGSize(width: self.frame.size.width, height: mouth.size.height * scale * 2.0)
        mouth.zPosition = 1.0
        self.addChild(mouth)
    }
    
    func touchMoved(toPoint pos : CGPoint) {
        ohashi.position = CGPoint(x: pos.x, y: pos.y)
    }

    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchMoved(toPoint: t.location(in: self)) }
    }
    @objc func timerCounter(){
        self.timer?.invalidate()
        
        for i in 0..<nattoSprite.count {
            if (self.frame.size.height < nattoSprite[i].position.y) {
                score += 1
            }
        }
        presenter = nil
        let scene = ResultScene(size: self.size, score: score)
        self.view!.presentScene(scene)
    }
    
    override func update(_ currentTime: TimeInterval) {
        for i in 0..<nattoCount{
            if (self.frame.size.height * 0.80 < nattoSprite[i].position.y) {
                nattoSprite[i].position.y = self.frame.size.height + 100
                mameflag = true
                if(mameflag){
                    if(count > 1){
                        continue
                    }else{
                        presenter.playEffect()
                    }
                        count+=1
                }
            }
            
            targetNatto = nattoSprite[i]
            
            presenter.updateNattoPosition(ohashiX: Float(ohashi.position.x), ohashiY: Float(ohashi.position.y),
                                          ohashiWidth: Float(ohashi.size.width), ohashiHeight: Float(ohashi.size.height),
                                          nattoX: Float(targetNatto.position.x), nattoY: Float(targetNatto.position.y),
                                          sticky: stickyLevel)
        }
    }
}

extension PullNattoScene: PullNattoPresenterOutput {
    
    func showUpdateNatto(x: Float, y: Float) {
        targetNatto.position.x += CGFloat(x)
        targetNatto.position.y += CGFloat(y)
    }
}
