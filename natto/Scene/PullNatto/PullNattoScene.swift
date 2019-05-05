
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
    
    // MARK: - NodeInitialize
    lazy var nattoSprite:[SKSpriteNode] = {
        var sprites:[SKSpriteNode] = []
        for _ in 0..<Constant.SpriteCount.natto {
            let r = CGFloat(arc4random_uniform(UInt32(2.0 * .pi)))
            
            let nattoBody = SKPhysicsBody().make(circleOfRadius: width/40, isGravity: true)
            let natto = SKSpriteNode(image: "mame", pos: CGPoint(x: randX, y: randY/4), body: nattoBody, rotate: r, size: CGSize(width: width/17, height: width/17))
            sprites.append(natto)
        }
        return sprites
        }()
    lazy var ohashi = SKSpriteNode(image: "pullOhashi", pos: CGPoint(x: self.frame.midX, y: self.frame.midY), viewBounds: (self.view?.bounds)!, frame: self.frame, zPos: 1.25)
    lazy var mouth = SKSpriteNode(image: "pakupaku", viewBounds: (self.view?.bounds)!, frame: self.frame, zPos: 1.0)
    
    // MARK: - Property
    
    var timer:Timer?
    var score:Int = 0
    var count = 0
    var stickyLevel:Float
    var mameflag = false
    fileprivate lazy var presenter: PullNattoPresenter! = {
        let presenter = PullNattoPresenterImpl(output: self, model: PullNattoModel())
        presenter.loadBgmAudio(resourceName:"natto_bgm_game", resourceType: "wav")
        presenter.loadEffectAudio(resourceName: "paku", resourceType: "wav")
        return presenter
    }()
    
    var targetNatto: SKSpriteNode!
    
    
    // MARK: - Initializer
    
    init(size: CGSize, sticky: Int) {
        stickyLevel = Float(sticky) * 0.0002
        super.init(size: size)
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - LifeCycle
    
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
        
        self.addChild(mouth, ohashi)
        nattoSprite.forEach({
            self.addChild($0)
        })
    }
    
    //MARK: - Event
    
    func touchMoved(toPoint pos : CGPoint) {
        ohashi.position = CGPoint(x: pos.x, y: pos.y)
    }

    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchMoved(toPoint: t.location(in: self)) }
    }
    @objc func timerCounter(){
        self.timer?.invalidate()
        
        for i in 0..<nattoSprite.count {
            if (height < nattoSprite[i].position.y) {
                score += 1
            }
        }
        presenter = nil
        let scene = ResultScene(size: self.size, score: score)
        self.view!.presentScene(scene)
    }
    
    override func update(_ currentTime: TimeInterval) {
        nattoSprite.forEach{ natto in
            if (height * 0.80 < natto.position.y) {
                natto.position.y = height + 100
                mameflag = true
                if(mameflag){
                    if(count > 1){
                        return
                    }else{
                        presenter.playEffect()
                    }
                        count+=1
                }
            }
            targetNatto = natto
            
            presenter.updateNattoPosition(ohashiX: Float(ohashi.position.x), ohashiY: Float(ohashi.position.y),
                                          ohashiWidth: Float(ohashi.size.width), ohashiHeight: Float(ohashi.size.height),
                                          nattoX: Float(targetNatto.position.x), nattoY: Float(targetNatto.position.y),
                                          sticky: stickyLevel, dist: Float(width/10))
        }
    }
}

// MARK: - PullNattoPresenterOutput

extension PullNattoScene: PullNattoPresenterOutput {
    func showUpdateNatto(objPos: ObjectPosition) {
        targetNatto.position.x += CGFloat(objPos.x)
        targetNatto.position.y += CGFloat(objPos.y)
    }
}
