//
//  ResultScene.swift
//  natto
//
//  Created by 佐川　晴海 on 2018/03/10.
//  Copyright © 2018年 佐川　晴海. All rights reserved.
//
import SpriteKit
import StoreKit
import AVFoundation

class ResultScene: SKScene{
    
    // MARK: - NodeInitialize
    lazy var replayLabel: SKLabelNode! = {
        return SKLabelNode(fontSize: 100, text: localizeString(key: LocalizeKeys.Result.buttonRelpay),
                           pos: CGPoint(x: self.frame.midX, y: height * 0.20))
    }()
    lazy var bestScoreLabel: SKLabelNode! = {
        if let bestScore = UserStore.bestScore {
            return SKLabelNode(fontSize: 50,
                               text: localizeString(key: LocalizeKeys.Result.bestScore) + String(bestScore),
                               pos: CGPoint(x: self.frame.midX, y: height * 0.85))
        }
        
        let node = SKLabelNode()
        node.isHidden = true
        return node
    }()
    lazy var scoreLabel: SKLabelNode! = {
        return SKLabelNode(fontSize: 100,
                           text: localizeString(key: LocalizeKeys.Result.score) + String(resultScore),
                           pos: CGPoint(x: self.frame.midX,
                                        y: height * 0.90))
    }()
    lazy var buttonSize = CGSize(width: self.frame.maxX * 0.1,
                                 height: self.frame.maxX * 0.1)

    // MARK: - Property
    let resultScore:Int
    var audio: AVAudioPlayer!
    
    // MARK: - Initializer
    init(size:CGSize, score: Int) {
        self.resultScore = score
        super.init(size: size)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - LifeCycle
    override func didMove(to view: SKView) {
        super.didMove(to: view)
        
        setScreenInit()
        
        //値の保存
        UserStore.saveEatPoint(natto: resultScore)
        UserStore.totalNattoCount += resultScore
        
        //レビューダイアログの表示
        if UserStore.totalNattoCount > 1000 && UserStore.isNeedDisplayedReviewAlert {
            UserStore.isNeedDisplayedReviewAlert = false
            SKStoreReviewController.requestReview()
        }
        
        //紙吹雪表示処理の判定
        guard let bestScore = UserStore.bestScore else {
            UserStore.bestScore = resultScore
            return
        }
        if resultScore > bestScore {
            let vc = BestScoreViewController(score: resultScore)
            vc.modalPresentationStyle = .overCurrentContext
            topViewController()?.present(vc, animated: false, completion: nil)
            return
        }
        
    }
    
    // MARK: - PrivateMethod
    private func loadAudio(resourceName: String, resourceType: String) {
        let path = Bundle.main.path(forResource: resourceName, ofType: resourceType)
        let url = URL(fileURLWithPath: path!)
        do { try  audio = AVAudioPlayer(contentsOf: url) }
        catch{ fatalError() }
        audio.numberOfLoops = -1
        audio.prepareToPlay()
        audio.play()
    }
    
    private func setScreenInit() {
        loadAudio(resourceName: "natto_bgm_score.wav", resourceType: "")
        
        self.addChild(scoreLabel, bestScoreLabel, replayLabel)
        
        let mamekun = SKSpriteNode(image: "mame01", pos: CGPoint(x:width/2,y: height/2))
        let animation = SKAction.animate(with:[SKTexture(imageNamed: "mame01"),
                                               SKTexture(imageNamed: "mame02"),
                                               SKTexture(imageNamed: "mame03")],
                                         timePerFrame: 0.2)
        mamekun.run(SKAction.repeatForever(animation))
        self.addChild(mamekun)
        
        //TODO ボタンを　SKSpriteNodeで作り替える
        SNSShareData.shared.button.isHidden = false
        SNSShareData.shared.message = localizeString(key: LocalizeKeys.Result.score) + String(resultScore) + localizeString(key: LocalizeKeys.Result.tweet) + "\n https://itunes.apple.com/us/app/oh-natto/id1457049172?mt=8"
    }
    
    // MARK: - Event
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touches:AnyObject in touches{
            let location = touches.previousLocation(in: self)
            let touchNode = self.atPoint(location)
            
            if touchNode == replayLabel{
                SNSShareData.shared.button.isHidden = true
                
                let scene = TitleScene(size: self.size)
                self.view!.presentScene(scene)
            }
        }
    }
}
