//
//  LearningVC.swift
//  Chestionare ANR
//
//  Created by Marius Tanasoiu on 7/19/20.
//  Copyright © 2020 NavyMasters. All rights reserved.
//

import UIKit

class LearningMenuVC: UIViewController {
    
    var mainController: MainViewController!

    @IBAction func categorySelected(_ sender: UITapGestureRecognizer) {
        mainController.learningSubcategorySelected(subcategory: (sender.view?.accessibilityIdentifier!.description)!);
    }
    
    public func setMainController(_ mainController: MainViewController) {
        self.mainController = mainController;
    }
    
}
