//
//  ViewController.swift
//  QuickPlayer
//
//  Created by techmaster on 1/19/17.
//  Copyright © 2017 techmaster. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    @IBOutlet weak var buttonPlay: UIButton!
    @IBOutlet weak var sliderVolume: UISlider!
    
    var audioPlayer = AVAudioPlayer()
    var isPlay: Bool = false

    override func viewDidLoad() {
        super.viewDidLoad()
        
        audioPlayer = try! AVAudioPlayer(contentsOf: NSURL(fileURLWithPath: Bundle.main.path(forResource: "music", ofType: ".mp3")!) as URL)
        audioPlayer.prepareToPlay()
        addThumbImgForSlider()
        
    }
    
    func addThumbImgForSlider() {
        sliderVolume.setThumbImage(UIImage(named: "thumb.png"), for: UIControlState.normal)
        sliderVolume.setThumbImage(UIImage(named: "thumbHightLight.png"), for: UIControlState.highlighted)
    }
    
    @IBAction func buttonPlayAction(_ sender: UIButton) {
        if isPlay {
            buttonPlay.setBackgroundImage(UIImage(named: "play.png"), for: UIControlState.normal)
            isPlay = false
            audioPlayer.pause()
        } else {
            buttonPlay.setBackgroundImage(UIImage(named: "pause.png"), for: UIControlState.normal)
            isPlay = true
            audioPlayer.play()
        }
    }

    @IBAction func sliderChangeVolumeAction(_ sender: UISlider) {
        audioPlayer.volume = sender.value
    }
}

