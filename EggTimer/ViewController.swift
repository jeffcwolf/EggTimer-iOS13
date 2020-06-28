//
//  ViewController.swift
//  EggTimer
//
//  Created by Angela Yu on 08/07/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//
//  Customised by Jeffrey Wolf in 2020.

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    var player: AVAudioPlayer! // Add audio player to play alarm sound when egg timer is complete.
    
    @IBOutlet weak var progressBar: UIProgressView!
    @IBOutlet weak var titleLabel: UILabel!
    
    
    let eggTimes = ["Soft": 300, "Perfekt": 360, "Hard": 720] // use a dictionary to collect Egg Times
    
    var totalTime = 0 // Keep track of total time needed to cook eggs
    var secondsPassed = 0 // Keep track of time elapsed
    
    var timer = Timer()
    
    @IBAction func hardnessSelected(_ sender: UIButton) { // Button action when hardness button is pressed
        
        timer.invalidate() // The timer needs to be reset between button presses
        let hardness = sender.currentTitle! // Soft, Perfekt, Hard
        totalTime = eggTimes[hardness]!
        
        progressBar.progress = 0.0 // Reset progress bar to 0
        secondsPassed = 0 // Reset time elapsed to 0
        titleLabel.text = hardness
            
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true) //Start a repeating timer on a 1 second interval. Connect it to the updateTimer function below.
        
    }
    
    @objc func updateTimer() { // Update timer logic
        if secondsPassed < totalTime {
            
            secondsPassed += 1
            let percentageProgress = Float(secondsPassed) / Float(totalTime) //We need the floats here because the progress bar uses Floats
            progressBar.progress = percentageProgress
            
        } else {
            timer.invalidate()
            playSound(soundName: "alarm_sound")
            titleLabel.text = "DONE!"
        }
    }
    
    func playSound(soundName: String) { //This function supports audio player
        let url = Bundle.main.url(forResource: soundName, withExtension: "mp3")
        player = try! AVAudioPlayer(contentsOf: url!)
        player.play()
        
    }
    
}
