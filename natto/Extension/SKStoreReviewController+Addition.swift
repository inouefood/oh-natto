//
//  SKStoreReviewController.swift
//  natto
//
//  Created by Tomoaki Inoue on 2019/04/19.
//  Copyright © 2019 佐川　晴海. All rights reserved.
//

import Foundation
import StoreKit

extension SKStoreReviewController {
    func popUpReviewRequest(isPopUp: Bool) {
        if isPopUp {
            SKStoreReviewController.requestReview()
        }
    }
}
