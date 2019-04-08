//
//  GameModel.swift
//  natto
//
//  Created by Tomoaki Inoue on 2019/03/19.
//  Copyright © 2019 佐川　晴海. All rights reserved.
//

import Foundation
import AVFoundation

protocol MixModelInput {
    func updateOhashiPosition(touchPosX: Float, touchPosY: Float, ohashiRadius: Float) -> (x: Float, y: Float)
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
    
    func updateOhashiPosition(touchPosX: Float, touchPosY: Float, ohashiRadius: Float) -> (x: Float, y: Float) {
        return (x: touchPosX, y: touchPosY - ohashiRadius)
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
