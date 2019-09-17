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
    func showTweetDialog(text: String) -> SLComposeViewController
    func isPopUpReviewDialog() -> Bool
    func checkScoreEvaluation(score: Int)
}
protocol ResultPresenterOutput: class {
    func showScoreComparison(isBest: Bool)
}
class ResultPresenterImpl: ResultPresenter {
    
    private var model: ResultModelInput
    private weak var output: ResultPresenterOutput?
    
    
    init(output: ResultPresenterOutput) {
        self.output = output
        model = ResultModel()
    }
    
    func checkScoreEvaluation(score: Int) {
        output?.showScoreComparison(isBest: model.checkScoreEvaluation(score: score))
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
