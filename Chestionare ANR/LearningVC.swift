//
//  LearningVC.swift
//  Chestionare ANR
//
//  Created by Marius Tanasoiu on 7/19/20.
//  Copyright © 2020 NavyMasters. All rights reserved.
//

import UIKit

class LearningVC: UIViewController {
    
    var mainController: MainViewController!

    @IBAction func categorySelected(_ sender: UITapGestureRecognizer) {
        
            switch sender.view?.accessibilityIdentifier?.description {
            case "but_nav_dunare":
                print("but_nav_dunare");
            case "but_marinarie_1":
                print("but_marinarie_1");
            case "but_conducerea_manevrarea_1":
                print("but_conducerea_manevrarea_1");
            case "but_colreg":
                print("but_colreg");
            case "but_mavigatie_maritima":
                print("but_mavigatie_maritima");
            case "but_marinarie_2":
                print("but_marinarie_2");
            case "but_conducerea_manevrarea_2":
                print("but conducerea si manevrarea 2");
            default:
                print("default");
        }

    }
    
    @IBAction func menuClicked(_ sender: CustomButton) {
        mainController.mainMenuClicked(sender.accessibilityIdentifier!)
    }
    
    public func setMainController(_ mainController: MainViewController) {
        self.mainController = mainController;
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

}
