//
//  LearningDetailsVC.swift
//  Chestionare ANR
//
//  Created by Marius Tanasoiu on 1/29/21.
//  Copyright © 2021 NavyMasters. All rights reserved.
//

import UIKit

import Foundation

class LearningDetailsVC: UIViewController {
    
    @IBOutlet weak var titleLabel: UILabel!;
    @IBOutlet weak var totalQuestionsLabel: UILabel!;
    @IBOutlet weak var totalCoveredLabel: UILabel!;
    @IBOutlet weak var percentageCoveredLabel: UILabel!;
    
    @IBOutlet weak var buttonLabel: UILabel!;
    
    var subcategory: Int?;
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated);
        
        let defaults = UserDefaults.standard;
        
        var totalCovered:Int = 0;
        var totalSubcategoryQuestions:Int = 0;
        
//        UserDefaults.standard.set(0, forKey: Const.getKey(forSubcategory: 1));
        
        switch subcategory! {
            case Const.SUBCATEGORY_REGULAMENT_NAVIGATIE_D:
                titleLabel.text = "Regulament de navigație pe Dunăre";
                
                totalSubcategoryQuestions = XMLUtil.instance.regulamentNavigatieDQuestions.count;
                totalCovered = defaults.integer(forKey: Const.KEY_COVERED_SUBCATEGORY_1);
                
            case Const.SUBCATEGORY_MARINARIE_D:
                titleLabel.text = "Marinărie";
                
                totalSubcategoryQuestions = XMLUtil.instance.marinarieDQuestions.count;
                totalCovered = defaults.integer(forKey: Const.KEY_COVERED_SUBCATEGORY_2);
                
            case Const.SUBCATEGORY_CONDUCEREA_SI_MANEVRAREA_D:
                titleLabel.text = "Conducerea şi manevrarea ambarcațiunilor cu motor";
                
                totalSubcategoryQuestions = XMLUtil.instance.conducereaSiManevrareaDQuestions.count;
                totalCovered = defaults.integer(forKey: Const.KEY_COVERED_SUBCATEGORY_3);
                
            case Const.SUBCATEGORY_COLREG_C:
                titleLabel.text = "COLREG";
                
                totalSubcategoryQuestions = XMLUtil.instance.colregCQuestions.count;
                totalCovered = defaults.integer(forKey: Const.KEY_COVERED_SUBCATEGORY_4);
                
            case Const.SUBCATEGORY_NAVIGATIE_MARITIMA_C:
                titleLabel.text = "Navigație maritimă";
                
                totalSubcategoryQuestions = XMLUtil.instance.navigatieMaritimaCQuestions.count;
                totalCovered = defaults.integer(forKey: Const.KEY_COVERED_SUBCATEGORY_5);
                
            case Const.SUBCATEGORY_MARINARIE_C:
                titleLabel.text = "Marinărie";
                
                totalSubcategoryQuestions = XMLUtil.instance.marinarieCQuestions.count;
                totalCovered = defaults.integer(forKey: Const.KEY_COVERED_SUBCATEGORY_6);
                
            case Const.SUBCATEGORY_CONDUCEREA_SI_MANEVRAREA_C:
                titleLabel.text = "Conducerea şi manevrarea ambarcațiunilor cu motor";
                
                totalSubcategoryQuestions = XMLUtil.instance.conducereaSiManevrareaCQuestions.count;
                totalCovered = defaults.integer(forKey: Const.KEY_COVERED_SUBCATEGORY_7);
                
            default:
                print();
        }
        
        if(totalCovered > 0) {
            totalCovered += 1;
        }
        
        let percentage:Double = Double(100*totalCovered)/Double(totalSubcategoryQuestions);
        
        totalQuestionsLabel.text = "- \(totalSubcategoryQuestions) de întrebări";
        totalCoveredLabel.text = "- \(totalCovered) întrebări parcurse din totalul de \(totalSubcategoryQuestions)";
        percentageCoveredLabel.text = "- progres \(String(format: "%.2f", percentage))%";
        
        if(totalCovered > 0) {
            buttonLabel.text = "Continuă pregătirea";
        } else {
            buttonLabel.text = "Începe pregătirea";
        }
        
    }
    
    @IBAction func startContinueClicked(_ sender: UITapGestureRecognizer) {
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main);
        let learningViewController = storyboard.instantiateViewController(withIdentifier: "learning_vc") as! LearningVC;
        learningViewController.modalPresentationStyle = .fullScreen;
        learningViewController.subcategory = subcategory;
        present(learningViewController, animated: true, completion: nil);
    }
    
}

