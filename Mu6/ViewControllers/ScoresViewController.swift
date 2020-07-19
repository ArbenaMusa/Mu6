//
//  ScoresViewController.swift
//  Mu6
//
//  Created by Arbena on 7/13/20.
//  Copyright © 2020 am. All rights reserved.
//

import UIKit

class ScoresViewController: UIViewController {

    // MARK: - Initializations
    
    var scores: [ScoreModel] = []
    
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - Score main
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        scores = getScores()
        
        tableView.delegate = self
        tableView.dataSource = self

        // Do any additional setup after loading the view.
    }
    
    // MARK: - Score generation
    
    func getScores() -> [ScoreModel]{
        var tempScores: [ScoreModel] = []
        
        let score1 = ScoreModel(id: 1, score: 12)
        let score2 = ScoreModel(id: 2, score: 13)
        let score3 = ScoreModel(id: 3, score: 14)
        let score4 = ScoreModel(id: 4, score: 15)
        
        tempScores.append(score1)
        tempScores.append(score2)
        tempScores.append(score3)
        tempScores.append(score4)
        
        return tempScores
    }

}

// MARK: - DataSource/ViewDelegate extension
extension ScoresViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return scores.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let score = scores[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "ScoreCell") as! ScoreCell
        cell.setScore(scoreModel: score)
        
        return cell
    }
}
