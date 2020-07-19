//
//  PlayViewController.swift
//  Mu6
//
//  Created by Arbena on 7/13/20.
//  Copyright © 2020 am. All rights reserved.
//

import UIKit
import SQLite3

class PlayViewController: UIViewController {

    // MARK: - Initializations
    var level: Int = 1
    
    // MARK: - Play main
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    /*
     This function gets the selected value from segmentControl
     */
    @IBAction func didChangeSegment(_ sender: UISegmentedControl){
        if sender.selectedSegmentIndex == 0 {
            level = 1
        }
        else if sender.selectedSegmentIndex == 1 {
            level = 2
        }
        print("Level: " + String(level) )
    }
    
    /*
     This function passes level parameter gameViewController
     */
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "game" {
            let destinationController = segue.destination as! GameViewController
            destinationController.labelText = "Level " + String(level)
        }
    }
}
