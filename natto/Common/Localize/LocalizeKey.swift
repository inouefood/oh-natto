//
//  Localize.swift
//  natto
//
//  Created by 佐川晴海 on 2019/10/05.
//  Copyright © 2019 佐川　晴海. All rights reserved.
//

import UIKit

protocol LocalizeKeyGeneratable {
    var key: String { get }
}

struct LocalizeKeys {
    enum Notification: String, LocalizeKeyGeneratable {
        case title = "NOTIFICATION.TITLE"
        case message = "NOTIFOCATION.MESSAGE"
        var key: String {
            return rawValue
        }
    }
    enum UpdateLeast: String, LocalizeKeyGeneratable {
        case message = "UPDATEALERT.MESSAGE"
        case buttonUpdate = "UPDATEALERT.BUTTON.UPDATE"
        case buttonClose = "UPDATEALERT.BUTTON.CLOSE"
        var key: String {
            return rawValue
        }
    }
    
    enum Description: String, LocalizeKeyGeneratable {
        case one = "DESCRIPTION.1"
        case two = "DESCRIPTION.2"
        case three = "DESCRIPTION.3"
        var key: String {
            return rawValue
        }
    }
    
    enum Title: String, LocalizeKeyGeneratable {
        case buttonStart = "TITLE.BUTTON.START"
        var key: String {
            return rawValue
        }
    }
    enum Result: String, LocalizeKeyGeneratable {
        case buttonRelpay = "RESULT.BUTTON.REPLAY"
        var key: String {
            return rawValue
        }
    }
}









