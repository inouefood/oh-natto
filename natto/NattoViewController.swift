//
//  NattoViewController.swift
//  natto
//
//  Created by 佐川晴海 on 2019/04/12.
//  Copyright © 2019 佐川　晴海. All rights reserved.
//

import UIKit
import SpriteKit

let tutorialButton = UIButton()

class NattoViewController: UIViewController {

    let userDefaults = UserDefaults.standard
    
    // MARK: - LifeCycle
    
    override func loadView() {
        let skView = SKView(frame: UIScreen.main.bounds)
        self.view = skView
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
        
        
        tutorialButton.backgroundColor = .red
        tutorialButton.frame.size = CGSize(width: 80, height: 80)
        tutorialButton.layer.position = CGPoint(x: (self.view?.frame.width)! - tutorialButton.frame.width * 1.1, y: 100)
        tutorialButton.titleLabel!.font = UIFont.systemFont(ofSize: 40)
        tutorialButton.setTitle("?", for: .normal)
        tutorialButton.layer.cornerRadius = tutorialButton.frame.width/2
        tutorialButton.addTarget(self, action: #selector(showTutorialTapped(_:)), for: .touchDown)
        self.view.addSubview(tutorialButton)
        

        let skView = self.view as! SKView
        skView.ignoresSiblingOrder = true
        let size = CGSize(width: skView.bounds.size.width*2, height: skView.bounds.size.height*2)
        let scene = TitleScene(size: size)
        skView.presentScene(scene)
        
        
    }
    override func viewDidAppear(_ animated: Bool) {
        handleUserDefaults()
    }
    
    // MARK: - PrivateMethod
    
    private func handleUserDefaults() {
        
        if userDefaults.object(forKey: "isFirstSession") == nil {
            
            let vc = DescriptionViewController()
            vc.modalPresentationStyle = .overCurrentContext
            self.present(vc, animated: true, completion: nil)
            
            userDefaults.set(true, forKey: "isFirstSession")
            userDefaults.synchronize()
        }
    }
    
    // MARK: - Event
    
    @objc func showTutorialTapped(_ sender:AnyObject) {
        let vc = DescriptionViewController()
        vc.modalPresentationStyle = .overCurrentContext
        self.present(vc, animated: true, completion: nil)
    }
    
    override var preferredScreenEdgesDeferringSystemGestures: UIRectEdge {
        return .all
    }
}
