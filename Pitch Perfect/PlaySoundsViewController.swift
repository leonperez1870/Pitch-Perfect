//
//  PlaySoundsViewController.swift
//  Pitch Perfect
//
//  Created by Leoncio Perez on 1/24/16.
//  Copyright © 2016 Leoncio Perez. All rights reserved.
//

import UIKit
import AVFoundation

class PlaySoundsViewController: UIViewController {

    @IBOutlet weak var playSlow: UIButton!
    @IBOutlet weak var playFast: UIButton!
    @IBOutlet weak var playChip: UIButton!
    @IBOutlet weak var stopAudio: UIButton!
    @IBOutlet weak var playDarth: UIButton!
    
    
    var audioPlayer: AVAudioPlayer!
    var receivedAudio: RecordedAudio!
    var audioEngine: AVAudioEngine!
    var audioFile: AVAudioFile!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        audioEngine = AVAudioEngine()
        audioFile = try! AVAudioFile(forReading: receivedAudio.filePathUrl)
        audioPlayer = try! AVAudioPlayer(contentsOfURL: receivedAudio.filePathUrl)
        audioPlayer.enableRate = true
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func playSlow(sender: UIButton) {
        stopAllAudioActions()
        playAudioWithRate(0.5)
    }
    
    @IBAction func playFast(sender: UIButton) {
        stopAllAudioActions()
        playAudioWithRate(2.0)
    }
    
    @IBAction func playChip(sender: UIButton) {
        stopAllAudioActions()
        playAudioWithVariablePitch(1000)
    }
    
    @IBAction func stopAudio(sender: UIButton) {
        stopAllAudioActions()
    }
    
    @IBAction func playDarth(sender: UIButton) {
        stopAllAudioActions()
        playAudioWithVariablePitch(-500)
    }
    
    func playAudioWithRate(rate: Float) {
        audioPlayer.currentTime = 0.0
        audioPlayer.rate = rate // range 0.5 for half the normal speed to 2.0 double the normal speed, 1.0 is normal speed
        audioPlayer.prepareToPlay() // pre loads the buffer
        audioPlayer.play() // plays sound asynchronously
    }
    
    func playAudioWithVariablePitch(pitch: Float){
        audioPlayer.stop()
        audioEngine.stop()
        audioEngine.reset()
        
        let audioPlayerNode = AVAudioPlayerNode()
        audioEngine.attachNode(audioPlayerNode)
        
        let changePitchEffect = AVAudioUnitTimePitch()
        changePitchEffect.pitch = pitch
        audioEngine.attachNode(changePitchEffect)
        
        audioEngine.connect(audioPlayerNode, to: changePitchEffect, format: nil)
        audioEngine.connect(changePitchEffect, to: audioEngine.outputNode, format: nil)
        
        audioPlayerNode.scheduleFile(audioFile, atTime: nil, completionHandler: nil)
        try! audioEngine.start()
        
        audioPlayerNode.play()
    }
    
    func stopAllAudioActions() {
        audioPlayer.stop()
        audioEngine.stop()
        audioEngine.reset()
    }

}
