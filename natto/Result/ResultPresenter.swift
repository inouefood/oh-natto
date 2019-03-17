//
//  ResultPresenter.swift
//  natto
//
//  Created by 佐川晴海 on 2019/03/17.
//  Copyright © 2019 佐川　晴海. All rights reserved.
//

import Foundation

protocol ResultPresenter {
    func loadAudio(resourceName: String, resourceType: String)
    func playAudio()
}
class ResultPresenterImpl: ResultPresenter {
    
    private var model: ResultModelInput
    
    init() {
        model = ResultModel()
    }
    func loadAudio(resourceName: String, resourceType: String) {
        model.loadAudio(resourceName: resourceName, resourceType: resourceType)
    }
    
    func playAudio() {
        model.playAudio()
    }
}
