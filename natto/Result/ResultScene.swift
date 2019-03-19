//
//  ResultScene.swift
//  natto
//
//  Created by 佐川　晴海 on 2018/03/10.
//  Copyright © 2018年 佐川　晴海. All rights reserved.
//
import SpriteKit
import Social
class ResultScene: SKScene{
    let resultScore:Int
    let replayLabel = SKLabelNode(fontNamed: "Verdana-bold")
    var twitterButton = SKSpriteNode(imageNamed: "twitter_img")
    var facebookButton = SKSpriteNode(imageNamed: "facebook")
    
    var presenter: ResultPresenter?
    
    init(size:CGSize, score: Int) {
        self.resultScore = score
        presenter = ResultPresenterImpl()
        super.init(size: size)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func didMove(to view: SKView) {
        
        presenter?.loadAudio(resourceName: "natto_bgm_score", resourceType: "wav")
        presenter?.playAudio()
        
        addImage()
        addLabel()
        addButton()
    }
    
    func addImage() {
        let mamekun = SKSpriteNode(imageNamed: "mame01")
        //animation
        mamekun.position = CGPoint(x:self.frame.size.width/2,y: self.frame.size.height/2)
        mamekun.size = CGSize(width: mamekun.size.width, height: mamekun.size.height)
        
        let animation = SKAction.animate(with:[SKTexture(imageNamed: "mame01"), SKTexture(imageNamed: "mame02"), SKTexture(imageNamed: "mame03")], timePerFrame: 0.2)
        mamekun.run(SKAction.repeatForever(animation))
        self.addChild(mamekun)
    }
    func addLabel() {
        let scoreLabel = SKLabelNode(fontNamed: "Verdana-bold")
        
        scoreLabel.text = "SCORE: " + String(resultScore)
        scoreLabel.fontSize = 100
        scoreLabel.position = CGPoint(x: self.frame.midX, y: self.frame.size.height * 0.80)
        self.addChild(scoreLabel)
        replayLabel.text = "REPLAY"
        replayLabel.fontSize = 100
        replayLabel.position = CGPoint(x: self.frame.midX, y: self.frame.size.height * 0.20)
        self.addChild(replayLabel)
    }
    func addButton() {
        twitterButton.position = CGPoint(x: self.frame.maxX * 0.4, y: self.frame.maxY * 0.1)
        twitterButton.zPosition = 1.5
        twitterButton.size = CGSize(width: self.frame.maxX * 0.1, height: self.frame.maxX * 0.1)
        self.addChild(twitterButton)

        facebookButton.position = CGPoint(x: self.frame.maxX * 0.6, y: self.frame.maxY * 0.1)
        facebookButton.zPosition = 1.5
        facebookButton.size = CGSize(width: self.frame.maxX * 0.1, height: self.frame.maxX * 0.1)
        self.addChild(facebookButton)
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touches:AnyObject in touches{
            let location = touches.previousLocation(in: self)
            let touchNode = self.atPoint(location)
            if touchNode == replayLabel{
                let scene = GameScene(size: self.size)
                let skView = self.view as! SKView
                //scene.scaleMode = SKSceneScaleMode.aspectFill
                skView.presentScene(scene)
            }
            if (touchNode == twitterButton) {
                    
                let twitterCmp : SLComposeViewController = SLComposeViewController(forServiceType: SLServiceTypeTwitter)
                    
                twitterCmp.setInitialText("納豆食べてパーフェクトボディ！")
                 let currentViewController : UIViewController? = UIApplication.shared.keyWindow?.rootViewController!
                    
                currentViewController?.present(twitterCmp, animated: true, completion: nil)
            }
            if (touchNode == facebookButton) {
                
                let facebookCmp : SLComposeViewController = SLComposeViewController(forServiceType: SLServiceTypeFacebook)
                
                let currentViewController : UIViewController? = UIApplication.shared.keyWindow?.rootViewController!
                
                currentViewController?.present(facebookCmp, animated: true, completion: nil)
            }
        }
    }
}
