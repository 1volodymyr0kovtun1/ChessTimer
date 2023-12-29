//
//  ViewController.swift
//  ChessTimer
//
//  Created by мак on 27.12.2023.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .portrait
    }

    @IBAction func startButtonPressed(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let durationController = storyboard.instantiateViewController(withIdentifier: "select_duration") as! TimeSelectViewController
        
        //MARK: - durationController view
        //durationController.loadViewIfNeeded() ...
        
        self.present(durationController, animated: true, completion: nil)
    }
    
}

