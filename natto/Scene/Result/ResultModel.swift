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
}
class ResultModel: ResultModelInput{
    
    func isPopUpReviewDialog() -> Bool {
        if UserStore.isNeedDisplayedReviewAlert {
            UserStore.isNeedDisplayedReviewAlert = false
            return true
        } else {
            return false
        }
    }
}
