//
//  ResultModel.swift
//  natto
//
//  Created by 佐川晴海 on 2019/03/17.
//  Copyright © 2019 佐川　晴海. All rights reserved.
//

import Foundation
import AVFoundation
import Social

protocol ResultModelInput {
    func loadAudio(resourceName:String, resourceType: String)
    func playAudio()
    func isPopUpReviewDialog() -> Bool
    func checkScoreEvaluation(score: Int) -> Bool
}
class ResultModel: ResultModelInput{
    private var audio: AVAudioPlayer?
    private let userDefault = UserDefaults.standard
    
    func loadAudio(resourceName: String, resourceType: String) {
        let path = Bundle.main.path(forResource: resourceName, ofType: resourceType)
        let url = URL(fileURLWithPath: path!)
        do { try  audio = AVAudioPlayer(contentsOf: url) }
        catch{ fatalError() }
        audio?.numberOfLoops = -1
        audio?.prepareToPlay()
    }
    
    func playAudio() {
        audio?.play()
    }
    
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
        let key = "openResultCount"
        UserDefaults.standard.set(UserDefaults.standard.integer(forKey: key) + 1, forKey: key)
        UserDefaults.standard.synchronize()
        let count = UserDefaults.standard.integer(forKey: key)
        if count % 5 == 0 {
            return true
        }
        return false
    }
    
    private func saveBestScore(topScore: [Int], score: Int) {
        var scores = topScore
        
        if scores.count <= 3  {
            scores.append(score)
        } else {
            scores.remove(at: topScore.last!)
            scores.append(score)
        }
        userDefault.set(scores, forKey: "topScore")
    }
}
