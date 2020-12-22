//
//  MenuVC.swift
//  Chestionare ANR
//
//  Created by Marius Tanasoiu on 6/22/20.
//  Copyright © 2020 NavyMasters. All rights reserved.
//

import UIKit

class QuestionnaireVC: UIViewController {
    
    var mainController: MainViewController!;

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    

    @IBAction func startTestClicked(_ sender: CustomButton) {
        mainController.startTest(sender.accessibilityIdentifier!);
    }
    
    
    public func setMainController(_ mainController: MainViewController) {
        self.mainController = mainController;
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
