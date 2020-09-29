//
//  ResultModel.swift
//  natto
//
//  Created by 佐川晴海 on 2019/03/17.
//  Copyright © 2019 佐川　晴海. All rights reserved.
//

import Foundation

protocol ResultModelInput {
    func isPopUpReviewDialog() -> Bool
    func checkScoreEvaluation(score: Int) -> Bool
}
class ResultModel: ResultModelInput{
    
    func checkScoreEvaluation(score: Int) -> Bool {
        guard let pastTopScore = UserStore.topScore() else {
            UserStore.pastScore = [score]
            return true
        }
        
        return pastTopScore < score
        
    }
    
    func isPopUpReviewDialog() -> Bool {
        if UserStore.isNeedDisplayedReviewAlert {
            UserStore.isNeedDisplayedReviewAlert = false
            return true
        } else {
            return false
        }
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
        UserStore.pastScore = scores
    }
}
