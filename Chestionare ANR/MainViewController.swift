//
//  ViewController.swift
//  Chestionare ANR
//
//  Created by Marius Tanasoiu on 6/20/20.
//  Copyright © 2020 NavyMasters. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {

    @IBOutlet weak var containerView: UIView!;
    var visibleVC: UIViewController!;
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated);
       
        AppUtility.lockOrientation(.portrait, andRotateTo: .portrait)
   }
    
    
    
    @IBAction func backClicked(_ sender: Any) {
        if(visibleVC != nil) {
            visibleVC.view.isHidden = true;
        }
        
        mainMenuVC.view.isHidden = false;
        visibleVC = mainMenuVC;
    }
    
    lazy var mainMenuVC: MainMenuVC = {
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main);
        var viewController = storyboard.instantiateViewController(withIdentifier: "MainMenuVC") as! MainMenuVC;
        viewController.setMainController(self);
        self.addViewControllerAsChildViewController(childViewController: viewController)
        return viewController;
    }()
    
    lazy var questionnaireVC: QuestionnaireVC = {
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main);
        var viewController = storyboard.instantiateViewController(withIdentifier: "QuestionaireViewController") as! QuestionnaireVC;
        self.addViewControllerAsChildViewController(childViewController: viewController)
        return viewController;
    }()
    
    
    lazy var learningVC: LearningVC = {
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main);
        var viewController = storyboard.instantiateViewController(withIdentifier: "LearningViewController") as! LearningVC;
        viewController.setMainController(self);
        self.addViewControllerAsChildViewController(childViewController: viewController)
        return viewController;
    }()

    override func viewDidLoad() {
        super.viewDidLoad();
        XMLUtil.instance;
    }

    @IBAction func click(_ sender: UIButton) {
        mainMenuVC.view.isHidden = false;
        visibleVC = mainMenuVC;
    }
    
    public func mainMenuClicked(_ buttonName: String) {
        print("button name=" + buttonName);
        switch buttonName {
            case "chestionare_anr":
                if(visibleVC != nil) {
                    visibleVC.view.isHidden = true;
                }
                questionnaireVC.view.isHidden = false;
                visibleVC = questionnaireVC;
            case "mediu_de_invatare":
                if(visibleVC != nil) {
                    visibleVC.view.isHidden = true;
                }
                learningVC.view.isHidden = false;
                visibleVC = learningVC;
            default:
                print("default");
        }
    }
    
    
    private func addViewControllerAsChildViewController(childViewController: UIViewController) {
        addChild(childViewController);
        containerView.addSubview(childViewController.view);
        childViewController.view.frame = containerView.bounds;
        childViewController.view.autoresizingMask = [.flexibleWidth, .flexibleHeight];
        childViewController.didMove(toParent: self);
    }
    
    
    
}

