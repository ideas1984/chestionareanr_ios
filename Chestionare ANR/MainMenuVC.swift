//
//  OtherVC.swift
//  Chestionare ANR
//
//  Created by Marius Tanasoiu on 6/22/20.
//  Copyright © 2020 NavyMasters. All rights reserved.
//

import UIKit

class MainMenuVC: UIViewController {
    
    var mainController: MainViewController!;
    
    override func viewDidLoad() {
        super.viewDidLoad();
    }
    
    @IBAction func buttonClicked(_ sender: UITapGestureRecognizer) {
        mainController.mainMenuClicked((sender.view?.accessibilityIdentifier!.description)!);
    }
    
    public func setMainController(_ mainController: MainViewController) {
        self.mainController = mainController;
    }

}
