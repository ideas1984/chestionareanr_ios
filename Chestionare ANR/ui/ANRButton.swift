//
//  ANRButton.swift
//  Chestionare ANR
//
//  Created by Marius Tanasoiu on 2/7/21.
//  Copyright © 2021 NavyMasters. All rights reserved.
//

import UIKit

class ANRButton: UIView {

    override func didMoveToWindow() {
        self.backgroundColor = UIColor.lightGray;
        self.layer.cornerRadius = 10;
//        self.setTitleColor(UIColor.white, for: .normal);
        self.layer.shadowColor = UIColor.black.cgColor;
        self.layer.shadowRadius = 6;
        self.layer.shadowOpacity = 1;
        self.layer.shadowOffset = CGSize(width: 0, height: 0);
    }

}
