//
//  ResultScene.swift
//  natto
//
//  Created by 佐川　晴海 on 2018/03/10.
//  Copyright © 2018年 佐川　晴海. All rights reserved.
//
import SpriteKit
import Social
import StoreKit
import SceneKit

import AVFoundation

class ResultScene: SKScene{
    
    // MARK: - NodeInitialize
    
    lazy var bestScoreParticle:SCNView! = {
        let scene = SCNScene()

        let cameraNode = SCNNode()
        cameraNode.camera = SCNCamera()
        cameraNode.position = SCNVector3(x: 0, y: -6, z: 10)
        scene.rootNode.addChildNode(cameraNode)

        let confetti = SCNParticleSystem(named: "Contiffi.scnp", inDirectory: "")!
        scene.rootNode.addParticleSystem(confetti)

        let view = SCNView(frame: CGRect(x: 0, y: 0, width: self.frame.width, height: self.frame.height))
        view.scene = scene
        view.backgroundColor = UIColor.clear
        view.autoenablesDefaultLighting = true
        view.isUserInteractionEnabled = false
        return view
    }()
   
    lazy var replayLabel: SKLabelNode! = {
        return SKLabelNode(font: "Verdana-bold", fontSize: 100, text: localizeString(key: LocalizeKeys.Result.buttonRelpay), pos: CGPoint(x: self.frame.midX, y: height * 0.20))
    }()
    lazy var bestScoreLabel: SKLabelNode! = {
        return SKLabelNode(font: "Verdana-bold", fontSize: 50, text: localizeString(key: LocalizeKeys.Result.bestScore) + String(bestScore), pos: CGPoint(x: self.frame.midX, y: height * 0.85))
    }()
    lazy var scoreLabel: SKLabelNode! = {
        return SKLabelNode(font: "Verdana-bold", fontSize: 100, text: localizeString(key: LocalizeKeys.Result.score) + String(resultScore), pos: CGPoint(x: self.frame.midX, y: height * 0.90))
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

    // MARK: - Property
    
    let resultScore:Int
    lazy var bestScore: Int = {
       return getBestScore()
    }()
    
    var presenter: ResultPresenter {
        let presenter = ResultPresenterImpl(output: self)
        return presenter
    }
    
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
        
            
         presenter.checkScoreEvaluation(score: resultScore)
        
        //TODO 音が鳴らないバグをなんとかする
        loadAudio(resourceName: "natto_bgm_score.wav", resourceType: "")
        
        
        addImage()
        self.addChild(scoreLabel,bestScoreLabel, replayLabel, twitterButton, facebookButton, lineButton)
        SKStoreReviewController().popUpReviewRequest(isPopUp: (presenter.isPopUpReviewDialog()))
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
    
    private func addImage() {
        let mamekun = SKSpriteNode(image: "mame01", pos: CGPoint(x:width/2,y: height/2))
        //animation
        let animation = SKAction.animate(with:[SKTexture(imageNamed: "mame01"), SKTexture(imageNamed: "mame02"), SKTexture(imageNamed: "mame03")], timePerFrame: 0.2)
        mamekun.run(SKAction.repeatForever(animation))
        self.addChild(mamekun)
    }
    
    private func getBestScore() -> Int {
        if UserDefaults.standard.object(forKey: "topScore") != nil {
            let topScore:[Int] = UserDefaults.standard.array(forKey: "topScore") as! [Int]
            return topScore.first!
        } else {
            bestScoreLabel.isHidden = true
            return 0
        }
    }
    
    // MARK: - Event

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touches:AnyObject in touches{
            let location = touches.previousLocation(in: self)
            let touchNode = self.atPoint(location)
            if touchNode == replayLabel{
                self.bestScoreParticle.removeFromSuperview()
                let scene = TitleScene(size: self.size)
                self.view!.presentScene(scene)
            }
            
            let message: String = localizeString(key: LocalizeKeys.Result.score) + String(resultScore) + localizeString(key: LocalizeKeys.Result.tweet) + "\n\nhttps://itunes.apple.com/us/app/oh-natto/id1457049172?mt=8"
            
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

extension ResultScene: ResultPresenterOutput {
    func showScoreComparison(isBest: Bool) {
        if isBest {
            self.view?.addSubview(bestScoreParticle)
        } else {
            bestScoreLabel.isHidden = true
        }
    }
}
