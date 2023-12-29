//
//  TimeSelectViewController.swift
//  ChessTimer
//
//  Created by мак on 27.12.2023.
//

import UIKit

class TimeSelectViewController: UIViewController {
    
    var timeToPlay: Int?

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .portrait
    }
    
    
    @IBAction func timeButtonPressed(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let timerController = storyboard.instantiateViewController(withIdentifier: "timer") as! TimerViewController
        
        let time = sender.titleLabel?.text! ?? "0"
        
        timeToPlay = Int(time.split(separator: " ")[0]) ?? 0
        
        //MARK: - Change timer for players
        
        timerController.loadViewIfNeeded()
        timerController.whiteTime.text = "\(timeToPlay ?? 0):00"
        timerController.blackTime.text = "\(timeToPlay ?? 0):00"
        timerController.countWhite = timeToPlay!*60
        timerController.countBlack = timeToPlay!*60
        
        self.present(timerController, animated: true, completion: nil)
    }
    
    
}
