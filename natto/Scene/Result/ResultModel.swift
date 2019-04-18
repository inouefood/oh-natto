//
//  ResultModel.swift
//  natto
//
//  Created by 佐川晴海 on 2019/03/17.
//  Copyright © 2019 佐川　晴海. All rights reserved.
//

import Foundation
import AVFoundation
import Social

protocol ResultModelInput {
    func loadAudio(resourceName:String, resourceType: String)
    func playAudio()
    func isPopUpReviewDialog() -> Bool
}
class ResultModel: ResultModelInput{
    private var audio: AVAudioPlayer?
    
    func loadAudio(resourceName: String, resourceType: String) {
        let path = Bundle.main.path(forResource: resourceName, ofType: resourceType)
        let url = URL(fileURLWithPath: path!)
        do { try  audio = AVAudioPlayer(contentsOf: url) }
        catch{ fatalError() }
        audio?.numberOfLoops = -1
        audio?.prepareToPlay()
    }
    
    func playAudio() {
        audio?.play()
    }
    
    func isPopUpReviewDialog() -> Bool {
        let key = "openResultCount"
        UserDefaults.standard.set(UserDefaults.standard.integer(forKey: key) + 1, forKey: key)
        UserDefaults.standard.synchronize()
        let count = UserDefaults.standard.integer(forKey: key)
        if count % 5 == 0 {
            return true
        }
        return false
    }
}
