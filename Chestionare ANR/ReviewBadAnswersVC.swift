//
//  ReviewBadAnswersVC.swift
//  Chestionare ANR
//
//  Created by Marius Tanasoiu on 2/9/21.
//  Copyright © 2021 NavyMasters. All rights reserved.
//

import UIKit


class ReviewBadAnswersVC: UIViewController {
    
    
    @IBOutlet weak var containerView: UIView!;
    
    @IBOutlet weak var deleteButton: ANRButton!;
    @IBOutlet weak var previousButton: ANRButton!;
    @IBOutlet weak var nextButton: ANRButton!;
    
    var childVC : OneQuestionVC?;
    
    override func viewDidLoad() {
        super.viewDidLoad();
        
//        let badAnswers = CoreDataManager.shared.loadWrongAnswers();
//        if(badAnswers.count == 0) {
            
            showNoData()

//        } else {
//
//        }
        
    }
    
    private func showNoData() {
        removePreviousChildViewControllerIfAny();
        
        let label = UILabel();
        label.text = "Momentan nu există date.\n\nÎntrebările greșite din timpul testelor vor fi afișate în această secțiune pentru a putea fi revizuite.";
        label.numberOfLines = 0;
        label.textAlignment = NSTextAlignment.center;
        containerView.addSubview(label);
        label.frame = containerView.bounds;
        label.autoresizingMask = [.flexibleWidth, .flexibleHeight];
        
        previousButton.setEnabled(false);
        deleteButton.setEnabled(false);
        nextButton.setEnabled(false);
    }
    
    @IBAction func backClicked(_ sender: Any) {
        if let nav = self.navigationController {
            nav.popViewController(animated: true)
        } else {
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    @IBAction func helpClicked(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main);
        let vc = storyboard.instantiateViewController(withIdentifier: "hints_vc") as! HintsVC;
        //        vc.modalPresentationStyle = .overCurrentContext;
        //        vc.modalTransitionStyle = .crossDissolve;
//        vc.hints = state.questions[state.currentQuestionIdx].hints;
        present(vc, animated: false, completion: nil);
    }
    
    private func addViewControllerAsChildViewController(childViewController: OneQuestionVC) {
        childVC = childViewController;
        addChild(childViewController);
        containerView.addSubview(childViewController.view);
        childViewController.view.frame = containerView.bounds;
        childViewController.view.autoresizingMask = [.flexibleWidth, .flexibleHeight];
        childViewController.didMove(toParent: self);
    }
    
    private func removePreviousChildViewControllerIfAny() {
        if(childVC != nil) {
            childVC!.ansertSelectedDelegate = nil;
            childVC!.willMove(toParent: nil);
            childVC!.view.removeFromSuperview();
            childVC!.removeFromParent();
        }
    }
    
    
}
