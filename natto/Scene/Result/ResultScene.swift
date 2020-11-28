//
//  ResultScene.swift
//  natto
//
//  Created by 佐川　晴海 on 2018/03/10.
//  Copyright © 2018年 佐川　晴海. All rights reserved.
//
import SpriteKit

class ResultScene: SKScene{
    
    // MARK: - NodeInitialize
    lazy var replayLabel: SKLabelNode! = {
        return SKLabelNode(fontSize: 100, text: localizeString(key: LocalizeKeys.Result.buttonRelpay),
                           pos: CGPoint(x: self.frame.midX, y: height * 0.20))
    }()


    // MARK: - Property
    let resultScore:Int
    
    
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
        self.backgroundColor = AppColor.background.color
        let vc = ResultViewController(score: resultScore)
        vc.dismissHandler = {
            
            vc.audio.stop()
            vc.dismiss(animated: false, completion: nil)
            let scene = TitleScene(size: self.size)
            view.presentScene(scene)
        }
        vc.modalPresentationStyle = .overCurrentContext
        topViewController()?.present(vc, animated: false, completion: nil)
    }

    // MARK: - Event
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touches:AnyObject in touches{
            let location = touches.previousLocation(in: self)
            let touchNode = self.atPoint(location)
            
            if touchNode == replayLabel{
                
                let scene = TitleScene(size: self.size)
                self.view!.presentScene(scene)
            }
        }
    }
}
