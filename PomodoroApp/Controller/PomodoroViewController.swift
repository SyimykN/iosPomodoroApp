//
//  PomodoroViewController.swift
//  PomodoroApp
//
//  Created by Syimyk on 7/5/20.
//  Copyright © 2020 Syimyk. All rights reserved.
//

import UIKit
import AVFoundation

class PomodoroViewController: UIViewController {
    
    var settedPomodoro : Int?
    var settedShortBreak : Int?
    var settedLongBreak : Int?
    
    var audioPlayer = AVAudioPlayer()
    var timer = Timer()
    
    
    @IBOutlet weak var ShortBTN: UIButton!
    @IBOutlet weak var LongBTN: UIButton!
    @IBOutlet weak var PomodoroBTn: UIButton!
    
    
    @IBOutlet weak var quoteLabel: UILabel!
    
    
    
    
    
    var time = 0
    var saveTime = 0
    
    
    @IBOutlet weak var clock: UILabel!
    
    @IBOutlet weak var startBTN: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        do{
            let audioPath = Bundle.main.path(forResource: "alarm_sound", ofType: ".mp3")
            try audioPlayer = AVAudioPlayer(contentsOf: URL(fileURLWithPath: audioPath!))
        }catch{
            print("\(error)")
        }
        
        clock.text = "\(settedPomodoro!) : 00"
        if let savePomodoro = settedPomodoro{
            time = savePomodoro * 60
            saveTime = savePomodoro * 60
        }
    }
    
    
    @IBAction func startPressed(_ sender: Any) {
        if startBTN.currentTitle == "Start"{
            startTimer()
            startBTN.setTitle("Stop", for: .normal)
        }else{
            timer.invalidate()
            startBTN.setTitle("Start", for: .normal)
        }
    }
    
    
    
    func startTimer(){
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
    }
    
    @objc func updateTimer(){
        if time > 0{
            time -= 1
            clock.text = formatTime()
        }else{
            timer.invalidate()
            audioPlayer.play()
            clock.text = formatTime()
            time = saveTime
            startBTN.setTitle("Start", for: .normal)
        }
    }
    
    func formatTime() -> String{
        if time > 0{
            let minutes = time / 60 % 60
            let seconds = time % 60
            return String(format: "%02i:%02i", minutes, seconds)
        }else{
            let minutes = saveTime / 60 % 60
            let seconds = saveTime % 60
            return String(format: "%02i:%02i", minutes, seconds)
        }
        
    }
    
    
    //MARK: - ShortButtonPressed
    
    @IBAction func shortBreakPressed(_ sender: UIButton) {
        
        if startBTN.currentTitle == "Stop"{
                 timer.invalidate()
                 startBTN.setTitle("Start", for: .normal)
             }
        
        
        
        clock.text = "\(settedShortBreak!) : 00"
        if let saveShort = settedShortBreak{
            time = saveShort * 60
            saveTime = saveShort * 60
        }
        view.backgroundColor = UIColor.cyan
        
        
        quoteLabel.text = "Time for a break"
        
        ShortBTN.backgroundColor = .black
        PomodoroBTn.backgroundColor = UIColor(red: 321, green: 322, blue: 123, alpha: 0.0)
        LongBTN.backgroundColor = UIColor(red: 321, green: 322, blue: 123, alpha: 0.0)
    }
    
    
    
    //MARK: - LongButtonPressed
    
    @IBAction func LongBreakBtnPressed(_ sender: UIButton) {
        
        if startBTN.currentTitle == "Stop"{
                        timer.invalidate()
                        startBTN.setTitle("Start", for: .normal)
                    }
        
        clock.text = "\(settedLongBreak!) : 00"
        if let saveLong = settedLongBreak{
            time = saveLong * 60
            saveTime = saveLong * 60
        }
        view.backgroundColor = UIColor.green
        
        
        quoteLabel.text = "Time for a break"
        LongBTN.backgroundColor = .black
        PomodoroBTn.backgroundColor = UIColor(red: 251, green: 232, blue: 211, alpha: 0.0)
        ShortBTN.backgroundColor = UIColor(red: 251, green: 232, blue: 211, alpha: 0.0)
    }
    
    //MARK: - pomodoroBTNPressed
    
    @IBAction func PomodoroBtnPressed(_ sender: Any) {
        
        if startBTN.currentTitle == "Stop"{
                        timer.invalidate()
                        startBTN.setTitle("Start", for: .normal)
                    }
        
        
        clock.text = "\(settedPomodoro!) : 00"
        if let savePomodoro = settedPomodoro{
            time = savePomodoro * 60
            saveTime = savePomodoro * 60
        }
        view.backgroundColor = UIColor.systemBlue
        
        
        quoteLabel.text = "Time To Study"
        PomodoroBTn.backgroundColor = .black
        LongBTN.backgroundColor = UIColor(red: 251, green: 232, blue: 211, alpha: 0.0)
        ShortBTN.backgroundColor = UIColor(red: 251, green: 232, blue: 211, alpha: 0.0)
    }
    
    
    
    //MARK: - Helping Method to Reset Timer When Its Done
    
}
