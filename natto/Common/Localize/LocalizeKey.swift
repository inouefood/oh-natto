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
        case title = "DESCRIPTION.TITLE"
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
        case score = "RESULT.LABEL.SCORE"
        case bestScore =  "RESULT.LABEL.BESTSCORE"
        case tweet = "RESULT.TWITTER"
        var key: String {
            return rawValue
        }
    }
    
    enum BestScore: String, LocalizeKeyGeneratable {
        case title = "BEST.LABEL.TITLE"
        case close = "BEST.BUTTON.CLOSE"
        case share = "BEST.BUTTON.SHARE"
        var key: String {
            return rawValue
        }
    }
    
    enum Setting: String, LocalizeKeyGeneratable {
        case cellArrVibration = "SETTING.CELLARR.VIBRATION"
        case cellArrPrivacyPolicy = "SETTING.CELLARR.PRIVACYPOLICY"
        case cellArrReview = "SETTING.CELLARR.REVIEW"
        case cellArrPushNortification = "SETTING.CELLARR.PUSHNORTIFICATION"
        case cellArrVersion = "SETTING.CELLARR.VERSION"
        case sectionArrSetting = "SETTING.SECTIONARR.SETTING"
        case sectionArrOther = "SETTING.SECTIONARR.OTHER"
        
        var key: String {
            return rawValue
        }
    }
    
    enum ToppingSelect: String, LocalizeKeyGeneratable {
        case decision = "TOPPINGSELECT.DECISION"
        case reset = "TOPPINGSELECT.RESET"
        case alertItemLess = "TOPPINGSELECT.ALERT.ITEMLESS"
        case alertSelectOver = "TOPPINGSELECT.ALERT.SELECTOVER"
        var key: String {
            return rawValue
        }
    }
}
