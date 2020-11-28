//
//  SelectViewController.swift
//  natto
//
//  Created by 佐川 晴海 on 2020/10/13.
//  Copyright © 2020 佐川　晴海. All rights reserved.
//

import UIKit

class SelectViewController: UIViewController {
    var shareImage: UIImage?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .clear
        // Do any additional setup after loading the view.
    }

    @IBAction func openStorePage(_ sender: Any) {
        let vc = StoreViewController()
        vc.modalPresentationStyle = .overCurrentContext
        present(vc, animated: false, completion: nil)
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
        //TODO 画像をツイートできるようにする        
        let activityItems: [Any] = ["\(localizeString(key: LocalizeKeys.Result.tweet)) https://itunes.apple.com/us/app/oh-natto/id1457049172?mt=8", shareImage]

        let activityVc = UIActivityViewController(activityItems: activityItems, applicationActivities: nil)
        activityVc.modalPresentationStyle = .fullScreen
        self.present(activityVc, animated: true, completion: nil)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        dismiss(animated: false, completion: nil)
    }
}
