//
//  CommercialVC.swift
//  Chestionare ANR
//
//  Created by Marius Tanasoiu on 12/19/20.
//  Copyright © 2020 NavyMasters. All rights reserved.
//

import UIKit

class CommercialVC: UIViewController {
    
    var category: String!;
    
    override func viewDidLoad() {
        super.viewDidLoad();
    }
    
    @IBAction func closeClicked(_ sender: Any) {
        if let nav = self.navigationController {
                    nav.popViewController(animated: true)
                } else {
                    self.dismiss(animated: true, completion: nil)
                }
    }
    
}
