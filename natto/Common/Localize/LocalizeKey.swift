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
        case zero = "DESCRIPTION.0"
        case one = "DESCRIPTION.1"
        case two = "DESCRIPTION.2"
        case three = "DESCRIPTION.3"
        case four = "DESCRIPTION.4"
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
        case scoreTitle = "RESULT.LABEL.SCORETITLE"
        case tweet = "RESULT.TWITTER"
        case tipsTitle = "RESULT.TIPSTITLE"
        var key: String {
            return rawValue
        }
    }
    
    enum Tips: String, LocalizeKeyGeneratable {
        case a = "TIPS.0"
        case b = "TIPS.1"
        case c = "TIPS.2"
        case d = "TIPS.3"
        case e = "TIPS.4"
        case f = "TIPS.5"
        case g = "TIPS.6"
        case h = "TIPS.7"
        case i = "TIPS.8"
        case j = "TIPS.9"
        case k = "TIPS.10"
        case l = "TIPS.11"
        case m = "TIPS.12"
        case n = "TIPS.13"
        case o = "TIPS.14"
        case p = "TIPS.15"
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
    
    enum TotalEat: String, LocalizeKeyGeneratable {
        case eatNatto = "TOTALEAT.EATNATTO"
        case grouth = "TOTALEAT.GROUTH"
        case grain = "TOTALEAT.GRAIN"
        
        var key: String {
            return rawValue
        }
    }
    
    enum ItemBuy: String, LocalizeKeyGeneratable {
        case alertTitle = "ITEMBUY.ALERT.TITLE"
        case alertMessage = "ITEMBUY.ALERT.MESSAGE"
        case alertYesButton = "ITEMBUY.ALERT.BUTTON.YES"
        case alertNoButton = "ITEMBUY.ALERT.BUTTON.NO"
        case ownedLabelText = "ITEMBUY.OWNEDLABEL.TEXT"
        var key: String {
            return rawValue
        }
    }
}
