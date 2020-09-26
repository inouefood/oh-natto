//
//  SNSShareData.swift
//  natto
//
//  Created by 佐川 晴海 on 2020/09/26.
//  Copyright © 2020 佐川　晴海. All rights reserved.
//

import UIKit


class SNSShareData {
    static let shared = SNSShareData()
    private init() {}
    var button: UIButton = UIButton()
    var message: String = "\(localizeString(key: LocalizeKeys.Result.tweet))\n https://itunes.apple.com/us/app/oh-natto/id1457049172?mt=8"
}
