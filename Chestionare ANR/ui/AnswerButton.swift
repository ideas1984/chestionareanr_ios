//
//  AnswerButton.swift
//  Chestionare ANR
//
//  Created by Marius Tanasoiu on 2/9/21.
//  Copyright © 2021 NavyMasters. All rights reserved.
//

import UIKit

class Answerbutton: UIView {
    
    private var selected = true;

    override func didMoveToWindow() {
        
        setSelected(selected);
        
        self.layer.cornerRadius = 10;
        self.layer.shadowColor = UIColor.black.cgColor;
        self.layer.shadowRadius = 4;
        self.layer.shadowOpacity = 1;
        self.layer.shadowOffset = CGSize(width: 0, height: 0);
    }
    
    func setSelected(_ selected: Bool) {
        self.selected = selected;
        
        if(selected) {
            self.backgroundColor = UIColor(red: 1, green: 0.62, blue: 0.61, alpha: 1);
        } else {
            self.backgroundColor = UIColor.white;

        }
    }

}

