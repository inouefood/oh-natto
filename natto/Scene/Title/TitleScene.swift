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
        let node = SKSpriteNode(imageNamed: "infoIcon")
        node.size = CGSize(width: 100, height: 100)
        node.position = CGPoint(x: ((self.view!.frame.width) * 2 - 10) - node.size.width,
                                y: ((self.view!.frame.height) * 2 - 16) - node.size.height)
        
        return node
    }()
    lazy var tutorialButton: SKSpriteNode = {
        let node = SKSpriteNode(imageNamed: "tutorialIcon")
        node.size = CGSize(width: 70, height: 70)
        node.position = CGPoint(x: ((self.view!.frame.width) * 2 - 10) - node.size.width - 30,
                                y: ((self.view!.frame.height) * 2 - 16) - node.size.height - 150)
        node.isHidden = true
        return node
    }()
    
    lazy var itemSelectButton: SKSpriteNode = {
        let node = SKSpriteNode(imageNamed: "equipmentIcon")
        node.size = CGSize(width: 70, height: 70)
        node.position = CGPoint(x: ((self.view!.frame.width) * 2 - 10) - node.size.width - 30,
                                y: ((self.view!.frame.height) * 2 - 16) - node.size.height - 250)
        node.isHidden = true
        return node
    }()
    
    lazy var settingButton: SKSpriteNode = {
        let node = SKSpriteNode(imageNamed: "settingIcon")
        node.size = CGSize(width: 70, height: 70)
        node.position = CGPoint(x: ((self.view!.frame.width) * 2 - 10) - node.size.width - 30,
                                y: ((self.view!.frame.height) * 2 - 16) - node.size.height - 350)
        node.isHidden = true
        return node
    }()
    
    var controlWidth: CGFloat!
    
    override init(size: CGSize) {
        super.init(size: size)
        controlWidth = width / 10
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func updateOwnedToppingItems(){
        guard var item = UserStore.ownedItem else {
            return
        }
        var selectNegi = 0
        var selectOkura = 0
        var selectSirasu = 0
        
        ToppingManager.shared.selectedItem.forEach{
            switch $0.type {
            case .negi:
                selectNegi += 1
            case .okura:
                selectOkura += 1
            case .sirasu:
                selectSirasu += 1
            }
        }
        item.negi -= selectNegi
        item.okura -= selectOkura
        item.sirasu -= selectSirasu
        
        UserStore.ownedItem = item
        ToppingManager.shared.selectedItem = []
    }
}

// MARK: - Life Cycle
extension TitleScene {
    
    override func didMove(to view: SKView) {
        self.backgroundColor = AppColor.background.color
        self.anchorPoint = CGPoint(x: 0, y: 0)
        self.physicsWorld.gravity = CGVector(dx: 0.0, dy: -1.5)
        
        for _ in 0...3 {
            let mame = SKSpriteNode(imageNamed: "mame")
            mame.size = CGSize(width: (frame.width+frame.height)*0.025, height: (frame.width+frame.height)*0.025)
            mame.position = CGPoint(x:CGFloat(Int.random(in: 100...Int(self.frame.width))-100),
                                    y: CGFloat(Int.random(in: Int(self.frame.height)...Int(self.frame.height+100 ))))
            mame.physicsBody = SKPhysicsBody().make(rectangleOf: mame.size, category: 0x1 << 1, contact: 0x1 << 0, isGravity: true)
            self.addChild(mame)
        }
        
        startLabel.fontColor = .white
        startLabel.physicsBody = SKPhysicsBody(circleOfRadius: startLabel.frame.maxX)
        startLabel.physicsBody = SKPhysicsBody().make(circleOfRadius: startLabel.frame.maxX, category: 0x1 << 0, contact: 0x1 << 2, isGravity: false)
        startLabel.position = CGPoint(x: self.frame.midX, y: self.frame.midY/3)
        
        self.addChild(startLabel, infoButton, tutorialButton, itemSelectButton, settingButton)
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
}
// - MARK: Event
extension TitleScene {
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        for touches:AnyObject in touches{
            let location = touches.previousLocation(in: self)
            let touchNode = self.atPoint(location)
            if touchNode == startLabel{
                
                let scene = MixScene(size: self.size, topping: ToppingManager.shared.selectedItem)
                updateOwnedToppingItems()
                self.view!.presentScene(scene)
                
            } else if touchNode == infoButton {
                if self.tutorialButton.isHidden {
                    let action = SKAction.rotate(toAngle: -(.pi / 2), duration: 0.3)
                    infoButton.run(action) {
                        self.tutorialButton.isHidden = false
                        self.itemSelectButton.isHidden = false
                        self.settingButton.isHidden = false
                    }
                } else {
                    let action = SKAction.rotate(toAngle: 0, duration: 0.3)
                    infoButton.run(action) {
                        self.tutorialButton.isHidden = true
                        self.itemSelectButton.isHidden = true
                        self.settingButton.isHidden = true
                    }
                }
            
            } else if touchNode == tutorialButton {
                let vc = DescriptionViewController()
                vc.modalPresentationStyle = .overCurrentContext
                topViewController()?.present(vc, animated: true, completion: nil)
                
            } else if touchNode == itemSelectButton {
                let vc = ToppingSelectViewController()
                topViewController()?.present(vc, animated: true, completion: nil)
                
            }else if touchNode == settingButton {
                topViewController()?.present(SettingViewController(), animated: true, completion: nil)
                
            } else {
                let sprite: SKSpriteNode!
                let randomCount = Int.random(in: 0...3)
                
                if ToppingManager.shared.selectedItem.isEmpty {
                    sprite = SKSpriteNode(imageNamed: "mame")
                } else {
                    if randomCount != 0 {
                        sprite = SKSpriteNode(imageNamed: "mame")
                    } else {
                        sprite = SKSpriteNode(imageNamed:ToppingManager.shared.selectedItem.randomElement()!.imageName)
                    }
                }
                
                sprite.size = CGSize(width: (frame.width+frame.height)*0.025, height: (frame.width+frame.height)*0.025)
                sprite.position = location
                sprite.physicsBody = SKPhysicsBody().make(rectangleOf: sprite.size, category: 0x1 << 1, contact: 0x1 << 0, isGravity: true)
                self.addChild(sprite)
            }
        }
    }
}
