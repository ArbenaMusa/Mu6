//
//  MainViewController.swift
//  Mu6
//
//  Created by Arbena on 7/13/20.
//  Copyright © 2020 am. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {

    @IBOutlet weak var showAlertButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        showAlertButton.addTarget(self, action: #selector(showAlert), for: .touchUpInside)
    }
    
    /*
     This method created and presents alert dialog
     */
    @objc func showAlert(){
        let alertView = UIAlertController(title : "What app offers!", message: "This app is created for 2+ childs who can learn through the joy of music!", preferredStyle: .alert)
        alertView.addAction(UIAlertAction(title: "close", style: .default, handler:{ (_) in
            print("Alert button was pressed!")
        }))
        
        self.present(alertView, animated: true, completion: nil)
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
