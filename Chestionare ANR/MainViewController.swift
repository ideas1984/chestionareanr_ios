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
//        for wrongAnswer in CoreDataManager.shared.loadWrongAnswers() {
//            print("\(wrongAnswer.id)");
//        }
        
        
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
        if(visibleVC is LearningDetailsVC) {
            openLearningMenuViewController();
        } else {
            openMainMenuViewController();
        }
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
            openLearningMenuViewController();
            
        case "indicatoare_si_semnale":
            backButton.isHidden = false;
            
            removeExistingViewController();
            
            let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main);
            let signsAndSignalsVC = storyboard.instantiateViewController(withIdentifier: "signs_and_signals_vc") as! SignsAndSignalsVC;
            self.addViewControllerAsChildViewController(childViewController: signsAndSignalsVC);
            
            visibleVC = signsAndSignalsVC;
            
        case "legislatie":
            backButton.isHidden = false;
            
            removeExistingViewController();
            
            let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main);
            let legislationVC = storyboard.instantiateViewController(withIdentifier: "legislation_vc") as! LegislationVC;
            self.addViewControllerAsChildViewController(childViewController: legislationVC);
            
            visibleVC = legislationVC;
            
        case "istoric_si_rapoarte":
            backButton.isHidden = false;
            
            removeExistingViewController();
            
            let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main);
            let historyAndReportsVC = storyboard.instantiateViewController(withIdentifier: "history_and_reports_vc") as! HistoryAndReportsVC;
            self.addViewControllerAsChildViewController(childViewController: historyAndReportsVC);
            
            visibleVC = historyAndReportsVC;
            
        case "setari":
            backButton.isHidden = false;
            
            removeExistingViewController();
            
            let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main);
            let settingsViewController = storyboard.instantiateViewController(withIdentifier: "settings_vc") as! SettingsVC;
            self.addViewControllerAsChildViewController(childViewController: settingsViewController);
            
            visibleVC = settingsViewController;
            
        case "contact":
            backButton.isHidden = false;
            
            removeExistingViewController();
            
            let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main);
            let contactViewController = storyboard.instantiateViewController(withIdentifier: "contact_vc") as! ContactVC;
            self.addViewControllerAsChildViewController(childViewController: contactViewController);
            
            visibleVC = contactViewController;
            
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
        
        CoreDataManager.shared.saveTestResult(result: result);
        
        backButton.isHidden = false;
        
        removeExistingViewController();
        
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main);
        let testResultVC = storyboard.instantiateViewController(withIdentifier: "test_result_vc") as! TestResultVC;
        testResultVC.testResult = result;
        testResultVC.goodAnswers = goodAnswers;
        self.addViewControllerAsChildViewController(childViewController: testResultVC);
        
        visibleVC = testResultVC;
    }
    
    private func openLearningMenuViewController() {
        backButton.isHidden = false;
        
        removeExistingViewController();
        
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main);
        let learningVC = storyboard.instantiateViewController(withIdentifier: "learning_menu_vc") as! LearningMenuVC;
        learningVC.setMainController(self);
        self.addViewControllerAsChildViewController(childViewController: learningVC);
        
        visibleVC = learningVC;
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
    
    public func learningSubcategorySelected(subcategory subgategory: String) {
        removeExistingViewController();
        
        backButton.isHidden = false;
        
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main);
        let learningDetailsVC = storyboard.instantiateViewController(withIdentifier: "learning_details_vc") as! LearningDetailsVC;
        
        switch subgategory {
            case "but_nav_dunare":
                learningDetailsVC.subcategory = Const.SUBCATEGORY_REGULAMENT_NAVIGATIE_D;
            case "but_marinarie_d":
                learningDetailsVC.subcategory = Const.SUBCATEGORY_MARINARIE_D;
            case "but_conducerea_manevrarea_d":
                learningDetailsVC.subcategory = Const.SUBCATEGORY_CONDUCEREA_SI_MANEVRAREA_D;
            case "but_colreg":
                learningDetailsVC.subcategory = Const.SUBCATEGORY_COLREG_C;
            case "but_mavigatie_maritima":
                learningDetailsVC.subcategory = Const.SUBCATEGORY_NAVIGATIE_MARITIMA_C;
            case "but_marinarie_c":
                learningDetailsVC.subcategory = Const.SUBCATEGORY_MARINARIE_C;
            case "but_conducerea_manevrarea_c":
                learningDetailsVC.subcategory = Const.SUBCATEGORY_CONDUCEREA_SI_MANEVRAREA_C;
            default:
                print("unknown subcategory selected");
        }
        
        self.addViewControllerAsChildViewController(childViewController: learningDetailsVC);
        
        visibleVC = learningDetailsVC;
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

