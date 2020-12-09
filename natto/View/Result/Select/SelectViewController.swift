//
//  SelectViewController.swift
//  natto
//
//  Created by 佐川 晴海 on 2020/10/13.
//  Copyright © 2020 佐川　晴海. All rights reserved.
//

import UIKit
import GameKit

class SelectViewController: UIViewController {
    var shareImage: UIImage?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .clear
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if GKLocalPlayer.local.isAuthenticated {
            authenticateLocalPlayer()
        }
    }

    @IBAction func openStorePage(_ sender: Any) {
        let vc = StoreViewController()
        vc.modalPresentationStyle = .overCurrentContext
        present(vc, animated: true, completion: nil)
    }
    
    @IBAction func openLeaderBoard(_ sender: Any) {
        let player = GKLocalPlayer.local
        if player.isAuthenticated {
            openLeaderBordScoreLanking()
        } else {
            authenticateLocalPlayer()
        }
    }
    @IBAction func openTotalEatPage(_ sender: Any) {
        let vc = TotalEatViewController()
        vc.modalPresentationStyle = .overCurrentContext
        present(vc, animated: false, completion: nil)
    }
    
    @IBAction func openSettingPage(_ sender: Any) {
        present(SettingViewController(), animated: true, completion: nil)
    }
    @IBAction func dismissAction(_ sender: Any) {
        dismiss(animated: false, completion: nil)
    }
    
    @IBAction func shareAction(_ sender: Any) {
        var activityItems: [Any] = []
        if let image = shareImage {
            activityItems = ["\(localizeString(key: LocalizeKeys.Result.tweet)) https://itunes.apple.com/us/app/oh-natto/id1457049172?mt=8", image]
        } else {
            print("start")
            activityItems = ["\(localizeString(key: LocalizeKeys.Result.tweet)) https://itunes.apple.com/us/app/oh-natto/id1457049172?mt=8"]
            print("stop")
        }

        let activityVc = UIActivityViewController(activityItems: activityItems, applicationActivities: nil)
        let horizonSizeClass = UITraitCollection(horizontalSizeClass: .regular)
        let verticalSizeClass = UITraitCollection(verticalSizeClass: .regular)
        let isRegularRegularSize = traitCollection.containsTraits(in: horizonSizeClass)
            && traitCollection.containsTraits(in: verticalSizeClass)
        if isRegularRegularSize {
            activityVc.popoverPresentationController?.sourceView = self.view
            activityVc.popoverPresentationController?.sourceRect = CGRect(x: self.view.bounds.size.width,
                                                                          y: self.view.bounds.size.height,
                                                                          width: 1.0,
                                                                          height: 1.0)
        }
        
        self.present(activityVc, animated: true, completion: nil)
    }
    
    private func authenticateLocalPlayer() {
        let player = GKLocalPlayer.local
        player.authenticateHandler = {(viewController, error) -> Void in
            if viewController != nil
            {
                self.present(viewController!, animated: true, completion: nil)
            } else {
                print("viewController is nil")
            }
        }
    }
    
    private func openLeaderBordScoreLanking() {
        let localPlayer = GKLocalPlayer()
        localPlayer.loadDefaultLeaderboardIdentifier(completionHandler: {leaderboardIdentifier,error in
            if error != nil {
                print(error.debugDescription)
            } else {
                
                let gcvc:GKGameCenterViewController = GKGameCenterViewController()
                gcvc.gameCenterDelegate = self
                gcvc.viewState = .leaderboards
                gcvc.leaderboardIdentifier = Constant.LeaderBoard.id
                self.present(gcvc, animated: true, completion: nil)
            }
        })
    }

}


extension SelectViewController: GKGameCenterControllerDelegate {
    func gameCenterViewControllerDidFinish(_ gameCenterViewController: GKGameCenterViewController) {
        self.dismiss(animated: true, completion: nil)
    }
}
