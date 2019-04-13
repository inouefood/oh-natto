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
            descriptionLabel1.text = "①納豆をできるだけたくさん混ぜてねばりけを出します。混ぜた量によって次の画面での納豆の吸着率が変化します"
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
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .clear
    }
}
