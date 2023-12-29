//
//  ResultViewController.swift
//  ChessTimer
//
//  Created by мак on 28.12.2023.
//

import UIKit

class ResultViewController: UIViewController {
    
    
    @IBOutlet weak var winnerLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        winnerLabel.layer.masksToBounds = true
        winnerLabel.layer.cornerRadius = 5
        
        winnerLabel.transform = CGAffineTransform(rotationAngle: CGFloat.pi / 2)

        
    }
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .portrait
    }
    

}
