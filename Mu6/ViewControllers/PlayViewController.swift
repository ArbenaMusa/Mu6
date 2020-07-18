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

    var db: OpaquePointer?
    
    var level: Int = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let fileUrl = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false).appendingPathComponent("Mu6Database.sqlite")
        
        if sqlite3_open(fileUrl.path, &db) != SQLITE_OK{
            print("Error on opening database!")
            return
        }
        
        let createTableQuery = "CREATE TABLE IF NOT EXISTS Scores (id INTEGER PRIMARY KEY AUTOINCREMENT, score INTEGER)"
        
        if sqlite3_exec(db, createTableQuery, nil, nil, nil) != SQLITE_OK {
            print("Error on creating table!")
            return
        }
        
        // Do any additional setup after loading the view.
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
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
