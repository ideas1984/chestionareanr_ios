//
//  OtherVC.swift
//  Chestionare ANR
//
//  Created by Marius Tanasoiu on 6/22/20.
//  Copyright © 2020 NavyMasters. All rights reserved.
//

import UIKit

class MainMenuVC: UIViewController {
    
    var mainController: MainViewController!

    
    @IBAction func menuClicked(_ sender: CustomButton) {
        mainController.mainMenuClicked(sender.accessibilityIdentifier!)
    }
    
    public func setMainController(_ mainController: MainViewController) {
        self.mainController = mainController;
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

//        myLabel.text = "ala bala portocala melc melc codobelc ala bala portocala melc melc codobelc ala bala portocala melc melc codobelc ala bala portocala melc melc codobelc ala bala portocala melc melc codobelc ala bala portocala melc melc codobelc ala bala portocala melc melc codobelc ala bala portocala melc melc codobelc ala bala portocala melc melc codobelc ala bala portocala melc melc codobelc "
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
