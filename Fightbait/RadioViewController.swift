//
//  RadioViewController.swift
//  Fightbait
//
//  Created by Tony Bowe on 12/31/15.
//  Copyright © 2015 Fightbait. All rights reserved.
//

import UIKit
import AVFoundation
import MediaPlayer
import Spring

class RadioViewController: UIViewController {
    
    @IBOutlet weak var albumArtView: SpringImageView!
    
    @IBOutlet weak var radioPlayButton: UIButton!
    
    @IBOutlet weak var volumeParentView: UIView!
    
    @IBOutlet weak var slider: UISlider!
    
    var mpVolumeSlider = UISlider()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        setupVolumeSlider()
        albumArtView.clipsToBounds = true
        
        // Do any additional setup after loading the view, typically from a nib.
        if NSClassFromString("MPNowPlayingInfoCenter") != nil {
            let image:UIImage = UIImage(named: "album-art")!
            let albumArt = MPMediaItemArtwork(image: image)
            let songInfo = [
                MPMediaItemPropertyTitle: "Radio Brasov",
                MPMediaItemPropertyArtist: "87,8fm",
                MPMediaItemPropertyArtwork: albumArt
            ]
            MPNowPlayingInfoCenter.defaultCenter().nowPlayingInfo = songInfo
        }
        do {
            try AVAudioSession.sharedInstance().setCategory(AVAudioSessionCategoryPlayback)
            UIApplication.sharedApplication().beginReceivingRemoteControlEvents()
            print("Receiving remote control events\n")
        } catch {
            print("Audio Session error.\n")
        }
    }
    
    @IBAction func radioPlayButtonDidTouch(sender: AnyObject) {
        toggleRadioPlayback()
    }
    
    func toggleRadioPlayback() {
        if RadioPlayer.sharedInstance.isPlaying {
            pauseRadio()
        }
        else {
            playRadio()
        }
    }
    
    func setupVolumeSlider() {
        // Note: This slider implementation uses a MPVolumeView
        // The volume slider only works in devices, not the simulator.
        volumeParentView.backgroundColor = UIColor.clearColor()
        let volumeView = MPVolumeView(frame: volumeParentView.bounds)
        for view in volumeView.subviews {
            let uiview: UIView = view as UIView
            if (uiview.description as NSString).rangeOfString("MPVolumeSlider").location != NSNotFound {
                mpVolumeSlider = (uiview as! UISlider)
            }
        }
        
    }
    
    func pauseRadio() {
        RadioPlayer.sharedInstance.pause()
        radioPlayButton.setTitle("Play", forState: UIControlState.Normal)
    }
    
    func playRadio() {
        RadioPlayer.sharedInstance.play()
        radioPlayButton.setTitle("Pause", forState: UIControlState.Normal)
    }
    
    
    @IBAction func volumeChanged(sender: AnyObject) {
        mpVolumeSlider.value = sender.value
    }
    
}
