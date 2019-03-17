
//
//  PullNattoScene.swift
//  natto
//
//  Created by 佐川　晴海 on 2018/03/10.
//  Copyright © 2018年 佐川　晴海. All rights reserved.
//
import SpriteKit
import GameplayKit
import AVFoundation

class PullNattoScene: SKScene, AVAudioPlayerDelegate{
    
    var timer:Timer?
    var score:Int = Int()
    var resultScore:Int = 0
    var nattoSprite:[SKSpriteNode] = []
    var stickyLevel:Float = 0.0
    var nettoCount = 200
    let ohashi = SKSpriteNode(imageNamed: "pullOhashi")
    let mouth = SKSpriteNode(imageNamed: "pakupaku")
    var BGM:AVAudioPlayer?
    var BGM2:AVAudioPlayer?
    var mameflag = false
    var count = 0
    override func didMove(to view: SKView) {
        score = UserDefaults.standard.integer(forKey: "stickyLevel")
        //音楽の再生
        playBGM()
        //タイマー
        self.timer = Timer.scheduledTimer(timeInterval: 25, target: self, selector: #selector(GameScene.timerCounter), userInfo: nil, repeats: true)
        //原点の変更
        self.anchorPoint = CGPoint(x: 0, y: 0)
        self.backgroundColor = SKColor.gray
        
        
        print(score)
        stickyLevel = Float(score) * 0.0001
        
        //ワールドの設定
        self.physicsWorld.gravity = CGVector(dx: 0.0, dy: 0.0)
        self.physicsBody = SKPhysicsBody(edgeLoopFrom: self.frame)
        
        let scale = (self.view?.bounds.width)! / mouth.size.width
        //お口
        mouth.position = CGPoint(x: self.frame.midX, y: self.frame.maxY - (mouth.size.height * scale * 2.0) / 2.0)
        mouth.size = CGSize(width: self.frame.size.width, height: mouth.size.height * scale * 2.0)
        mouth.zPosition = 1.0
        self.addChild(mouth)
        
        let ohashiScale = (self.view?.bounds.width)! / ohashi.size.width
        //お箸の初期ポジション
        ohashi.position = CGPoint(x: self.frame.midX, y: self.frame.midY)
        ohashi.size = CGSize(width: ohashi.size.width * ohashiScale / 2, height: ohashi.size.height * ohashiScale/2 )
        ohashi.zPosition = 1.25
        self.addChild(ohashi)
        
        
        //納豆の初期設定
        for _ in 0..<nettoCount{
            let natto = SKSpriteNode(imageNamed:"mame")
            let X = Int(arc4random_uniform(UInt32(self.frame.size.width)))
            let Y = Int(arc4random_uniform(UInt32(self.frame.size.height / 4.0)))
            let r = CGFloat(arc4random_uniform(UInt32(2.0 * .pi)))
            natto.position = CGPoint(x: X, y: Y)
            natto.physicsBody = SKPhysicsBody(circleOfRadius: 20)
            natto.physicsBody!.affectedByGravity = false
            natto.zRotation = r
            self.addChild(natto)
            nattoSprite.append(natto)
        }
    }
    
    func touchMoved(toPoint pos : CGPoint) {
        ohashi.position = CGPoint(x: pos.x, y: pos.y)
    }

    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchMoved(toPoint: t.location(in: self)) }
        
    }
    
    override func update(_ currentTime: TimeInterval) {
        for i in 0..<nettoCount{
            if (self.frame.size.height * 0.70 < nattoSprite[i].position.y) {
                nattoSprite[i].position.y = self.frame.size.height + 100
                mameflag = true
                if(mameflag){
                    if(count > 1){
                        continue
                    }else{
                        playPaku()
                    }
                        count+=1
                }
            }
            
            //お箸とお豆の距離計算
            let sentanx:Float = Float(ohashi.position.x + ohashi.size.width / 2.0)
            let sentany:Float = Float(ohashi.position.y - ohashi.size.height / 2.0)
            let dvx:Float = sentanx - Float(nattoSprite[i].position.x)
            let dvy:Float = sentany - Float(nattoSprite[i].position.y)
            let dist:Float = sqrtf(dvx * dvx + dvy * dvy)
            //お箸に近づいたときの処理
            if (dist < 100) {
                nattoSprite[i].position.x += CGFloat(dvx * Float(stickyLevel))
                nattoSprite[i].position.y += CGFloat(dvy * Float(stickyLevel))
            }
        }
    }
    
    @objc func timerCounter(){
        //BGM2!.stop()
        //BGM2!.currentTime = 0
        self.timer?.invalidate()
        let scene = ResultScene(size: self.size)
        scene.scaleMode = SKSceneScaleMode.aspectFill
        for i in 0..<nattoSprite.count {
            if (self.frame.size.height < nattoSprite[i].position.y) {
                resultScore += 1
            }
        }
        print(resultScore)
        let ud = UserDefaults.standard
        ud.set(resultScore, forKey: "rs")
        self.view!.presentScene(scene)
    }
    
    func playPaku(){
        let BGMpath = Bundle.main.path(forResource: "paku", ofType:"wav")!
        let BGMUrl = URL(fileURLWithPath: BGMpath)
        do {
            try BGM2 = AVAudioPlayer(contentsOf:BGMUrl)
            
            //音楽をバッファに読み込んでおく
            BGM2!.prepareToPlay()
        } catch {
            print(error)
        }
        // auido を再生するプレイヤーを作成する
        var audioError:NSError?
        do {
            BGM2 = try AVAudioPlayer(contentsOf: BGMUrl)
        } catch let error as NSError {
            audioError = error
            BGM2 = nil
        }
        if let error = audioError {
            print("Error \(error.localizedDescription)")
        }
        BGM2!.delegate = self
        BGM2!.play()
        BGM2!.numberOfLoops = -1
    }
    
    func playBGM(){
        let BGMpath = Bundle.main.path(forResource: "natto_bgm_game", ofType:"wav")!
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
        BGM!.numberOfLoops = -1
    }
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        player.currentTime = 0
    }
    
}
