//
//  PullNattoPresenter.swift
//  natto
//
//  Created by 佐川晴海 on 2019/03/17.
//  Copyright © 2019 佐川　晴海. All rights reserved.
//

import Foundation
import AVFoundation

protocol PullNattoPresenter:class {
    init(output: PullNattoPresenterOutput, model: PullNattoModelInput)
    func loadBgmAudio(resourceName: String, resourceType: String)
    func loadEffectAudio(resourceName: String, resourceType: String)
    func playBgm()
    func playEffect()
    func updateNattoPosition(ohashiPos: ObjectPosition, ohashiSize: ObjectSize, nattoPos: ObjectPosition, sticky: Float, dist: Float, index: Int)
    func updateToppingPosition(ohashiPos: ObjectPosition, ohashiSize: ObjectSize, toppingPos: ObjectPosition, sticky: Float, dist: Float, index: Int)
    func nattoEatCheck(height: Float, nattoY: Float, index: Int)
    func toppingEatCheck(height: Float, toppingY: Float, index: Int)
}

protocol PullNattoPresenterOutput:class {
    func showUpdateNatto(objPos: ObjectPosition, index: Int)
    func showEatNatto(index: Int)
    func showUpdateTopping(objPos: ObjectPosition, index: Int)
    func showEatTopping(index: Int)
}

class PullNattoPresenterImpl: PullNattoPresenter {
    
    private var model: PullNattoModelInput
    private weak var output: PullNattoPresenterOutput?
    
    required init(output: PullNattoPresenterOutput, model: PullNattoModelInput) {
        self.output = output
        self.model = model
    }

    func updateNattoPosition(ohashiPos: ObjectPosition, ohashiSize: ObjectSize, nattoPos: ObjectPosition, sticky: Float, dist: Float, index: Int) {
  
        let distAndObjPos = model.updateNattoPosition(ohashiPos: ohashiPos, ohashiSize: ohashiSize, nattoPos: nattoPos, sticky: sticky)
        
        if distAndObjPos.distance < dist {
            output?.showUpdateNatto(objPos: distAndObjPos.objPos, index: index)
        }
    }
    
    func updateToppingPosition(ohashiPos: ObjectPosition, ohashiSize: ObjectSize, toppingPos: ObjectPosition, sticky: Float, dist: Float, index: Int) {
        
        let distAndObjPos = model.updateToppingPosition(ohashiPos: ohashiPos,
                                                        ohashiSize: ohashiSize,
                                                        toppingPos: toppingPos,
                                                        sticky: sticky)
        
        if distAndObjPos.distance < dist {
            output?.showUpdateTopping(objPos: distAndObjPos.objPos, index: index)
        }
    }
    
    func  nattoEatCheck(height: Float, nattoY: Float, index: Int) {
        if model.isEat(height: height, y: nattoY) {
            output?.showEatNatto(index: index)
        }
    }
    
    func toppingEatCheck(height: Float, toppingY: Float, index: Int) {
        if model.isEat(height: height, y: toppingY) {
            output?.showEatTopping(index: index)
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
