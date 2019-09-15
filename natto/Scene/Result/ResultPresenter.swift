//
//  ResultPresenter.swift
//  natto
//
//  Created by 佐川晴海 on 2019/03/17.
//  Copyright © 2019 佐川　晴海. All rights reserved.
//

import Foundation
import Social

protocol ResultPresenter {
    func loadAudio(resourceName: String, resourceType: String)
    func playAudio()
    func showTweetDialog(text: String) -> SLComposeViewController
    func isPopUpReviewDialog() -> Bool
    func checkScoreEvaluation(score: Int)
}
class ResultPresenterImpl: ResultPresenter {
    
    private var model: ResultModelInput
    
    init() {
        model = ResultModel()
    }
    func loadAudio(resourceName: String, resourceType: String) {
        model.loadAudio(resourceName: resourceName, resourceType: resourceType)
    }
    
    func checkScoreEvaluation(score: Int) {
        if model.checkScoreEvaluation(score: score) {
            print("a")
        } else {
            print("aa")
        }
    }
    
    func playAudio() {
        model.playAudio()
    }
    func showTweetDialog(text: String) -> SLComposeViewController{
        let twitterCmp : SLComposeViewController = SLComposeViewController(forServiceType: SLServiceTypeTwitter)
        twitterCmp.setInitialText(text)
        return twitterCmp
    }
    func isPopUpReviewDialog() -> Bool {
        return model.isPopUpReviewDialog()
    }
}
