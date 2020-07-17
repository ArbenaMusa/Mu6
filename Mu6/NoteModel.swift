//
//  NoteModel.swift
//  Mu6
//
//  Created by Arbena on 7/17/20.
//  Copyright © 2020 am. All rights reserved.
//

import UIKit

class NoteModel{
    var name : Character
    var imgPath: String
    var key: Keys
    
    init(name: Character, imgPath: String, key: Keys){
        self.name = name
        self.imgPath = imgPath
        self.key = key
    }
}

enum Keys {
    case Sol
    case Bass
}
