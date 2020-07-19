//
//  BestScoresViewController.swift
//  Mu6
//
//  Created by Arbena on 7/13/20.
//  Copyright © 2020 am. All rights reserved.
//

import UIKit

class BestScoresViewController: UIViewController {

    // MARK: - BestScores main

    let db = DBHelper()
    
    @IBOutlet weak var highScoreLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let highestScore = db.getHighest()
        
        if(highestScore > 0){
            highScoreLabel.text = String(highestScore)
        }
        // Do any additional setup after loading the view.
    }

}
