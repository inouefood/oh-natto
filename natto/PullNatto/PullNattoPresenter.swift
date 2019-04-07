//
//  PullNattoPresenter.swift
//  natto
//
//  Created by 佐川晴海 on 2019/03/17.
//  Copyright © 2019 佐川　晴海. All rights reserved.
//

import Foundation
import SpriteKit

protocol PullNattoPresenter {
    init(output: PullNattoPresenterOutput, model: PullNattoModelInput)
    func loadBgmAudio(resourceName: String, resourceType: String)
    func loadEffectAudio(resourceName: String, resourceType: String)
    func playBgm()
    func playEffect()
    func updateNattoPosition(ohashiX: Float, ohashiY: Float, ohashiWidth: Float, ohashiHeight: Float, nattoX: Float, nattoY: Float, sticky: Float)
}

protocol PullNattoPresenterOutput {
    func showUpdateNatto(x: Float, y: Float)
}

class PullNattoPresenterImpl: PullNattoPresenter {
    private var model: PullNattoModelInput
    private var output: PullNattoPresenterOutput
    
    required init(output: PullNattoPresenterOutput, model: PullNattoModelInput) {
        self.output = output
        self.model = model
    }

    func updateNattoPosition(ohashiX: Float, ohashiY: Float, ohashiWidth: Float, ohashiHeight: Float, nattoX: Float, nattoY: Float, sticky: Float) {
        let distAndPos = model.updateNattoPosition(ohashiX: ohashiX, ohashiY: ohashiY, ohashiWidth: ohashiWidth, ohashiHeight: ohashiHeight, nattoX: nattoX, nattoY: nattoY, sticky: sticky)
        
        if distAndPos.distance < 100 {
            output.showUpdateNatto(x: distAndPos.x, y: distAndPos.y)
        }
    }
    
    func loadBgmAudio(resourceName: String, resourceType: String) {
        model.loadBgmAudio(resourceName: resourceName, resourceType: resourceType)
    }
    
    func loadEffectAudio(resourceName: String, resourceType: String) {
        model.loadEffectAudio(resourceName: resourceName, resourceType: resourceType)
    }
    
    func playBgm() {
        model.playBgm()
    }
    
    func playEffect() {
        model.playEffect()
    }
}
