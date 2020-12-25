//
//  QuestionVC.swift
//  Chestionare ANR
//
//  Created by Marius Tanasoiu on 12/23/20.
//  Copyright © 2020 NavyMasters. All rights reserved.
//

import UIKit

class QuestionVC: UIViewController {
    
    var isCommercialShowed = false;
    var category:String?;
  
    override func viewDidLoad() {
        super.viewDidLoad();
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated);
        
        if(!isCommercialShowed) {
            isCommercialShowed = true;
            let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main);
            let vc = storyboard.instantiateViewController(withIdentifier: "commercial_vc") as! CommercialVC;
            vc.modalPresentationStyle = .fullScreen;
            present(vc, animated: false, completion: nil);
        } else {
            switch category {
                case "categoria_d":
                    break;
                case "categoria_diferenta_d":
                    break;
            case "categoria_c":
                break;
            case "categoria_diferenta_c":
                break;
                default:
                    print("default");
            }
        }
        
   }
    
    @IBAction func backClicked(_ sender: Any) {
        if let nav = self.navigationController {
                    nav.popViewController(animated: true)
                } else {
                    self.dismiss(animated: true, completion: nil)
                }
    }
    
}
