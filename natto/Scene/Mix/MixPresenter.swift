//
//  GamePresenter.swift
//  natto
//
//  Created by Tomoaki Inoue on 2019/03/19.
//  Copyright © 2019 佐川　晴海. All rights reserved.
//

import Foundation
import SpriteKit

protocol MixPresenter: class {
    init(output: MixPresenterOutput, model: MixModelInput)
    func updateOhashiPosition(touchPosX: Float, touchPosY: Float, ohashiRadius: Float)
    func contactOhashiToNatto(contact: SKPhysicsContact) -> CGPoint?
    func loadEffectAudio1(resourceName: String, resourceType: String)
    func loadEffectAudio2(resourceName: String, resourceType: String)
    func playEffect1()
    func playEffect2()
    func stopEffect1()
    func stopEffect2()
}

protocol MixPresenterOutput: class {
    func showUpdateOhashi(objPos: ObjectPosition)
}

class MixPresenterImpl: MixPresenter {
    private var model: MixModelInput
    private weak var output: MixPresenterOutput?
    
    required init(output: MixPresenterOutput, model: MixModelInput) {
        self.output = output
        self.model = model
    }
    
    func updateOhashiPosition(touchPosX: Float, touchPosY: Float, ohashiRadius: Float) {
        let objPos = model.updateOhashiPosition(touchPosX: touchPosX, touchPosY: touchPosY, ohashiRadius: ohashiRadius)
        output?.showUpdateOhashi(objPos: objPos)
    }
    
    func contactOhashiToNatto(contact: SKPhysicsContact) -> CGPoint? {
        return model.contactOhashiToNatto(contact: contact)
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
