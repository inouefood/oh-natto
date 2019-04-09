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
    lazy var replayLabel: SKLabelNode! = {
        return SKLabelNode(font: "Verdana-bold", fontSize: 100, text: "REPLAY", pos: CGPoint(x: self.frame.midX, y: self.frame.size.height * 0.20))
    }()
    lazy var scoreLabel: SKLabelNode! = {
        return SKLabelNode(font: "Verdana-bold", fontSize: 100, text: "SCORE: " + String(resultScore), pos: CGPoint(x: self.frame.midX, y: self.frame.size.height * 0.80))
    }()
    lazy var buttonSize = CGSize(width: self.frame.maxX * 0.1, height: self.frame.maxX * 0.1)
    lazy var twitterButton: SKSpriteNode! = {
        return SKSpriteNode(image: "twitter_img", pos: CGPoint(x: self.frame.maxX * 0.3, y: self.frame.maxY * 0.1), zPos: 1.5, size: buttonSize)
    }()
    lazy var facebookButton: SKSpriteNode! = {
        return SKSpriteNode(image: "facebook", pos: CGPoint(x: self.frame.maxX * 0.5, y: self.frame.maxY * 0.1), zPos: 1.5, size: buttonSize)
    }()
    lazy var lineButton: SKSpriteNode! = {
        return SKSpriteNode(image: "LINE_APP", pos: CGPoint(x: self.frame.maxX * 0.7, y: self.frame.maxY * 0.1), zPos: 1.5, size: buttonSize)
    }()

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
        let mamekun = SKSpriteNode(image: "mame01", pos: CGPoint(x:self.frame.size.width/2,y: self.frame.size.height/2))
        //animation
        let animation = SKAction.animate(with:[SKTexture(imageNamed: "mame01"), SKTexture(imageNamed: "mame02"), SKTexture(imageNamed: "mame03")], timePerFrame: 0.2)
        mamekun.run(SKAction.repeatForever(animation))
        self.addChild(mamekun)
    }
    
    func addLabel() {
        self.addChild(scoreLabel)
        self.addChild(replayLabel)
    }
    
    func addButton() {
        self.addChild(twitterButton)
        self.addChild(facebookButton)
        self.addChild(lineButton)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touches:AnyObject in touches{
            let location = touches.previousLocation(in: self)
            let touchNode = self.atPoint(location)
            if touchNode == replayLabel{
                let scene = GameScene(size: self.size)
                self.view!.presentScene(scene)
            }
            
            let message: String = "SCORE : " + String(resultScore) + "\n\n納豆食べてパーフェクトボディ！\nhttps://itunes.apple.com/us/app/oh-natto/id1457049172?mt=8"
            
            if (touchNode == twitterButton) {
                SLComposeViewController().showTwitterDialog(message: message, vc:(UIApplication.shared.keyWindow?.rootViewController!)!)
            }
            if (touchNode == facebookButton) {
                SLComposeViewController().showFacebookDialog(message: message, vc:(UIApplication.shared.keyWindow?.rootViewController!)!)
            }
            if (touchNode == lineButton) {
                let urlscheme: String = "line://msg/text"
                let urlstring = urlscheme + "/" + message
                
                SLComposeViewController().showLineDialog(message: urlstring, vc: (UIApplication.shared.keyWindow?.rootViewController!)!)
            }
        }
    }
}
