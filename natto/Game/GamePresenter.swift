//
//  GamePresenter.swift
//  natto
//
//  Created by Tomoaki Inoue on 2019/03/19.
//  Copyright © 2019 佐川　晴海. All rights reserved.
//

import Foundation

protocol GamePresenter {
    func loadEffectAudio1(resourceName: String, resourceType: String)
    func loadEffectAudio2(resourceName: String, resourceType: String)
    func playEffect1()
    func playEffect2()
    func stopEffect1()
    func stopEffect2()
}

class GamePresenterImpl: GamePresenter {
    private var model: GameModelInput
    init() {
        model = GameModel()
    }
    
    func loadEffectAudio1(resourceName: String, resourceType: String) {
        model.loadEffectAudio1(resourceName: resourceName, resourceType: resourceType)
    }
    
    func loadEffectAudio2(resourceName: String, resourceType: String) {
        model.loadEffectAudio2(resourceName: resourceName, resourceType: resourceType)
    }
    
    func playEffect1() {
        model.playEffect1()
    }
    
    func playEffect2() {
        model.playEffect2()
    }
    
    func stopEffect1() {
        model.stopEffect1()
    }
    
    func stopEffect2() {
        model.stopEffect2()
    }
}
