//
//  ResultPresenter.swift
//  natto
//
//  Created by 佐川晴海 on 2019/03/17.
//  Copyright © 2019 佐川　晴海. All rights reserved.
//

import Foundation

protocol ResultPresenter {
    func isPopUpReviewDialog() -> Bool
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

    func isPopUpReviewDialog() -> Bool {
        return model.isPopUpReviewDialog()
    }
}
