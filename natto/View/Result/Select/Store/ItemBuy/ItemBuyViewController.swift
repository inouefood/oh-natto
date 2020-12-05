//
//  ItemBuyViewController.swift
//  natto
//
//  Created by 佐川 晴海 on 2020/12/05.
//  Copyright © 2020 佐川　晴海. All rights reserved.
//

import UIKit

class ItemBuyViewController: UIViewController {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var pickerView: UIPickerView!
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    private let mockCount = [ "1","2","3","4"]
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        pickerView.delegate = self
        pickerView.dataSource = self
        
    }
    @IBAction func PurchaseAction(_ sender: Any) {
        //TODO 正しい値が入るように修正する
        showInformation(title: "購入", message: "xxxポイントでxxをxx個購入しますか？", yesButtonText: "はい", closeButtonText: "やめる") {
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
    
    @IBAction func dismissAction(_ sender: Any) {
        dismiss(animated: false, completion: nil)
    }
    
}

extension ItemBuyViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return mockCount.count
    }
    
    func pickerView(_ pickerView: UIPickerView,
                    titleForRow row: Int,
                    forComponent component: Int) -> String? {
        
        return mockCount[row]
    }
    
    
}
