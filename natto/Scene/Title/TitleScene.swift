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

class TitleScene: SKScene {
    var startLabel = SKLabelNode(fontSize: 100,
                                 text: localizeString(key: LocalizeKeys.Title.buttonStart))
    lazy var infoButton: SKSpriteNode = {
        let node = SKSpriteNode(imageNamed: "mame-icon")
        node.size = CGSize(width: 120, height: 120)
        node.position = CGPoint(x: ((self.view!.frame.width) * 2 - 16) - node.size.width,
                                y: ((self.view!.frame.height) * 2 - 16) - node.size.height)
        
        return node
    }()
    var controlWidth: CGFloat!
    private var selectedItems:[Topping] = []
    
    // MARK: - Initializer
    
    override init(size: CGSize) {
        super.init(size: size)
        controlWidth = width / 10
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // - MARK: LifeCycle
    
    override func didMove(to view: SKView) {
        self.anchorPoint = CGPoint(x: 0, y: 0)
        self.physicsWorld.gravity = CGVector(dx: 0.0, dy: -1.5)
        
        for _ in 0...3 {
            let mame = SKSpriteNode(imageNamed: "mame")
            mame.position = CGPoint(x:CGFloat(Int.random(in: 100...Int(self.frame.width))-100),
                                    y: CGFloat(Int.random(in: Int(self.frame.height)...Int(self.frame.height+100 ))))
             mame.physicsBody = SKPhysicsBody().make(rectangleOf: mame.size, category: 0x1 << 1, contact: 0x1 << 0, isGravity: true)
            self.addChild(mame)
        }
        
        startLabel.fontColor = .white
        startLabel.physicsBody = SKPhysicsBody(circleOfRadius: startLabel.frame.maxX)
        startLabel.physicsBody = SKPhysicsBody().make(circleOfRadius: startLabel.frame.maxX, category: 0x1 << 0, contact: 0x1 << 2, isGravity: false)
        startLabel.position = CGPoint(x: self.frame.midX, y: self.frame.midY/3)
        self.addChild(startLabel)
        self.addChild(infoButton)
        
    }
    override func update(_ currentTime: TimeInterval) {
        if startLabel.position.y < height/30 + startLabel.frame.height/2{
            startLabel.position.y = height/30 + startLabel.frame.height/2
        }
        if startLabel.position.y > height - startLabel.frame.height/2{
            startLabel.position.y = height - startLabel.frame.height/2
        }
        if startLabel.position.x < controlWidth + startLabel.frame.width/2 {
            startLabel.position.x = controlWidth + startLabel.frame.width/2
        }
        if startLabel.position.x > width - controlWidth  + startLabel.frame.width/2 {
            startLabel.position.x = width - controlWidth + startLabel.frame.width/2
        }
    }
    
    // - MARK: Event
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        for touches:AnyObject in touches{
            let location = touches.previousLocation(in: self)
            let touchNode = self.atPoint(location)
            if touchNode == startLabel{
                //TODO トッピングで選択されたものを渡せるようにする
                let scene = MixScene(size: self.size, topping: [])
                self.view!.presentScene(scene)
                
            } else if touchNode == infoButton {
                
                let vc = SelectTitleInfoViewController()
                vc.modalPresentationStyle = .overCurrentContext
                topViewController()?.present(vc, animated: false, completion: nil)
            }else {
                let mame = SKSpriteNode(imageNamed: "mame")
                mame.position = location
                mame.physicsBody = SKPhysicsBody().make(rectangleOf: mame.size, category: 0x1 << 1, contact: 0x1 << 0, isGravity: true)
                self.addChild(mame)
            }
        }
    }
}

