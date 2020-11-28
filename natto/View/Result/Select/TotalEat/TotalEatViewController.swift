//
//  TotalEatViewController.swift
//  natto
//
//  Created by 佐川 晴海 on 2020/10/13.
//  Copyright © 2020 佐川　晴海. All rights reserved.
//

import UIKit

class TotalEatViewController: UIViewController {

    @IBOutlet weak var totalNattoDescriptionLabel: UILabel!{
        didSet {
            totalNattoDescriptionLabel.font = UIFont(name: "Verdana-bold", size: 25)
            totalNattoDescriptionLabel.text = localizeString(key: LocalizeKeys.TotalEat.eatNatto)
        }
    }
    @IBOutlet weak var totalNattoCountLabel: UILabel!{
        didSet {
            totalNattoCountLabel.font = UIFont(name: "Verdana-bold", size: 25)
            totalNattoCountLabel.text = localizeString(key: LocalizeKeys.TotalEat.grouth)
        }
    }
    @IBOutlet weak var nextGrouthLabel: UILabel!{
        didSet {
            nextGrouthLabel.font = UIFont(name: "Verdana-bold", size: 25)
            nextGrouthLabel.text = localizeString(key: LocalizeKeys.TotalEat.grouth, "123456789")
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = AppColor.background.color
        let totalNattoCount = UserStore.totalNattoCount
        totalNattoCountLabel.text = totalNattoCount.description + "粒"
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        dismiss(animated: false, completion: nil)
    }

}
