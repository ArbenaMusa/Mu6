//
//  VCSwiftUIView.swift
//  Mu6
//
//  Created by Arbena on 16.7.20.
//  Copyright © 2020 am. All rights reserved.
//


import SwiftUI
import UIKit

struct VCSwiftUIView: UIViewControllerRepresentable {
    let storyboard: String

  func makeUIViewController(context: UIViewControllerRepresentableContext<VCSwiftUIView>) -> MainViewController {
    
    //Load the storyboard
    let loadedStoryboard = UIStoryboard(name: storyboard, bundle: nil)
    
    //Load the ViewController
     return loadedStoryboard.instantiateViewController(withIdentifier:"VC") as! MainViewController
    
  }
  
  func updateUIViewController(_ uiViewController: MainViewController, context: UIViewControllerRepresentableContext<VCSwiftUIView>) {
  }
}
