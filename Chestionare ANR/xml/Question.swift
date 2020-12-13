//
//  Question.swift
//  Chestionare ANR
//
//  Created by Marius Tanasoiu on 10/16/20.
//  Copyright © 2020 NavyMasters. All rights reserved.
//

import UIKit

struct Question {
    var id: Int;
    var name: String;
    var category = [Int]();
    var subcategory : Int;
    var image: String;
    var answers = [Int: String]();
    var correctAnswerId: Int;
    var hints = [Int]();
    
}
