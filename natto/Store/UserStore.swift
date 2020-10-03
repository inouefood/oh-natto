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
        case pastScore
        case isNeedDisplayedReviewAlert
        case totalNattoCount
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
    static var pastScore: [Int]? {
        set {
            UserDefaults.standard.set(newValue, forKey: Key.pastScore.rawValue)
            UserDefaults.standard.synchronize()
        }
        get {
            guard let pastScore =  UserDefaults.standard.object(forKey: Key.pastScore.rawValue) as? [Int] else {
                return nil
            }
            return pastScore
            
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
}

extension UserStore {
    static func topScore() -> Int? {
        guard let pastScore =  UserDefaults.standard.object(forKey: Key.pastScore.rawValue) as? [Int] else {
            return nil
        }
        
        let sortScore: [Int] = pastScore.sorted(by: >)
        let bestScore = sortScore.first
        
        return bestScore
    }
}
