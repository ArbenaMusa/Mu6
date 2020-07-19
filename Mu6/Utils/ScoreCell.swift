//
//  ScoreCellTableViewCell.swift
//  Mu6
//
//  Created by Arbena on 18.7.20.
//  Copyright © 2020 am. All rights reserved.
//

import UIKit

class ScoreCell: UITableViewCell {

    @IBOutlet weak var scoreLabel: UILabel!
    
    func setScore(scoreModel: ScoreModel){
        scoreLabel.text = String(scoreModel.score)
    }
}
