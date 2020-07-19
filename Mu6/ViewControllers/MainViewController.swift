//
//  MainViewController.swift
//  Mu6
//
//  Created by Arbena on 7/13/20.
//  Copyright © 2020 am. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {

    // MARK: - Initializations
    @IBOutlet weak var showAlertButton: UIButton!
    
    // MARK: - Main main
    override func viewDidLoad() {
        super.viewDidLoad()
        
        showAlertButton.addTarget(self, action: #selector(showAlert), for: .touchUpInside)
    }
    
    // MARK: - Description alert dialog
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

}
