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
    let replayLabel:SKLabelNode
    var twitterButton = SKSpriteNode(imageNamed: "twitter_img")
    var facebookButton = SKSpriteNode(imageNamed: "facebook")
    var lineButton = SKSpriteNode(imageNamed: "LINE_APP")

    var presenter: ResultPresenter?
    
    init(size:CGSize, score: Int) {
        replayLabel = SKLabelNode(font: "Verdana-bold", fontSize: 100, text: "REPLAY")
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
        let scoreLabel = SKLabelNode(font: "Verdana-bold", fontSize: 100, text: "SCORE: " + String(resultScore))
        scoreLabel.position = CGPoint(x: self.frame.midX, y: self.frame.size.height * 0.80)
        self.addChild(scoreLabel)
        replayLabel.position = CGPoint(x: self.frame.midX, y: self.frame.size.height * 0.20)
        self.addChild(replayLabel)
    }
    func addButton() {
        twitterButton.position = CGPoint(x: self.frame.maxX * 0.3, y: self.frame.maxY * 0.1)
        twitterButton.zPosition = 1.5
        twitterButton.size = CGSize(width: self.frame.maxX * 0.1, height: self.frame.maxX * 0.1)
        self.addChild(twitterButton)

        facebookButton.position = CGPoint(x: self.frame.maxX * 0.5, y: self.frame.maxY * 0.1)
        facebookButton.zPosition = 1.5
        facebookButton.size = CGSize(width: self.frame.maxX * 0.1, height: self.frame.maxX * 0.1)
        self.addChild(facebookButton)
        
        lineButton.position = CGPoint(x: self.frame.maxX * 0.7, y: self.frame.maxY * 0.1)
        lineButton.zPosition = 1.5
        lineButton.size = CGSize(width: self.frame.maxX * 0.1, height: self.frame.maxX * 0.1)
        self.addChild(lineButton)
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touches:AnyObject in touches{
            let location = touches.previousLocation(in: self)
            let touchNode = self.atPoint(location)
            if touchNode == replayLabel{
                let scene = GameScene(size: self.size)
                let skView = self.view as! SKView
                skView.presentScene(scene)
            }
            
            let message: String = "SCORE : " + String(resultScore) + "\n\n納豆食べてパーフェクトボディ！\nhttps://itunes.apple.com/us/app/oh-natto/id1457049172?mt=8"
            
            if (touchNode == twitterButton) {
                let twitterCmp : SLComposeViewController = SLComposeViewController(forServiceType: SLServiceTypeTwitter)
                twitterCmp.setInitialText(message)
                
                 let currentViewController : UIViewController? = UIApplication.shared.keyWindow?.rootViewController!
                currentViewController?.present(twitterCmp, animated: true, completion: nil)
            }
            if (touchNode == facebookButton) {
                
                let facebookCmp : SLComposeViewController = SLComposeViewController(forServiceType: SLServiceTypeFacebook)
                facebookCmp.setInitialText(message)
                
                let currentViewController : UIViewController? = UIApplication.shared.keyWindow?.rootViewController!
                currentViewController?.present(facebookCmp, animated: true, completion: nil)
            }
            if (touchNode == lineButton) {
                let urlscheme: String = "line://msg/text"
                let urlstring = urlscheme + "/" + message
                
                guard let  encodedURL = urlstring.addingPercentEncoding(withAllowedCharacters: NSCharacterSet.urlQueryAllowed) else {
                    return
                }
                
                guard let url = URL(string: encodedURL) else {
                    return
                }
                
                if UIApplication.shared.canOpenURL(url) {
                    UIApplication.shared.open(url, options: [:], completionHandler: nil)
                }
            }
        }
    }
}
