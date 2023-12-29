//
//  TimerViewController.swift
//  ChessTimer
//
//  Created by мак on 27.12.2023.
//

import UIKit
import AVFoundation
import Foundation

class TimerViewController: UIViewController {
    
    var player: AVAudioPlayer!
    
    var gameOver:Bool = false
    
    
    @IBOutlet weak var blackTime: UILabel!
    @IBOutlet weak var whiteTime: UILabel!
    @IBOutlet weak var stopButton: UIButton!
    @IBOutlet weak var blackHorse: UIImageView!
    @IBOutlet weak var whiteHorse: UIImageView!
    
    var timerWhite:Timer = Timer()
    var timerBlack:Timer = Timer()
    var countWhite:Int!
    var countBlack:Int!
    var timerCountingWhite:Bool = false
    var timerCountingBlack:Bool = false
    var WhiteStartFirst: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        rotateAll()
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .portrait
    }
    
    //MARK: - Timer start
    
    @IBAction func playBlackTimer(_ sender: UIButton) {
        if !gameOver {
            if(WhiteStartFirst) {
                playSound(soundName: "lclick")
                if(timerCountingBlack) {
                    timerCountingBlack = false
                    timerBlack.invalidate()
                }
                
                if(!timerCountingWhite) {
                    timerCountingWhite = true
                    timerWhite = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(timerWhiteCounter), userInfo: nil, repeats: true)
                }
            }
        }
    }
    
    @IBAction func playWhiteTimer(_ sender: UIButton) {
        if !gameOver {
            WhiteStartFirst = true
            playSound(soundName: "rclick")
            if(timerCountingWhite) {
                timerCountingWhite = false
                timerWhite.invalidate()
            }
            
            if(!timerCountingBlack) {
                timerCountingBlack = true
                timerBlack = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(timerBlackCounter), userInfo: nil, repeats: true)
            }
        }
    }
    
    @IBAction func stopButtonPressed(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    func finish() {
        if (gameOver) {
            timerBlack.invalidate()
            timerWhite.invalidate()
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let resultController = storyboard.instantiateViewController(withIdentifier: "result") as! ResultViewController
            resultController.loadViewIfNeeded()
            if (timerCountingBlack) {
                resultController.winnerLabel.text = "White WON!"
            }
            if (timerCountingWhite) {
                resultController.winnerLabel.text = "Black WON!"
            }
            
            self.present(resultController, animated: true, completion: nil)
        }
    }
}

//MARK: - Timer methods

extension TimerViewController {
    
    @objc func timerWhiteCounter() -> Void
    {
        let resetCount = countWhite
        countWhite = countWhite - 1
        let time = secondsToHoursMinutesSeconds(seconds: countWhite)
        let timeString = makeTimeString(minutes: time.0, seconds: time.1)
        whiteTime.text = timeString
        if countWhite == 0 { // Go to Results
            // set a winner
            gameOver = true
            finish()
            
            timerCountingWhite = false
            timerWhite.invalidate()
            countWhite = resetCount
        }
    }
    
    @objc func timerBlackCounter() -> Void
    {
        let resetCount = countBlack
        countBlack = countBlack - 1
        let time = secondsToHoursMinutesSeconds(seconds: countBlack)
        let timeString = makeTimeString(minutes: time.0, seconds: time.1)
        blackTime.text = timeString
        if countBlack == 0 { // Go to Results
            // set a winner
            gameOver = true
            finish()
            
            timerCountingBlack = false
            timerBlack.invalidate()
            countBlack = resetCount
        }
    }
    
    func secondsToHoursMinutesSeconds(seconds: Int) -> (Int, Int)
    {
        return (((seconds % 3600) / 60),((seconds % 3600) % 60)) // H:M:S
    }
    
    func makeTimeString(minutes: Int, seconds : Int) -> String
    {
        var timeString = ""
        timeString += String(format: "%02d", minutes)
        timeString += " : "
        timeString += String(format: "%02d", seconds)
        return timeString
    }
}

//MARK: - Rotation func for label, button, image

extension TimerViewController {
    
    func rotateAll() {
        rotateLable(with: blackTime)
        rotateLable(with: whiteTime)
        //        rotateButton(with: startButton)
        //        rotateButton(with: stopButton)
        rotateImage(with: blackHorse)
        rotateImage(with: whiteHorse)
    }
    
    func rotateLable(with label: UILabel) {
        label.transform = CGAffineTransform(rotationAngle: CGFloat.pi / 2)
    }
    func rotateButton(with label: UIButton) {
        label.transform = CGAffineTransform(rotationAngle: CGFloat.pi / 2)
    }
    func rotateImage(with label: UIImageView) {
        label.transform = CGAffineTransform(rotationAngle: CGFloat.pi / 2)
    }
}

//MARK: - Soud func

extension TimerViewController {
    
    func playSound(soundName: String) {
            let url = Bundle.main.url(forResource: soundName, withExtension: "wav")
            player = try! AVAudioPlayer(contentsOf: url!)
            player.play()
            
        }
}
