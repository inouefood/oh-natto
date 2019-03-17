//
//  Sount.swift
//  natto
//
//  Created by 佐川　晴海 on 2018/03/10.
//  Copyright © 2018年 佐川　晴海. All rights reserved.
//

import AVFoundation
import SpriteKit

class Sound: SKScene{
    
    
    func playBGM(){
        let BGMpath = Bundle.main.path(forResource: "mame", ofType:"mp3")!
        let BGMUrl = URL(fileURLWithPath: BGMpath)
        do {
            try BGM = AVAudioPlayer(contentsOf:BGMUrl)
            
            //音楽をバッファに読み込んでおく
            BGM!.prepareToPlay()
        } catch {
            print(error)
        }
        // auido を再生するプレイヤーを作成する
        var audioError:NSError?
        do {
            BGM = try AVAudioPlayer(contentsOf: BGMUrl)
        } catch let error as NSError {
            audioError = error
            BGM = nil
        }
        if let error = audioError {
            print("Error \(error.localizedDescription)")
        }
        BGM!.delegate = self
        BGM!.play()
    }
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        player.currentTime = 0
    }
}
