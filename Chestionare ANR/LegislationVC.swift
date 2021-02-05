//
//  LegislationVC.swift
//  Chestionare ANR
//
//  Created by Marius Tanasoiu on 2/5/21.
//  Copyright © 2021 NavyMasters. All rights reserved.
//

import UIKit

class LegislationVC: UIViewController {

    @IBAction func buttonTapped(_ sender: UITapGestureRecognizer) {
        
        
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main);
        let pdfVC = storyboard.instantiateViewController(withIdentifier: "PDFViewerVC") as! PDFViewerVC;
        pdfVC.modalPresentationStyle = .fullScreen;
        
        switch sender.view?.accessibilityIdentifier?.description {
            case "but_partea_a":
                pdfVC.fileName = "partea_a";
            case "but_partea_b_sect_1":
                pdfVC.fileName = "partea_b_sectiunea_1";
            case "but_partea_b_sect_2":
                pdfVC.fileName = "partea_b_sectiunea_2";
            case "but_partea_c":
                pdfVC.fileName = "partea_c";
            case "but_partea_d":
                pdfVC.fileName = "partea_d";
            case "but_anexe":
                pdfVC.fileName = "anexe";
            case "but_reg_navigatie_dunare":
                pdfVC.fileName = "regulament_navigatie_pe_dunare";
        default:
            print("no button recognized");
        }

        present(pdfVC, animated: true, completion: nil);
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

}
