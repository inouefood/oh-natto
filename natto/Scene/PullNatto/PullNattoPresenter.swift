//
//  PullNattoPresenter.swift
//  natto
//
//  Created by 佐川晴海 on 2019/03/17.
//  Copyright © 2019 佐川　晴海. All rights reserved.
//

import Foundation

protocol PullNattoPresenter {
    init(output: PullNattoPresenterOutput, model: PullNattoModelInput)
    func loadBgmAudio(resourceName: String, resourceType: String)
    func loadEffectAudio(resourceName: String, resourceType: String)
    func playBgm()
    func playEffect()
    func updateNattoPosition(ohashiPos: ObjectPosition, ohashiSize: ObjectPosition, nattoPos: ObjectPosition, sticky: Float, dist: Float, index: Int)
    func eatCheck(height: Float, nattoY: Float, index: Int)
}

protocol PullNattoPresenterOutput {
    func showUpdateNatto(objPos: ObjectPosition)
    func showEatNatto(index: Int)
}

class PullNattoPresenterImpl: PullNattoPresenter {
    
    private var model: PullNattoModelInput
    private var output: PullNattoPresenterOutput
    
    required init(output: PullNattoPresenterOutput, model: PullNattoModelInput) {
        self.output = output
        self.model = model
    }

    func updateNattoPosition(ohashiPos: ObjectPosition, ohashiSize: ObjectPosition, nattoPos: ObjectPosition, sticky: Float, dist: Float, index: Int) {
  
        let distAndObjPos = model.updateNattoPosition(ohashiPos: ohashiPos, ohashiSize: ohashiSize, nattoPos: nattoPos, sticky: sticky)
        
        if distAndObjPos.distance < dist {
            output.showUpdateNatto(objPos: distAndObjPos.objPos)
        }
    }
    
    func  eatCheck(height: Float, nattoY: Float, index: Int) {
        if model.isEat(height: height, nattoY: nattoY) {
            output.showEatNatto(index: index)
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
