//
//  DescriptionViewController.swift
//  natto
//
//  Created by 佐川晴海 on 2019/04/13.
//  Copyright © 2019 佐川　晴海. All rights reserved.
//

import UIKit

class DescriptionViewController: UIViewController {

    @IBOutlet weak var descriptionLabel1: UILabel! {
        didSet {
            descriptionLabel1.text = "①納豆をできるだけたくさん混ぜ、ねばりけを出します。白いネベネバをたくさん発生させることで納豆の吸着率が変化します"
        }
    }
    @IBOutlet weak var descriptionLabel2: UILabel! {
        didSet {
            descriptionLabel2.text = "②時間内に納豆を持ち上げてできるだけたくさん食べます"
        }
    }
    @IBOutlet weak var descriptionLabel3: UILabel! {
        didSet {
            descriptionLabel3.text = "③食べた納豆の数でスコアが決まります!良い結果が出たらSNSに投稿しよう！"
        }
    }
    
    // - MARK: LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .clear
    }
    
    // - MARK: Event
    
    @IBAction func closeDescription(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
}
