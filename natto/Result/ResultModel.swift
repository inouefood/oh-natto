//
//  ResultModel.swift
//  natto
//
//  Created by 佐川晴海 on 2019/03/17.
//  Copyright © 2019 佐川　晴海. All rights reserved.
//

import Foundation
import AVFoundation

protocol ResultModelInput {
    func loadAudio(resourceName:String, resourceType: String)
    func playAudio()
}
class ResultModel: ResultModelInput{
    private var audio: AVAudioPlayer?
    func loadAudio(resourceName: String, resourceType: String) {
        let path = Bundle.main.path(forResource: resourceName, ofType: resourceType)
        let url = URL(fileURLWithPath: path!)
        do { try  audio = AVAudioPlayer(contentsOf: url) }
        catch{ fatalError() }
        audio?.prepareToPlay()
    }
    
    func playAudio() {
        audio?.play()
    }
    

}
