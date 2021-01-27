//
//  ViewController.swift
//  Chestionare ANR
//
//  Created by Marius Tanasoiu on 6/20/20.
//  Copyright © 2020 NavyMasters. All rights reserved.
//

import UIKit

class MainViewController: UIViewController, TestResultProtocol {
    
    @IBOutlet weak var commercialImageView: UIImageView!
    @IBOutlet weak var containerView: UIView!;
    @IBOutlet weak var backButton: UIButton!
    var visibleVC: UIViewController!;
    var commercialTimer: Timer?;
    var lastRandom = 0;
    
//    lazy var mainMenuVC: MainMenuVC = {
//        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main);
//        var viewController = storyboard.instantiateViewController(withIdentifier: "MainMenuVC") as! MainMenuVC;
//        viewController.setMainController(self);
//        self.addViewControllerAsChildViewController(childViewController: viewController)
//        return viewController;
//    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad();
        //        XMLUtil.instance;
        
        
        openMainMenuViewController();
        
        
//        CoreDataManager.shared.resetCoreData();
        
//        print(CoreDataManager.shared.loadWrongAnswers().count);
        
//        for wrongAnswer in CoreDataManager.shared.loadWrongAnswers() {
//            print("\(wrongAnswer.id)");
//        }
        
        for wrongAnswer in CoreDataManager.shared.loadWrongAnswers() {
            print("\(wrongAnswer.id)");
        }
        
        
//        CoreDataManager.shared.saveWrongQuestion(questionId: 1, wrongAnswerId: 101);
//        CoreDataManager.shared.saveWrongQuestion(questionId: 2, wrongAnswerId: 102);
//        CoreDataManager.shared.saveWrongQuestion(questionId: 3, wrongAnswerId: 103);
//        CoreDataManager.shared.saveWrongQuestion(questionId: 4, wrongAnswerId: 104);
//        CoreDataManager.shared.saveWrongQuestion(questionId: 5, wrongAnswerId: 105);
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated);
        
        commercialTimer = Timer.scheduledTimer(timeInterval: 5, target: self, selector: #selector(changeCommercial), userInfo: nil, repeats: true);
        
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
        openMainMenuViewController();
    }
    
    
    public func mainMenuClicked(_ buttonName: String) {
        switch buttonName {
        case "chestionare_anr":
            backButton.isHidden = false;
            
            removeExistingViewController();
            
            let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main);
            let questionnaireVC = storyboard.instantiateViewController(withIdentifier: "QuestionaireViewController") as! QuestionnaireVC;
            questionnaireVC.setMainController(self);
            self.addViewControllerAsChildViewController(childViewController: questionnaireVC);
            
            visibleVC = questionnaireVC;
            
        case "mediu_de_invatare":
            backButton.isHidden = false;
            
            removeExistingViewController();
            
            let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main);
            let learningVC = storyboard.instantiateViewController(withIdentifier: "LearningViewController") as! LearningVC;
            learningVC.setMainController(self);
            self.addViewControllerAsChildViewController(childViewController: learningVC);
            
            visibleVC = learningVC;
            
        default:
            print("default");
        }
    }
    
    public func startTest(_ buttonName: String) {
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main);
        let vc = storyboard.instantiateViewController(withIdentifier: "QuestionViewController") as! ExamVC;
        vc.testResultdelegate = self;
        
        if (buttonName == "categoria_d") {
            vc.category = Const.CATEGORY_D;
        } else if(buttonName == "categoria_diferenta_d") {
            vc.category = Const.CATEGORY_DIFERENTA_D;
        } else if(buttonName == "categoria_c") {
            vc.category = Const.CATEGORY_C;
        } else if(buttonName == "categoria_diferenta_c") {
            vc.category = Const.CATEGORY_DIFERENTA_C;
        }
        
        vc.modalPresentationStyle = .fullScreen;
        present(vc, animated: false, completion: nil);
    }
    
    func testFinished(withResult result: TestResult, andGoodAnswers goodAnswers: Int) {
        backButton.isHidden = false;
        
        removeExistingViewController();
        
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main);
        let testResultVC = storyboard.instantiateViewController(withIdentifier: "test_result_vc") as! TestResultVC;
        testResultVC.testResult = result;
        testResultVC.goodAnswers = goodAnswers;
        self.addViewControllerAsChildViewController(childViewController: testResultVC);
        
        visibleVC = testResultVC;
    }
    
    private func openMainMenuViewController() {
        removeExistingViewController();
        
        backButton.isHidden = true;
        
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main);
        let mainMenu = storyboard.instantiateViewController(withIdentifier: "MainMenuVC") as! MainMenuVC;
        mainMenu.setMainController(self);
        self.addViewControllerAsChildViewController(childViewController: mainMenu);
        
        visibleVC = mainMenu;
    }
    
    private func removeExistingViewController() {
        if(visibleVC != nil) {
            visibleVC.view.removeFromSuperview();
            visibleVC.removeFromParent();
            visibleVC.dismiss(animated: false, completion: nil);
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

