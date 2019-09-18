//
//  ResultModel.swift
//  natto
//
//  Created by 佐川晴海 on 2019/03/17.
//  Copyright © 2019 佐川　晴海. All rights reserved.
//

import Foundation
import Social

protocol ResultModelInput {
    func isPopUpReviewDialog() -> Bool
    func checkScoreEvaluation(score: Int) -> Bool
}
class ResultModel: ResultModelInput{

    private let userDefault = UserDefaults.standard
    
    func checkScoreEvaluation(score: Int) -> Bool {
        var isBestScore = false
       
        if userDefault.object(forKey: "topScore") != nil {
            let topScore:[Int] = userDefault.array(forKey: "topScore") as! [Int]
            
            topScore.forEach{ beforeScore in
                if beforeScore < score {
                    isBestScore = true
                }
            }
            if isBestScore {
                saveBestScore(topScore: topScore, score: score)
            }
        } else {
            // At first score
            userDefault.set([score], forKey: "topScore")
        }
        return isBestScore
    }
    
    func isPopUpReviewDialog() -> Bool {
        if userDefault.object(forKey: "isAlreadyDisplayedReviewAlert") != nil {
            return false
        }
        userDefault.set(true, forKey: "isAlreadyDisplayedReviewAlert")
        return true
    }
    
    private func saveBestScore(topScore: [Int], score: Int) {
        var scores = topScore
        
        if scores.count <= 3  {
            scores.append(score)
        } else {
            scores.sort()
            scores.reverse()
            scores.remove(at: scores.count - 1)
            scores.append(score)
        }
        userDefault.set(scores, forKey: "topScore")
    }
}
