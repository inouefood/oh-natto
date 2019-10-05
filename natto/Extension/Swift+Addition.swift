//
//  Swift+Addition.swift
//  natto
//
//  Created by 佐川晴海 on 2019/10/05.
//  Copyright © 2019 佐川　晴海. All rights reserved.
//

import UIKit

func localizeString(key: LocalizeKeyGeneratable, comment: String = "", _ arguments: CVarArg...) -> String {
    let str = NSLocalizedString(key.key, comment: comment)
    return String(format: str, arguments: arguments)
}
