//
//  AboutVC.swift
//  Chestionare ANR
//
//  Created by Marius Tanasoiu on 2/9/21.
//  Copyright © 2021 NavyMasters. All rights reserved.
//

import UIKit

class ContactVC: UIViewController {
    
    @IBAction func buttonTapped(_ sender: UITapGestureRecognizer) {
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main);
        let pdfVC = storyboard.instantiateViewController(withIdentifier: "PDFViewerVC") as! PDFViewerVC;
        pdfVC.modalPresentationStyle = .fullScreen;
        
        switch sender.view?.accessibilityIdentifier?.description {
            case "but_semnalizarea_vizuala":
                pdfVC.fileName = "semnalizarea_vizuala_a_navelor";
            case "but_semnale_sonore":
                pdfVC.fileName = "semnale _sonore";
            case "but_semnale_care_servesc_reglementarii":
                pdfVC.fileName = "semnale_care_servesc_reglementării_navigatiei_pe_calea_navigabila";
            case "but_balizarea_caii_navigabile":
                pdfVC.fileName = "balizarea_caii_navigabile";
        default:
            print("no button recognized");
        }
        
        present(pdfVC, animated: true, completion: nil);
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

}
