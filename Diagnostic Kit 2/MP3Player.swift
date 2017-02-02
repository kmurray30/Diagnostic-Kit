//
//  MP3Player.swift
//  MP3Player
//
//  Created by James Tyner on 7/17/15.
//  Copyright (c) 2015 James Tyner. All rights reserved.
//

import UIKit
import AVFoundation

class MP3Player: NSObject, AVAudioPlayerDelegate {
    var player:AVAudioPlayer?
    var currentTrackIndex = 0
    
    override init(){
        super.init()
        queueTrack();
    }
    
    func queueTrack(){
        if (player != nil) {
            player = nil
        }
        let audioFilePath = Bundle.main.path(forResource: "10 kHz Test Tone Pure Sine Wave 5min", ofType: "mp3")
        let url = NSURL.fileURL(withPath: audioFilePath!)
        do {
            player = try AVAudioPlayer(contentsOf: url)
            player?.delegate = self
            player?.prepareToPlay()
        } catch {
            //SHOW ALERT OR SOMETHING
        }
    }
    
    func play() {
        if player?.isPlaying == false {
            player?.play()
        }
    }
    func stop() {
        if player?.isPlaying == true {
            player?.stop()
            player?.currentTime = 0
        }
    }
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool){
        if flag == true {
            // Change play button to pause
        }
    }
}
