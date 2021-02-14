//
//  CommercialVC.swift
//  Chestionare ANR
//
//  Created by Marius Tanasoiu on 12/19/20.
//  Copyright © 2020 NavyMasters. All rights reserved.
//

import UIKit

class CommercialVC: UIViewController {
    
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var closeButton: UIButton!
    
    var timeLeftCalculatorTimer: Timer?;
    var secondsToWait = 10;
    
    override func viewDidLoad() {
        super.viewDidLoad();
        closeButton.isHidden = true;
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated);
        
        if(secondsToWait > 0 ) {
            timeLabel.text = "\(secondsToWait)";
            timeLeftCalculatorTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateTimeLeft), userInfo: nil, repeats: true);
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated);
        timeLeftCalculatorTimer?.invalidate();
    }
    
    @IBAction func closeClicked(_ sender: Any) {
        if let nav = self.navigationController {
            nav.popViewController(animated: true);
        } else {
            self.dismiss(animated: true, completion: nil);
        }
    }
    
    @objc func updateTimeLeft() {
        secondsToWait -= 1;
        
        if(secondsToWait == 0) {
            timeLeftCalculatorTimer?.invalidate();
            timeLabel.isHidden = true;
            closeButton.isHidden = false;
        } else {
            timeLabel.text = "\(secondsToWait)";
        }
    }
    
}
