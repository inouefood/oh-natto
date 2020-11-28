//
//  AppColor.swift
//  natto
//
//  Created by 佐川 晴海 on 2020/11/28.
//  Copyright © 2020 佐川　晴海. All rights reserved.
//

import UIKit

enum AppColor {
    case background
    case gamePlayBackground
    case button
    case white
    case tutorial
    
    var color: UIColor {
        switch self {
        case .background:
            return UIColor(named: "background")!
        case .gamePlayBackground:
            return UIColor(named: "gamePlayBackground")!
        case .button:
            return UIColor(named: "button")!
        case .white:
            return UIColor(named: "white")!
        case .tutorial:
            return UIColor(named: "tutorial")!
        }
    }
}
