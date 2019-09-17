//
//  PullNattoModel.swift
//  natto
//
//  Created by 佐川晴海 on 2019/03/17.
//  Copyright © 2019 佐川　晴海. All rights reserved.
//

import Foundation
import AVFoundation

protocol PullNattoModelInput {
    func loadBgmAudio(resourceName: String, resourceType: String)
    func loadEffectAudio(resourceName: String, resourceType: String)
    func playBgm()
    func playEffect()
    func updateNattoPosition(ohashiPos: ObjectPosition, ohashiSize: ObjectSize, nattoPos: ObjectPosition, sticky: Float) -> (objPos: ObjectPosition, distance: Float)
    func isEat(height: Float, nattoY: Float) -> Bool
}

class PullNattoModel: PullNattoModelInput {
    private var bgm: AVAudioPlayer!
    private var effect: AVAudioPlayer!
    private var isPlaying: Bool = false
    
    
    
    
    func updateNattoPosition(ohashiPos: ObjectPosition, ohashiSize: ObjectSize, nattoPos: ObjectPosition, sticky: Float) -> (objPos: ObjectPosition, distance: Float)  {
        
        let sentanX:Float = ohashiPos.x + ohashiSize.width / 2.0
        let sentanY:Float = ohashiPos.y - ohashiSize.height / 2.0
        let dvx:Float = sentanX - nattoPos.x
        let dvy:Float = sentanY - nattoPos.y
        let dist = sqrtf(dvx * dvx + dvy * dvy)
        return (objPos: ObjectPosition(x: dvx * sticky, y: dvy * sticky), distance: dist)
    }
    
    func isEat(height: Float, nattoY: Float) -> Bool {
        return height * 0.80 < nattoY ? true : false
    }
    
    func loadBgmAudio(resourceName: String, resourceType: String) {
        let path = Bundle.main.path(forResource: resourceName, ofType: resourceType)
        let url = URL(fileURLWithPath: path!)
        do { try  bgm = AVAudioPlayer(contentsOf: url) }
        catch{ fatalError() }
        bgm.numberOfLoops = -1
        bgm.prepareToPlay()
        
    }
    
    func loadEffectAudio(resourceName: String, resourceType: String) {
        let path = Bundle.main.path(forResource: resourceName, ofType: resourceType)
        let url = URL(fileURLWithPath: path!)
        do { try  effect = AVAudioPlayer(contentsOf: url) }
        catch{ fatalError() }
        effect?.numberOfLoops = -1
        effect?.prepareToPlay()
    }
    
    func playBgm() {
        bgm.play()
    }
    
    func playEffect() {
        if !isPlaying {
            effect.play()
            isPlaying = true
        }
    }
}
