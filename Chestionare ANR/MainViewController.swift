//
//  ViewController.swift
//  Chestionare ANR
//
//  Created by Marius Tanasoiu on 6/20/20.
//  Copyright © 2020 NavyMasters. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {

    @IBOutlet weak var commercialImageView: UIImageView!
    @IBOutlet weak var containerView: UIView!;
    @IBOutlet weak var backButton: UIButton!
    var visibleVC: UIViewController!;
    var commercialTimer: Timer?;
    var lastRandom = 0;
    
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
        viewController.setMainController(self);
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
//        XMLUtil.instance;
        
        print("viewDidLoad");
        
        mainMenuVC.view.isHidden = false;
        visibleVC = mainMenuVC;
        backButton.isHidden = true;
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated);
        
        commercialTimer = Timer.scheduledTimer(timeInterval: 5, target: self, selector: #selector(changeCommercial), userInfo: nil, repeats: true);
        
        print("viewWillAppear111");
       
        AppUtility.lockOrientation(.portrait, andRotateTo: .portrait);
        
        commercialImageView.image =  UIImage(named: "reclama01");
        commercialImageView.contentMode = UIView.ContentMode.scaleToFill;
   }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated);
        commercialTimer?.invalidate();
    }
    
    @objc func changeCommercial() {
        let imageName =  "reclama0\(getRandomNumber())";
        commercialImageView.image =  UIImage(named: imageName);
    }
    
    private func getRandomNumber() -> Int {
        var number:Int;
        repeat {
            number = Int.random(in: 1..<4);
        } while number == lastRandom;
        lastRandom = number;
        
        return number;
    }
    
    
    @IBAction func backClicked(_ sender: Any) {
        if(visibleVC != nil) {
            visibleVC.view.isHidden = true;
        }
        
        mainMenuVC.view.isHidden = false;
        visibleVC = mainMenuVC;
        backButton.isHidden = true;
    }

    
    public func mainMenuClicked(_ buttonName: String) {
        print("button name=" + buttonName);
        switch buttonName {
            case "chestionare_anr":
                backButton.isHidden = false;
                if(visibleVC != nil) {
                    visibleVC.view.isHidden = true;
                }
                questionnaireVC.view.isHidden = false;
                visibleVC = questionnaireVC;
            case "mediu_de_invatare":
                backButton.isHidden = false;
                if(visibleVC != nil) {
                    visibleVC.view.isHidden = true;
                }
                learningVC.view.isHidden = false;
                visibleVC = learningVC;
            default:
                print("default");
        }
    }
    
    public func startTest(_ buttonName: String) {
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main);
        let vc = storyboard.instantiateViewController(withIdentifier: "QuestionViewController") as! QuestionVC;
        vc.modalPresentationStyle = .fullScreen;
        present(vc, animated: false, completion: nil);
    }
    
    
    
    
    private func addViewControllerAsChildViewController(childViewController: UIViewController) {
        addChild(childViewController);
        containerView.addSubview(childViewController.view);
        childViewController.view.frame = containerView.bounds;
        childViewController.view.autoresizingMask = [.flexibleWidth, .flexibleHeight];
        childViewController.didMove(toParent: self);
    }
    
    
    
}

