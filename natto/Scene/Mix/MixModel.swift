//
//  GameModel.swift
//  natto
//
//  Created by Tomoaki Inoue on 2019/03/19.
//  Copyright © 2019 佐川　晴海. All rights reserved.
//

import Foundation
import AVFoundation
import SpriteKit

protocol MixModelInput {
    func updateOhashiPosition(touchPosX: Float, touchPosY: Float, ohashiRadius: Float) -> ObjectPosition
    func contactOhashiToNatto(contact: SKPhysicsContact) -> CGPoint?
    func loadEffectAudio1(resourceName: String, resourceType: String)
    func loadEffectAudio2(resourceName: String, resourceType: String)
    func playEffect1()
    func playEffect2()
    func stopEffect1()
    func stopEffect2()
}

class MixModel: MixModelInput {
    private var effect1: AVAudioPlayer!
    private var effect2: AVAudioPlayer!
    
    func updateOhashiPosition(touchPosX: Float, touchPosY: Float, ohashiRadius: Float) -> ObjectPosition {
        return ObjectPosition(x: touchPosX, y: touchPosY - ohashiRadius)
    }
    
    func contactOhashiToNatto(contact: SKPhysicsContact) -> CGPoint? {
        var firstBody, secondBody: SKPhysicsBody
        if contact.bodyA.categoryBitMask < contact.bodyB.categoryBitMask {
            firstBody = contact.bodyA
            secondBody = contact.bodyB
        } else {
            firstBody = contact.bodyB
            secondBody = contact.bodyA
        }
        if firstBody.categoryBitMask & Constant.CollisionBody.ohashi != 0
           && secondBody.categoryBitMask & Constant.CollisionBody.natto != 0 {
            guard (secondBody.node?.position != CGPoint(x: 0.0, y: 0.0)) else { return nil }
            return secondBody.node?.position
        }
        return nil
    }

    func loadEffectAudio1(resourceName: String, resourceType: String) {
        let path = Bundle.main.path(forResource: resourceName, ofType: resourceType)
        let url = URL(fileURLWithPath: path!)
        do { try  effect1 = AVAudioPlayer(contentsOf: url) }
        catch{ fatalError() }
        effect1?.numberOfLoops = -1
        effect1?.prepareToPlay()
    }
    
    func loadEffectAudio2(resourceName: String, resourceType: String) {
        let path = Bundle.main.path(forResource: resourceName, ofType: resourceType)
        let url = URL(fileURLWithPath: path!)
        do { try  effect2 = AVAudioPlayer(contentsOf: url) }
        catch{ fatalError() }
        effect2?.numberOfLoops = -1
        effect2?.prepareToPlay()
    }
    
    func playEffect1() {
        effect1.play()
    }
    
    func playEffect2() {
        effect2.play()
    }
    
    func stopEffect1() {
        effect1.stop()
    }
    
    func stopEffect2() {
        effect2.stop()
    }
}
