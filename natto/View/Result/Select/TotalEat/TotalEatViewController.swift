//
//  TotalEatViewController.swift
//  natto
//
//  Created by 佐川 晴海 on 2020/10/13.
//  Copyright © 2020 佐川　晴海. All rights reserved.
//

import UIKit

class TotalEatViewController: UIViewController {

    @IBOutlet weak var totalIcon: UIImageView!
    @IBOutlet weak var totalNattoDescriptionLabel: UILabel!
    @IBOutlet weak var totalNattoCountLabel: UILabel!
    @IBOutlet weak var nextGrouthLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = AppColor.background.color
        let totalNattoCount = UserStore.totalNattoCount
        
        commonInit(eatNum: totalNattoCount)
        setNextGrouthGrain(eatNum: totalNattoCount)
    }
    
    private func commonInit(eatNum: Int){
        totalNattoCountLabel.text = localizeString(key: LocalizeKeys.TotalEat.grain, eatNum)
        totalNattoCountLabel.font = UIFont(name: "Verdana-bold", size: 25)
        
        totalNattoDescriptionLabel.font = UIFont(name: "Verdana-bold", size: 25)
        totalNattoDescriptionLabel.text = localizeString(key: LocalizeKeys.TotalEat.eatNatto)
        
    }
    
    private func setNextGrouthGrain(eatNum: Int){
        nextGrouthLabel.font = UIFont(name: "Verdana-bold", size: 25)
        
        if eatNum < 1000 {
            totalIcon.image = UIImage(named: "totalEat-one")
            nextGrouthLabel.text = localizeString(key: LocalizeKeys.TotalEat.grouth, 1000 - eatNum)
        } else if eatNum > 1000 && eatNum < 3000 {
            totalIcon.image = UIImage(named: "totalEat-two")
            nextGrouthLabel.text = localizeString(key: LocalizeKeys.TotalEat.grouth, 3000 - eatNum)
        } else if eatNum > 3000 && eatNum < 8000 {
            totalIcon.image = UIImage(named: "totalEat-three")
            nextGrouthLabel.text = localizeString(key: LocalizeKeys.TotalEat.grouth, 8000 - eatNum)
        } else if eatNum > 8000 {
            totalIcon.image = UIImage(named: "totalEat-four")
            nextGrouthLabel.text = ""
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        dismiss(animated: false, completion: nil)
    }

}
