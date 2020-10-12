//
//  UIViewController+Addition.swift
//  natto
//
//  Created by 佐川晴海 on 2019/07/08.
//  Copyright © 2019 佐川　晴海. All rights reserved.
//

import UIKit

extension UIViewController {
    
    func showAppStoreInformation(url:String, title: String = "", message: String,openText: String, closeText: String, handler: (() -> Void)? = nil) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        let open: UIAlertAction = UIAlertAction(title: openText, style: .default, handler: { _ in
            let url = URL(string: url)!
            
            // URLを開けるかをチェックする
            if UIApplication.shared.canOpenURL(url) {
                // URLを開く
                UIApplication.shared.open(url, options: [:]) { success in
                    if success {
                        print("Launching \(url) was successful")
                    }
                }
            }
        })
        let close: UIAlertAction = UIAlertAction(title: closeText, style: UIAlertAction.Style.default, handler: { _ in
            alert.dismiss(animated: true, completion: nil)
            
            handler?()
        })
        alert.addAction(open)
        alert.addAction(close)        
        present(alert, animated: true, completion: nil)
    }

    func showInformation(title: String = "", message: String = "", yesButtonText: String,
                         closeButtonText: String, handler: (() -> Void)? = nil) {
        
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        
        let yes: UIAlertAction = UIAlertAction(title: yesButtonText, style: .default, handler: { _ in
            alert.dismiss(animated: true, completion: nil)
            handler?()
        })
        
        let close: UIAlertAction = UIAlertAction(title: closeButtonText, style: .default, handler: { _ in
            alert.dismiss(animated: true, completion: nil)
        })
        alert.addAction(yes)
        alert.addAction(close)
        present(alert, animated: true, completion: nil)
    }
    
}
