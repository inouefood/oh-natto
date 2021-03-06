//
//  UserStore.swift
//  natto
//
//  Created by 佐川 晴海 on 2020/09/26.
//  Copyright © 2020 佐川　晴海. All rights reserved.
//

import Foundation

final class UserStore {
    private enum Key: String {
        case isFirstSession
        case bestScore
        case isNeedDisplayedReviewAlert
        case totalNattoCount
        case eatPoint
        case ownedItem
        case hapticSetting
    }
    
    //初回表示かどうか
    static var isFirstSession: Bool {
        set {
            UserDefaults.standard.set(newValue, forKey: Key.isFirstSession.rawValue)
            UserDefaults.standard.synchronize()
        }
        get {
            
            guard let isFirstSession = UserDefaults.standard.object(forKey: Key.isFirstSession.rawValue) as? Bool else {
                return true
            }
            return isFirstSession
        }
    }
    
    //最高得点
    static var bestScore: Int? {
        set {
            UserDefaults.standard.set(newValue, forKey: Key.bestScore.rawValue)
            UserDefaults.standard.synchronize()
        }
        get {
            guard let bestScore =  UserDefaults.standard.object(forKey: Key.bestScore.rawValue) as? Int else {
                return nil
            }
            return bestScore
            
        }
    }
    
    //レビューが表示されたかどうか
    static var isNeedDisplayedReviewAlert: Bool {
        set {
            UserDefaults.standard.set(newValue, forKey: Key.isNeedDisplayedReviewAlert.rawValue)
            UserDefaults.standard.synchronize()
        }
        get {
            guard let isNeedDisplayedReviewAlert =  UserDefaults.standard.object(forKey: Key.isNeedDisplayedReviewAlert.rawValue) as? Bool else {
                return true
            }
            return isNeedDisplayedReviewAlert
        }
    }
    
    //今まで納豆を食べた合計の値
    static var totalNattoCount: Int {
        set {
            UserDefaults.standard.set(newValue, forKey: Key.totalNattoCount.rawValue)
            UserDefaults.standard.synchronize()
        }
        get {
            guard let totalNattoCount = UserDefaults.standard.object(forKey: Key.totalNattoCount.rawValue) as? Int else {
                return 0
            }
            
            return totalNattoCount
        }
    }
    
    //納豆、トッピング各種を食べたポイント
    static var eatPoint:[String:Int]? {
        set{
            UserDefaults.standard.set(newValue, forKey: Key.eatPoint.rawValue)
            UserDefaults.standard.synchronize()
        }
        get {
            guard let eatPoint = UserDefaults.standard.object(forKey: Key.eatPoint.rawValue) as?  [String:Int] else {
                return nil
            }
            return eatPoint
        }
        
    }
    
    //保有しているアイテム
    static var ownedItem:OwnedItem? {
        set{
            UserDefaults.standard.set(try? PropertyListEncoder().encode(newValue), forKey: Key.ownedItem.rawValue)
            UserDefaults.standard.synchronize()
        }
        get {
            if let data = UserDefaults.standard.value(forKey: Key.ownedItem.rawValue) as? Data {
                let ownedItem = try? PropertyListDecoder().decode(OwnedItem.self, from: data)
                return ownedItem
            } else {
                return nil
            }
        }
    }
    
    static var hapticSetting: Bool {
        set {
            UserDefaults.standard.set(newValue, forKey: Key.hapticSetting.rawValue)
            UserDefaults.standard.synchronize()
        }
        get {
            guard let hapticSetting =  UserDefaults.standard.object(forKey: Key.hapticSetting.rawValue) as? Bool else {
                return true
            }
            return hapticSetting
        }
    }
}


extension UserStore {
    static func saveEatPoint(natto: Int) {
        let nattoKey = "natto"
        guard var eatPoint = UserStore.eatPoint else {
            UserStore.eatPoint = [nattoKey: natto]
            return
        }
        if let pastNattoPint = eatPoint["natto"]{
            eatPoint.updateValue(pastNattoPint + natto, forKey: nattoKey)
        } else {
            eatPoint.updateValue(natto, forKey: nattoKey)
        }
        
        UserStore.eatPoint = eatPoint
    }
}
