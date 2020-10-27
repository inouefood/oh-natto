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
        }
    }
    @IBOutlet weak var totalNattoCountLabel: UILabel!{
        didSet {
            totalNattoCountLabel.font = UIFont(name: "Verdana-bold", size: 25)
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        let totalNattoCount = UserStore.totalNattoCount
        totalNattoCountLabel.text = totalNattoCount.description + "粒"
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        dismiss(animated: false, completion: nil)
    }

}
