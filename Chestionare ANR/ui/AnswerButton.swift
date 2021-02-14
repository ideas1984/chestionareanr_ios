//
//  AnswerButton.swift
//  Chestionare ANR
//
//  Created by Marius Tanasoiu on 2/9/21.
//  Copyright © 2021 NavyMasters. All rights reserved.
//

import UIKit

class AnswerButton: UIView {
    
    public enum ButtonState : Int {
        case DEFAULT, SELECTED, CORRECT_ANSWER, WRONG_ANSWER
    }
    
    private var state = ButtonState.DEFAULT;
    
    override func didMoveToWindow() {
        
        setState(state);
        
        self.layer.cornerRadius = 10;
        self.layer.shadowColor = UIColor.black.cgColor;
        self.layer.shadowRadius = 4;
        self.layer.shadowOpacity = 1;
        self.layer.shadowOffset = CGSize(width: 0, height: 0);
    }
    
    func setState(_ state: ButtonState) {
        self.state = state;
        
        switch state {
        case ButtonState.DEFAULT:
            self.backgroundColor = UIColor.white;
        case ButtonState.SELECTED:
            self.backgroundColor = UIColor(named: "answer_selected");
        case ButtonState.CORRECT_ANSWER:
            self.backgroundColor = UIColor(named: "answer_correct");
        case ButtonState.WRONG_ANSWER:
            self.backgroundColor = UIColor(named: "answer_wrong");
        }
    }

}

