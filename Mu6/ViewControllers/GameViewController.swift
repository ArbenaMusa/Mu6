//
//  GameViewController.swift
//  Mu6
//
//  Created by Arbena on 18.7.20.
//  Copyright © 2020 am. All rights reserved.
//

import UIKit

class GameViewController: UIViewController {

    @IBOutlet weak var levelLabel: UILabel!
    var labelText = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        levelLabel.text = labelText

        // Do any additional setup after loading the view.
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
