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
    let tutorialTitleLabel = UILabel()
    let descriptionLabel1 = UILabel()
    let descriptionLabel2 = UILabel()
    let descriptionLabel3 = UILabel()
    let descriptionImage1 = UIImageView()
    let descriptionImage2 = UIImageView()
    let descriptionImage3 = UIImageView()
    let userDefaults = UserDefaults.standard
    
    var startLabel = SKLabelNode(fontNamed: "Verdana-bold")
    override func didMove(to view: SKView) {
    
        tutorialButton.backgroundColor = .red
        tutorialButton.frame.size = CGSize(width: 80, height: 80)
        tutorialButton.layer.position = CGPoint(x: (self.view?.frame.width)! - tutorialButton.frame.width * 1.1, y: 100)
        tutorialButton.titleLabel!.font = UIFont.systemFont(ofSize: 40)
        tutorialButton.setTitle("?", for: .normal)
        tutorialButton.layer.cornerRadius = tutorialButton.frame.width/2
        tutorialButton.addTarget(self, action: #selector(showTutorialTapped(_:)), for: .touchDown)
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
        
        handleUserDefaults()
    }
    
    func handleUserDefaults() {
        if userDefaults.bool(forKey: "isNotFirstSession") == false {
            showTutorial()
            userDefaults.set(true, forKey: "isNotFirstSession")
            userDefaults.synchronize()
        }
    }
    
    @objc func showTutorialTapped(_ sender:AnyObject) {
        showTutorial()
    }
    
    func showTutorial(){
        print("tap")
        scrollView.frame = CGRect(x: 25, y: 50, width: (self.view?.frame.width)! - 50, height: (self.view?.frame.height)! - 100)
        scrollView.backgroundColor = .gray
        self.view?.addSubview(scrollView)
        
        closeButton.frame.size = CGSize(width: (self.view?.frame.width)!/9, height:  (self.view?.frame.width)!/9)
        
        closeButton.layer.position = CGPoint(x: self.view!.frame.width/2, y: self.view!.frame.height - 100)
        closeButton.backgroundColor = .red
        closeButton.layer.cornerRadius = closeButton.frame.width/2
        closeButton.setTitle("X", for: .normal)
        closeButton.titleLabel!.font = UIFont.systemFont(ofSize: 40)

        closeButton.addTarget(self, action: #selector(closeTutorial(_:)), for: .touchDown)
        self.view!.addSubview(closeButton)
        
        let underLineAttr = [NSAttributedString.Key.underlineStyle.rawValue: NSUnderlineStyle.single.rawValue,
                             NSAttributedString.Key.underlineColor: UIColor.white] as! [NSAttributedString.Key : Any]

        tutorialTitleLabel.attributedText = NSAttributedString(string: "あそびかた", attributes: underLineAttr)
        tutorialTitleLabel.font = UIFont.systemFont(ofSize: scrollView.frame.width/10)
        tutorialTitleLabel.textAlignment = NSTextAlignment.center
        tutorialTitleLabel.frame = CGRect(x:16, y:30, width:scrollView.frame.width - 32, height: 50)
        scrollView.addSubview(tutorialTitleLabel)
        
        descriptionLabel1.text = "①納豆をできるだけたくさん混ぜてねばり気を出します。混ぜた量によって次の画面での納豆の吸着率が変化します"
        descriptionLabel1.frame = CGRect(x: 16, y: 50 + tutorialTitleLabel.frame.height, width:scrollView.frame.width - 32, height: scrollView.frame.width/15 * CGFloat((descriptionLabel1.text?.count)! / 12 + 1 ))
        descriptionLabel1.numberOfLines = 0
        descriptionLabel1.font = UIFont.systemFont(ofSize: scrollView.frame.width/15)
        scrollView.addSubview(descriptionLabel1)
        descriptionImage1.frame = CGRect(x: 8, y: 50 + tutorialTitleLabel.frame.height + descriptionLabel1.frame.height,width: scrollView.frame.width - 16, height: scrollView.frame.width - 16)
        descriptionImage1.contentMode = UIView.ContentMode.scaleToFill
        descriptionImage1.image = UIImage(named: "description1")
        scrollView.addSubview(descriptionImage1)
    
        descriptionLabel2.text = "②時間内に納豆を持ち上げてできるだけたくさん食べます"
        descriptionLabel2.frame = CGRect(x: 16, y: 50 + tutorialTitleLabel.frame.height + descriptionLabel1.frame.height + descriptionImage1.frame.height , width: scrollView.frame.width - 32, height: scrollView.frame.width/15 * CGFloat((descriptionLabel2.text?.count)! / 12 + 1 ))
        descriptionLabel2.numberOfLines = 0
        descriptionLabel2.font = UIFont.systemFont(ofSize: scrollView.frame.width/15)
        scrollView.addSubview(descriptionLabel2)
        descriptionImage2.frame = CGRect(x: 8, y: 50 + tutorialTitleLabel.frame.height + descriptionLabel1.frame.height + descriptionImage1.frame.height + descriptionLabel2.frame.height , width: scrollView.frame.width - 16, height: scrollView.frame.width - 16)
        descriptionImage2.contentMode = UIView.ContentMode.scaleToFill
        descriptionImage2.image = UIImage(named: "description2")
        scrollView.addSubview(descriptionImage2)
        
        
        descriptionLabel3.text = "③食べた納豆の数でスコアが決まります!良い結果が出たらSNSに投稿しよう！"
        descriptionLabel3.frame = CGRect(x: 16, y: 50 + tutorialTitleLabel.frame.height + descriptionLabel1.frame.height + descriptionImage1.frame.height + descriptionLabel2.frame.height + descriptionImage2.frame.height, width: scrollView.frame.width - 32, height: scrollView.frame.width/15 * CGFloat((descriptionLabel3.text?.count)! / 12 + 1 ))
        descriptionLabel3.numberOfLines = 0
        descriptionLabel3.font = UIFont.systemFont(ofSize: scrollView.frame.width/15)
        scrollView.addSubview(descriptionLabel3)
        
        descriptionImage3.frame = CGRect(x: 8, y: 50 + tutorialTitleLabel.frame.height + descriptionLabel1.frame.height + descriptionImage1.frame.height + descriptionLabel2.frame.height + descriptionImage2.frame.height + descriptionLabel3.frame.height, width: scrollView.frame.width - 16, height: scrollView.frame.width * 2 - 16)
        descriptionImage3.image = UIImage(named: "description3")
        descriptionImage3.contentMode = UIView.ContentMode.scaleToFill
        scrollView.addSubview(descriptionImage3)
        scrollView.contentSize = CGSize(width: (self.view?.frame.width)! - 100, height: 50 + tutorialTitleLabel.frame.height + descriptionLabel1.frame.height + descriptionImage1.frame.height + descriptionLabel2.frame.height + descriptionImage2.frame.height + descriptionLabel3.frame.height + descriptionImage3.frame.height + 100)
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

