//
//  StoreViewController.swift
//  natto
//
//  Created by 佐川 晴海 on 2020/10/11.
//  Copyright © 2020 佐川　晴海. All rights reserved.
//

import UIKit

class StoreViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBAction func buyAction(_ sender: Any) {
        showInformation(title: "購入", message: " ネギを納豆と交換しますか？", yesButtonText: "はい", closeButtonText: "やめる") {
            let eatKey = "natto"
            guard let eatPoint = UserStore.eatPoint,
                  var nattoPoint = eatPoint[eatKey] else {
                return
            }
            nattoPoint -= 30
            UserStore.eatPoint?.updateValue(nattoPoint, forKey: eatKey)
            
            
            //アイテム購入
            let negiKey = "ownedNegi"
            guard let item = UserStore.ownedItem,
                  let negi = item[negiKey] else {
                UserStore.ownedItem = [negiKey:1]
                return
            }
            UserStore.ownedItem?.updateValue(negi + 1, forKey: negiKey)
            
        }
    }
}
