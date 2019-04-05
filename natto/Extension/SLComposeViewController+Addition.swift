//
//  SLComposeViewController+Addition.swift
//  natto
//
//  Created by 佐川晴海 on 2019/04/03.
//  Copyright © 2019 佐川　晴海. All rights reserved.
//

import Foundation
import Social

extension SLComposeViewController {
    func showTwitterDialog(message: String, vc: UIViewController){
        let twitterCmp : SLComposeViewController = SLComposeViewController(forServiceType: SLServiceTypeTwitter)
        twitterCmp.setInitialText(message)
        vc.present(twitterCmp, animated: true, completion: nil)
    }
    
    func showFacebookDialog(message: String, vc: UIViewController){
        let facebookCmp : SLComposeViewController = SLComposeViewController(forServiceType: SLServiceTypeFacebook)
        facebookCmp.setInitialText(message)
        vc.present(facebookCmp, animated: true, completion: nil)
    }
    func showLineDialog(message: String, vc: UIViewController){
        guard let  encodedURL = message.addingPercentEncoding(withAllowedCharacters: NSCharacterSet.urlQueryAllowed) else {
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
