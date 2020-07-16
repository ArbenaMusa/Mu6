//
//  ContentView.swift
//  Mu6
//
//  Created by Arbena on 11.7.20.
//  Copyright © 2020 am. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
                   VCSwiftUIView(storyboard: "Main")
               }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
