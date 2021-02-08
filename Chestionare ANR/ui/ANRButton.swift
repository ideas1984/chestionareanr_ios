//
//  ANRButton.swift
//  Chestionare ANR
//
//  Created by Marius Tanasoiu on 2/7/21.
//  Copyright © 2021 NavyMasters. All rights reserved.
//

import UIKit

class ANRButton: UIView {
    
    private var enabled = true;
    private var checked = true;

    override func didMoveToWindow() {
//        self.backgroundColor = UIColor(named: "button_enabled") ;
//        self.layer.cornerRadius = 10;
//        self.setTitleColor(UIColor.white, for: .normal);
//        self.layer.shadowColor = UIColor.black.cgColor;
//        self.layer.shadowRadius = 4;
//        self.layer.shadowOpacity = 1;
//        self.layer.shadowOffset = CGSize(width: 0, height: 0);
        
        setEnabled(enabled);
        setChecked(checked);
    }
    
    func setEnabled(_ enabled: Bool) {
        self.enabled = enabled;
        isUserInteractionEnabled = enabled;
        
        if(enabled) {
            self.backgroundColor = UIColor(named: "button_enabled") ;
            self.layer.cornerRadius = 10;
            self.layer.shadowColor = UIColor.black.cgColor;
            self.layer.shadowRadius = 4;
            self.layer.shadowOpacity = 1;
            self.layer.shadowOffset = CGSize(width: 0, height: 0);
        } else {
            self.backgroundColor = UIColor.lightGray;
            self.layer.cornerRadius = 10;
            self.layer.shadowColor = UIColor.black.cgColor;
            self.layer.shadowRadius = 4;
            self.layer.shadowOpacity = 1;
            self.layer.shadowOffset = CGSize(width: 0, height: 0);
        }
    }
    
    func setChecked(_ checked: Bool) {
        self.checked = checked;
        
        if(checked) {
            self.backgroundColor = UIColor(named: "button_enabled") ;
            self.layer.cornerRadius = 10;
            self.layer.shadowColor = UIColor.black.cgColor;
            self.layer.shadowRadius = 4;
            self.layer.shadowOpacity = 1;
            self.layer.shadowOffset = CGSize(width: 0, height: 0);
        } else {
            self.backgroundColor = UIColor.darkGray;
            self.layer.cornerRadius = 10;
            self.layer.shadowColor = UIColor.black.cgColor;
            self.layer.shadowRadius = 4;
            self.layer.shadowOpacity = 1;
            self.layer.shadowOffset = CGSize(width: 0, height: 0);
        }
    }

}
