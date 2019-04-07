//
//  PullNattoModel.swift
//  natto
//
//  Created by 佐川晴海 on 2019/03/17.
//  Copyright © 2019 佐川　晴海. All rights reserved.
//

import Foundation
import AVFoundation
import UIKit

protocol PullNattoModelInput {
    func loadBgmAudio(resourceName: String, resourceType: String)
    func loadEffectAudio(resourceName: String, resourceType: String)
    func playBgm()
    func playEffect()
    func ohashiToNattoDistance(ohashiPos: CGPoint, ohashiSize: CGSize, nattoPos: CGPoint) -> Float
    func updateNattoPosition(ohashiX: Float, ohashiY: Float, ohashiWidth: Float, ohashiHeight: Float, nattoX: Float, nattoY: Float, sticky: Float) -> (x: Float, y: Float, distance: Float)
}

class PullNattoModel: PullNattoModelInput {
    private var bgm: AVAudioPlayer!
    private var effect: AVAudioPlayer!
    
    func updateNattoPosition(ohashiX: Float, ohashiY: Float, ohashiWidth: Float, ohashiHeight: Float, nattoX: Float, nattoY: Float, sticky: Float) -> (x: Float, y: Float, distance: Float) {
        
        let sentanX:Float = ohashiX + ohashiWidth / 2.0
        let sentanY:Float = ohashiY - ohashiHeight / 2.0
        let dvx:Float = sentanX - nattoX
        let dvy:Float = sentanY - nattoY
        let dist = sqrtf(dvx * dvx + dvy * dvy)
        return (x: dvx * sticky, y: dvy * sticky, distance: dist)
        
    }
    
    func ohashiToNattoDistance(ohashiPos: CGPoint, ohashiSize: CGSize, nattoPos: CGPoint) -> Float {
        let sentanx:Float = Float(ohashiPos.x + ohashiSize.width / 2.0)
        let sentany:Float = Float(ohashiPos.y - ohashiSize.height / 2.0)
        let dvx:Float = sentanx - Float(ohashiPos.x)
        let dvy:Float = sentany - Float(ohashiPos.y)
        return sqrtf(dvx * dvx + dvy * dvy)
        
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
        effect.play()
    }
}
