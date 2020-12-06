//
//  ItemBuyViewController.swift
//  natto
//
//  Created by 佐川 晴海 on 2020/12/05.
//  Copyright © 2020 佐川　晴海. All rights reserved.
//

import UIKit

class ItemBuyViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var pickerView: UIPickerView!
    @IBOutlet weak var ownedPointLabel: UILabel!
    
    var buyItem: ToppingType!
    var ownedPoint: Int!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    private var pickerArr: [String] = []
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        purchaseCount()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        pickerView.delegate = self
        pickerView.dataSource = self
        commonInit()
        
    }
    @IBAction func PurchaseAction(_ sender: Any) {
        let pickerCount = self.pickerView.selectedRow(inComponent: 0)
        let totalPoint = buyItem.price * Int(pickerCount)
        
        showInformation(title: localizeString(key: LocalizeKeys.ItemBuy.alertTitle),
                        message: localizeString(key: LocalizeKeys.ItemBuy.alertMessage,
                                                totalPoint, buyItem.name, pickerCount),
                        yesButtonText: localizeString(key: LocalizeKeys.ItemBuy.alertYesButton),
                        closeButtonText: localizeString(key: LocalizeKeys.ItemBuy.alertNoButton)) { [self] in
            let eatKey = "natto"
            guard let eatPoint = UserStore.eatPoint,
                  let nattoPoint = eatPoint[eatKey] else {
                return
            }
            let newNattoPoint = nattoPoint - totalPoint
            UserStore.eatPoint?.updateValue(newNattoPoint, forKey: eatKey)

            //アイテム購入
            guard let item = UserStore.ownedItem else {
                //itemが何もない時はそのまま追加
                var item: OwnedItem
                switch buyItem! {
                case .negi:
                    item =
                    OwnedItem(negi: pickerCount, okura: 0, sirasu: 0)
                case .okura:
                    item = OwnedItem(negi: 0, okura: pickerCount, sirasu: 0)
                case .sirasu:
                    item = OwnedItem(negi: 0, okura: 0, sirasu: pickerCount)
                }
                UserStore.ownedItem = item
                return
            }
            
            var newItems: OwnedItem
            switch buyItem!{
            case .negi:
                newItems = OwnedItem(negi: item.negi + pickerCount,
                                     okura: item.okura,
                                     sirasu: item.sirasu)
            case .okura:
                newItems = OwnedItem(negi: item.negi,
                                     okura: item.okura + pickerCount,
                                     sirasu: item.sirasu)
            case .sirasu:
                newItems = OwnedItem(negi: item.negi,
                                     okura: item.okura,
                                     sirasu: item.sirasu + pickerCount)
            }

            UserStore.ownedItem = newItems
            dismiss(animated: false, completion: nil)
        }
    }
    
    @IBAction func dismissAction(_ sender: Any) {
        dismiss(animated: false, completion: nil)
    }
    
    private func commonInit(){
        imageView.image = buyItem.image
        titleLabel.text = buyItem.name
        let eatKey = "natto"
        guard let eatPoint = UserStore.eatPoint,
              let nattoPoint = eatPoint[eatKey] else {
            return
        }
        
        ownedPointLabel.text = localizeString(key: LocalizeKeys.ItemBuy.ownedLabelText, nattoPoint)
    }
    
    private func purchaseCount(){
        let eatKey = "natto"
        guard let eatPoint = UserStore.eatPoint,
              let nattoPoint = eatPoint[eatKey] else {
            return
        }
        let count = nattoPoint / buyItem.price
        for i in 0..<count+1 {
            pickerArr.append((i).description)
        }
        
    }
}

extension ItemBuyViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerArr.count
    }
    
    func pickerView(_ pickerView: UIPickerView,
                    titleForRow row: Int,
                    forComponent component: Int) -> String? {
        
        return pickerArr[row]
    }
    
    
}
