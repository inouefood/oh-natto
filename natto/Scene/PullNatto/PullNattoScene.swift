
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
        let screenSmallSide = width > height ? height : width
        let mameSize = CGSize(width: screenSmallSide/17, height: screenSmallSide/17)
        
        for _ in 0..<Constant.SpriteCount.natto {
            let r = CGFloat(arc4random_uniform(UInt32(2.0 * .pi)))
            
            let nattoBody = SKPhysicsBody().make(circleOfRadius: screenSmallSide/40,
                                                 isGravity: true)
            let natto = SKSpriteNode(image: "mame",
                                     pos: CGPoint(x: randX, y: randY/4),
                                     body: nattoBody,
                                     rotate: r,
                                     size: CGSize(width: screenSmallSide/17,
                                                  height: screenSmallSide/17))
            sprites.append(natto)
        }
        
        return sprites
    }()
    
    lazy var ohashi = SKSpriteNode(image: "pullOhashi",
                                   pos: CGPoint(x: self.frame.midX, y: self.frame.midY),
                                   viewBounds: (self.view?.bounds)!,
                                   frame: self.frame,
                                   zPos: 1.25)
    
    lazy var mouth = SKSpriteNode(image: "pakupaku",
                                  viewBounds: (self.view?.bounds)!,
                                  frame: self.frame,
                                  zPos: 1.0)
    
    var toppingSprite:[ToppingSpriteNode] = []
    
    // MARK: - Property
    var timer:Timer?
    var score:Int = 0
    let stickyLevel:Float
    let topping:[Topping]?
    
    fileprivate lazy var presenter: PullNattoPresenter! = {
        let presenter = PullNattoPresenterImpl(output: self, model: PullNattoModel())
        presenter.loadBgmAudio(resourceName:"natto_bgm_game", resourceType: "wav")
        presenter.loadEffectAudio(resourceName: "paku", resourceType: "wav")
        
        return presenter
    }()
    
    // MARK: - Initializer
    init(size: CGSize, sticky: Int, topping:[Topping]?) {
        stickyLevel = Float(sticky) * Constant.Sticky.level
        self.topping = topping
        super.init(size: size)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - LifeCycle
    override func didMove(to view: SKView) {
        //原点の変更
        self.anchorPoint = CGPoint(x: 0, y: 0)
        self.backgroundColor = SKColor.gray
        self.physicsWorld.gravity = CGVector(dx: 0.0, dy: -0.5)
        self.physicsBody = SKPhysicsBody(edgeLoopFrom: self.frame)
        
        presenter.playBgm()

        self.timer = Timer.scheduledTimer(timeInterval: 25,
                                          target: self,
                                          selector: #selector(MixScene.timerCounter),
                                          userInfo: nil,
                                          repeats: true)

        self.addChild(mouth, ohashi)
        
        nattoSprite.forEach({
            self.addChild($0)
        })
        createToppingItem()
    }
    
    override func update(_ currentTime: TimeInterval) {
        let screenSmallSide = width > height ? height : width
        
        for (i, natto) in nattoSprite.enumerated() {
            presenter.nattoEatCheck(height: Float(height),
                               nattoY: Float(natto.position.y),
                               index: i)
            
            presenter.updateNattoPosition(ohashiPos: ObjectPosition(pos: ohashi.position),
                                          ohashiSize: ObjectSize(size: ohashi.size),
                                          nattoPos: ObjectPosition(pos: natto.position),
                                          sticky: stickyLevel,
                                          dist: Float(screenSmallSide/10),
                                          index: i)
        }
        
        for (i, topping) in toppingSprite.enumerated() {
            presenter.toppingEatCheck(height: Float(height),
                               toppingY: Float(topping.position.y),
                               index: i)
            
            presenter.updateToppingPosition(ohashiPos: ObjectPosition(pos: ohashi.position),
                                            ohashiSize: ObjectSize(size: ohashi.size),
                                            toppingPos: ObjectPosition(pos: topping.position),
                                            sticky: stickyLevel,
                                            dist: Float(screenSmallSide/10),
                                            index: i)
        }

    }
    
    private func createToppingItem() {
        
        topping?.forEach{topping in
            
            let screenSmallSide = width > height ? height : width
            var toppingSize:CGSize!
            var bodyRadius:CGFloat!
            
            switch topping.type {
            
            case .negi:
                toppingSize = CGSize(width: screenSmallSide/15, height: screenSmallSide/15)
                bodyRadius = screenSmallSide/30
            case .okura:
                toppingSize = CGSize(width: screenSmallSide/7, height: screenSmallSide/7)
                bodyRadius = screenSmallSide/25
            case .sirasu:
                toppingSize = CGSize(width: screenSmallSide/7, height: screenSmallSide/17)
                bodyRadius = screenSmallSide/30
            }
            
            for _ in 0..<topping.quantity {
                let r = CGFloat(arc4random_uniform(UInt32(2.0 * Double.pi)))
                
                let itemBody = SKPhysicsBody().make(circleOfRadius: bodyRadius,
                                                     isGravity: true)
                let item = ToppingSpriteNode(image: topping.imageName,
                                             pos: CGPoint(x: randX, y: randY/4),
                                             body: itemBody,
                                             rotate: r,
                                             size: toppingSize)
                item.point = topping.point
                
                toppingSprite.append(item)
                self.addChild(item)
            }
        }
    }
    
    //MARK: - Event
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches {
            let pos = t.location(in: self)
            ohashi.position = CGPoint(x: pos.x, y: pos.y)
        }
    }
    
    @objc func timerCounter(){
        self.timer?.invalidate()
        
        for i in 0..<nattoSprite.count {
            if height < nattoSprite[i].position.y {
                score += 1
            }
        }
        nattoSprite.forEach{
            if height < $0.position.y {
                score += 1
            }
        }
        
        toppingSprite.forEach{
            if height < $0.position.y {
                if let point = $0.point {
                    score += point
                }
            }
        }
        
        presenter = nil
        
        let scene = ResultScene(size: self.size, score: score)
        self.view!.presentScene(scene)
    }
}

// MARK: - PullNattoPresenterOutput
extension PullNattoScene: PullNattoPresenterOutput {
    func showUpdateTopping(objPos: ObjectPosition, index: Int) {
        toppingSprite[index].position.x += CGFloat(objPos.x)
        toppingSprite[index].position.y += CGFloat(objPos.y)
    }
    func showEatTopping(index: Int){
        toppingSprite[index].position.y = height + 100
        presenter.playEffect()
    }
    
    func showUpdateNatto(objPos: ObjectPosition, index: Int) {
        nattoSprite[index].position.x += CGFloat(objPos.x)
        nattoSprite[index].position.y += CGFloat(objPos.y)
    }
    
    func showEatNatto(index: Int){
        nattoSprite[index].position.y = height + 100
        presenter.playEffect()
    }
}
