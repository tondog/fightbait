//
//  RadioPlayer.swift
//  Fightbait
//
//  Created by Tony Bowe on 12/31/15.
//  Copyright © 2015 Fightbait. All rights reserved.
//

import Foundation
import AVFoundation
import MediaPlayer

class RadioPlayer {
    static let sharedInstance = RadioPlayer()
    private var radioUrl = "http://radio.fightbait.com"
    private var radioPlayer = AVPlayer(URL: NSURL(string: "http://radio.fightbait.com/")!)
    var isPlaying = false
    
    func play() {
        radioPlayer.play()
        isPlaying = true
    }
    
    func pause() {
        radioPlayer.pause()
        isPlaying = false
    }
    
    func toggle() {
        if isPlaying == true {
            pause()
        } else {
            play()
        }
    }
    
    func currentlyPlaying() -> Bool {
        return isPlaying
    }
    
}