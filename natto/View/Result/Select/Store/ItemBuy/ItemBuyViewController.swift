//
//  ItemBuyViewController.swift
//  natto
//
//  Created by 佐川 晴海 on 2020/12/05.
//  Copyright © 2020 佐川　晴海. All rights reserved.
//

import UIKit

class ItemBuyViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .clear

    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        showInformation(title: "購入", message: " ネギを納豆と交換しますか？", yesButtonText: "はい", closeButtonText: "やめる") {
            let eatKey = "natto"
            guard let eatPoint = UserStore.eatPoint,
                  var nattoPoint = eatPoint[eatKey] else {
                return
            }
            nattoPoint -= 30
            UserStore.eatPoint?.updateValue(nattoPoint, forKey: eatKey)


            //アイテム購入
            guard var item = UserStore.ownedItem else {
                let item = OwnedItem(negi: 1, okura: 0, sirasu: 0)
                UserStore.ownedItem = item
                return
            }

            item.negi += 1
            UserStore.ownedItem = item

        }
    }

}
