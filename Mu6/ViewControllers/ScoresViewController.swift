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
    
    let db = DBHelper()
    
    // MARK: - Score main
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        scores = db.read()
        
        tableView.delegate = self
        tableView.dataSource = self
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
