//
//  ViewController.swift
//  QuickPlayer
//
//  Created by techmaster on 1/19/17.
//  Copyright © 2017 techmaster. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController, AVAudioPlayerDelegate {
    
    @IBOutlet weak var buttonPlay: UIButton!
    @IBOutlet weak var sliderVolume: UISlider!
    @IBOutlet weak var labelCurrentTime: UILabel!
    @IBOutlet weak var labelTimeTotal: UILabel!
    @IBOutlet weak var sliderCurrentTime: UISlider!
    @IBOutlet weak var switchRepeat: UISwitch!
    
    var audioPlayer = AVAudioPlayer()
    var isPlay: Bool = false
    var timer = Timer()

    var minutes: Int!
    var seconds: Int!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        audioPlayer = try! AVAudioPlayer(contentsOf: NSURL(fileURLWithPath: Bundle.main.path(forResource: "music", ofType: ".mp3")!) as URL)
        audioPlayer.delegate = self
        audioPlayer.prepareToPlay()
        addThumbImgForSliderCurrentTime()
        addThumbImgForSlider()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let timeTotal = Int(audioPlayer.duration)
        let minutes = timeTotal/60
        let seconds = timeTotal - minutes * 60
        labelTimeTotal.text = String(format: "%02d:%02d", minutes, seconds)
        resetTime()
        switchRepeat.isOn = false
    }
    
    func updateCurrentTime() {
        getCurrentMinutesAndSeconds()
        labelCurrentTime.text = String(format: "%02d:%02d", minutes, seconds)
        
        sliderCurrentTime.value = Float(audioPlayer.currentTime / audioPlayer.duration)
        print("OK")
    }
    
    func getCurrentMinutesAndSeconds() {
        let currentTime = Int(audioPlayer.currentTime)
        minutes = currentTime/60
        seconds = currentTime - minutes * 60
    }
    
    func addThumbImgForSliderCurrentTime() {
        sliderCurrentTime.setThumbImage(UIImage(named: "duration.png"), for: UIControlState.normal)
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
            timer.invalidate()
        } else {
            buttonPlay.setBackgroundImage(UIImage(named: "pause.png"), for: UIControlState.normal)
            isPlay = true
            audioPlayer.play()
            timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateCurrentTime), userInfo: nil, repeats: true)
        }
    }

    @IBAction func sliderChangeVolumeAction(_ sender: UISlider) {
        audioPlayer.volume = sender.value
    }
    
    @IBAction func sliderChangeDurationAction(_ sender: UISlider) {
        getCurrentMinutesAndSeconds()
        labelCurrentTime.text = String(format: "%02d:%02d", minutes, seconds)
        audioPlayer.currentTime = TimeInterval(sender.value * Float(audioPlayer.duration))
    }
    
    @IBAction func switchOnOrOffAction(_ sender: UISwitch) {
        if sender.isOn {
            audioPlayer.numberOfLoops = -1
        } else {
            audioPlayer.numberOfLoops = 0
        }
    }
    
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        isPlay = false
        timer.invalidate()
        buttonPlay.setBackgroundImage(UIImage(named: "play.png"), for: UIControlState.normal)
        resetTime()
    }
    
    func resetTime() {
        labelCurrentTime.text = "00.00"
        sliderCurrentTime.value = 0.0
    }
    
}

