//
//  CustomButton.swift
//  Chestionare ANR
//
//  Created by Marius Tanasoiu on 6/30/20.
//  Copyright © 2020 NavyMasters. All rights reserved.
//

import UIKit

class CustomButton: UIButton {

    override func didMoveToWindow() {
        self.backgroundColor = UIColor.red;
        self.layer.cornerRadius = 10;
        self.setTitleColor(UIColor.white, for: .normal);
        self.layer.shadowColor = UIColor.blue.cgColor;
        self.layer.shadowRadius = 4;
        self.layer.shadowOpacity = 0.5;
        self.layer.shadowOffset = CGSize(width: 0, height: 0);
    }

}
