//
//  AppVersionTableViewCell.swift
//  natto
//
//  Created by 佐川 晴海 on 2020/10/26.
//  Copyright © 2020 佐川　晴海. All rights reserved.
//

import UIKit

class AppVersionTableViewCell: UITableViewCell {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var versionLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        guard let currentAppVersionString = Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as? String else {
            return
        }
        versionLabel.text = "v" + currentAppVersionString
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
