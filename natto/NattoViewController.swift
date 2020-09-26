//
//  NattoViewController.swift
//  natto
//
//  Created by 佐川晴海 on 2019/04/12.
//  Copyright © 2019 佐川　晴海. All rights reserved.
//

import UIKit
import SpriteKit

//TODO グローバル変数になっているので修正する
let tutorialButton = UIButton()

class NattoViewController: UIViewController {
    
    // MARK: - LifeCycle
    
    override func loadView() {
        let skView = SKView(frame: UIScreen.main.bounds)
        self.view = skView
        
        tutorialButton.backgroundColor = .red
        tutorialButton.frame.size = CGSize(width: 60, height: 60)
        tutorialButton.layer.position = CGPoint(x: (self.view?.frame.width)! - tutorialButton.frame.width * 1.1, y: 70)
        tutorialButton.titleLabel!.font = UIFont.systemFont(ofSize: 40)
        tutorialButton.layer.cornerRadius = tutorialButton.frame.width/2
        tutorialButton.setTitle("?", for: .normal)
        tutorialButton.addTarget(self, action: #selector(showTutorialTapped), for: .touchUpInside)
        self.view.addSubview(tutorialButton)
        
        SNSShareData.shared.button.backgroundColor = .lightGray
        SNSShareData.shared.button.frame.size = CGSize(width: 50, height: 50)
        SNSShareData.shared.button.setImage(UIImage(named: "share"), for: .normal)
        SNSShareData.shared.button.layer.position = CGPoint(x: (self.view?.frame.width)! - tutorialButton.frame.width * 1.1,y: (self.view?.frame.height)! - 50)
        SNSShareData.shared.button.layer.cornerRadius = SNSShareData.shared.button.frame.width/2
        SNSShareData.shared.button.addTarget(self, action: #selector(showSNSTapped), for: .touchUpInside)
        SNSShareData.shared.button.isHidden = true
        self.view.addSubview(SNSShareData.shared.button)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        AppVersionCompare.toAppStoreVersion(appId: "1457049172") { (type) in
            switch type {
            case .latest:
                print("最新バージョンです")
            case .old:
                self.showAppStoreInformation(url: "https://apps.apple.com/jp/app/oh-natto/id1457049172", title: "App Store", message: localizeString(key: LocalizeKeys.UpdateLeast.message), openText: localizeString(key: LocalizeKeys.UpdateLeast.buttonUpdate), closeText: localizeString(key: LocalizeKeys.UpdateLeast.buttonClose))
            case .error:
                print("エラー")
            }
        }

        let skView = self.view as! SKView
        skView.ignoresSiblingOrder = true
        let size = CGSize(width: skView.bounds.size.width*2, height: skView.bounds.size.height*2)
        let scene = TitleScene(size: size)
        skView.presentScene(scene)
        
    }
    override func viewDidAppear(_ animated: Bool) {
        
        if UserStore.isFirstSession {
            UserStore.isFirstSession = false
            
            let vc = DescriptionViewController()
            vc.modalPresentationStyle = .overCurrentContext
            self.present(vc, animated: true, completion: nil)
        }
    }
    
    // MARK: - Event
    
    @objc func showTutorialTapped() {
        let vc = DescriptionViewController()
        vc.modalPresentationStyle = .overCurrentContext
        self.present(vc, animated: true, completion: nil)
    }
    
    @objc func showSNSTapped() {
        let activityItems: [Any] = [SNSShareData.shared.message]

        let activityVc = UIActivityViewController(activityItems: activityItems, applicationActivities: nil)
        activityVc.modalPresentationStyle = .fullScreen
        self.present(activityVc, animated: true, completion: nil)
    }
    
    override var preferredScreenEdgesDeferringSystemGestures: UIRectEdge {
        return .all
    }
}
