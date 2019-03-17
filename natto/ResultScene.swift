//
//  ResultScene.swift
//  natto
//
//  Created by 佐川　晴海 on 2018/03/10.
//  Copyright © 2018年 佐川　晴海. All rights reserved.
//
import SpriteKit
import Social
import AVFoundation
class ResultScene: SKScene, AVAudioPlayerDelegate {
    var resultScore:Int = Int()
    var mamekun = SKSpriteNode(imageNamed: "mame01")
    let scoreLabel = SKLabelNode(fontNamed: "Verdana-bold")
    let replayLabel = SKLabelNode(fontNamed: "Verdana-bold")
    var sprite = SKSpriteNode()
    var BGM:AVAudioPlayer?
    var twitterButton = SKSpriteNode(imageNamed: "twitter_img")
    var facebookButton = SKSpriteNode(imageNamed: "facebook")
    override func didMove(to view: SKView) {
        twitterButton.position = CGPoint(x: self.frame.maxX * 0.4, y: self.frame.maxY * 0.1)
        twitterButton.zPosition = 1.5
        twitterButton.size = CGSize(width: self.frame.maxX * 0.1, height: self.frame.maxX * 0.1)
        self.addChild(twitterButton)
        
        facebookButton.position = CGPoint(x: self.frame.maxX * 0.6, y: self.frame.maxY * 0.1)
        facebookButton.zPosition = 1.5
        facebookButton.size = CGSize(width: self.frame.maxX * 0.1, height: self.frame.maxX * 0.1)
        self.addChild(facebookButton)
        
        resultScore = UserDefaults.standard.integer(forKey: "rs")
        playBGM()
        //animation
        mamekun.position = CGPoint(x:self.frame.size.width/2,y: self.frame.size.height/2)
        mamekun.size = CGSize(width: mamekun.size.width / 2, height: mamekun.size.height / 2 )
        let action = SKTexture(imageNamed: "mame01")
        let action2 = SKTexture(imageNamed: "mame02")
        let action3 = SKTexture(imageNamed: "mame03")
        let animation = SKAction.animate(with:[action, action2, action3], timePerFrame: 0.2)
        mamekun.run(SKAction.repeatForever(animation))
        self.addChild(mamekun)
        
        scoreLabel.text = "SCORE " + String(resultScore)
        scoreLabel.fontSize = 50
        scoreLabel.position = CGPoint(x: self.frame.midX, y: self.frame.size.height * 0.80)
        self.addChild(scoreLabel)
        replayLabel.text = "REPLAY"
        replayLabel.fontSize = 50
        
        replayLabel.position = CGPoint(x: self.frame.midX, y: self.frame.size.height * 0.20)
        self.addChild(replayLabel)
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touches:AnyObject in touches{
            let location = touches.previousLocation(in: self)
            let touchNode = self.atPoint(location)
            if touchNode == replayLabel{
                let scene = GameScene(size: self.size)
                let skView = self.view as SKView!
                scene.scaleMode = SKSceneScaleMode.aspectFill
                skView!.presentScene(scene)
            }
            if (touchNode == twitterButton) {
                    
                let twitterCmp : SLComposeViewController = SLComposeViewController(forServiceType: SLServiceTypeTwitter)
                    
                twitterCmp.setInitialText("納豆食べてパーフェクトボディ！")
                print("-------------------------------------------------------------")
                let currentViewController : UIViewController? = UIApplication.shared.keyWindow?.rootViewController!
                    
                currentViewController?.present(twitterCmp, animated: true, completion: nil)
            }
            if (touchNode == facebookButton) {
                
                let twitterCmp : SLComposeViewController = SLComposeViewController(forServiceType: SLServiceTypeFacebook)
                
                twitterCmp.setInitialText("納豆食べてパーフェクトボディ！")
                print("-------------------------------------------------------------")
                let currentViewController : UIViewController? = UIApplication.shared.keyWindow?.rootViewController!
                
                currentViewController?.present(twitterCmp, animated: true, completion: nil)
            }
        }
    }
    override func update(_ currentTime: TimeInterval) {

    }
    func playBGM(){
        let BGMpath = Bundle.main.path(forResource: "natto_bgm_score", ofType:"wav")!
        let BGMUrl = URL(fileURLWithPath: BGMpath)
        do {
            try BGM = AVAudioPlayer(contentsOf:BGMUrl)
            
            //音楽をバッファに読み込んでおく
            BGM!.prepareToPlay()
        } catch {
            print(error)
        }
        // auido を再生するプレイヤーを作成する
        var audioError:NSError?
        do {
            BGM = try AVAudioPlayer(contentsOf: BGMUrl)
        } catch let error as NSError {
            audioError = error
            BGM = nil
        }
        if let error = audioError {
            print("Error \(error.localizedDescription)")
        }
        BGM!.delegate = self
        BGM!.play()
    }
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        player.currentTime = 0
    }
}
