//
//  LearningVC.swift
//  Chestionare ANR
//
//  Created by Marius Tanasoiu on 1/29/21.
//  Copyright © 2021 NavyMasters. All rights reserved.
//

import UIKit


class LearningVC: UIViewController, AnswerSelectedProtocol {
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var previousLabel: UILabel!
    @IBOutlet weak var nextLabel: UILabel!
    
    @IBOutlet weak var helpButton: UIButton!
    
    @IBOutlet weak var previousButton: UIView!
    @IBOutlet weak var verifyButton: UIView!
    @IBOutlet weak var nextButton: UIView!
    
    @IBOutlet weak var containerView: UIView!
    
    struct State {
        var questions: [Question] = [];
        var currentQuestionIdx = 0;
    }
    
    var state = State();
    var subcategory:Int?;
    var childVC : OneQuestionVC?;
    var selectedAnswer: OneQuestionVC.AnswerEnum = OneQuestionVC.AnswerEnum.NONE_SELECTED;

    override func viewDidLoad() {
        super.viewDidLoad();
        
        self.definesPresentationContext = true;
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.didEnterBackground), name: UIApplication.didEnterBackgroundNotification, object: nil);
        NotificationCenter.default.addObserver(self, selector: #selector(self.willEnterForeground), name: UIApplication.willEnterForegroundNotification, object: nil);
        
        previousButton.addGestureRecognizer(UITapGestureRecognizer(target: self, action:  #selector (previousClicked (_:))));
        verifyButton.addGestureRecognizer(UITapGestureRecognizer(target: self, action:  #selector (verifyClicked (_:))));
        nextButton.addGestureRecognizer(UITapGestureRecognizer(target: self, action:  #selector (nextClicked (_:))));
        
        state = State(questions: XMLUtil.instance.getQuestions(fromSubcategory: subcategory!));
        state.currentQuestionIdx = UserDefaults.standard.integer(forKey: Const.getKey(forSubcategory: subcategory!));
                
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated);

        showQuestion(atIndex: state.currentQuestionIdx); // call it here on view will appear
    }
    
    
    func answerSelected(_ answer: OneQuestionVC.AnswerEnum) {
        selectedAnswer = answer;
        if(answer == OneQuestionVC.AnswerEnum.NONE_SELECTED) {
            changeUIState(toButton: verifyButton, false);
        } else {
            changeUIState(toButton: verifyButton, true);
        }
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
        vc.hints = state.questions[state.currentQuestionIdx].hints;
        present(vc, animated: false, completion: nil);
    }
    
    @IBAction func previousClicked(_ sender: UIView) {
        showQuestion(atIndex: state.currentQuestionIdx - 1);
    }
    
    @IBAction func nextClicked(_ sender: UIView) {
        showQuestion(atIndex: state.currentQuestionIdx + 1);
    }
    
    @IBAction func verifyClicked(_ sender: UIView) {
        if(state.questions[state.currentQuestionIdx].correctAnswerId == selectedAnswer.rawValue) {
            print("corect");
        } else {
            print("gresit");
        }
    }
    
    @objc func willEnterForeground() {
        animateHelpButton();
        
        //        DispatchQueue.main.async { [weak self] in
        //            self?.helpButton.alpha = 1;
        //            self?.animateHelpButton();
        //        }
    }
    
    @objc func didEnterBackground() {}
    
    private func animateHelpButton() {
        if(state.questions[state.currentQuestionIdx].hints.count > 0) {
            helpButton.isHidden = false;
            helpButton.alpha = 1;
            UIView.animate(withDuration: 1,
                           delay: 0.5,
                           options: [UIView.AnimationOptions.autoreverse, UIView.AnimationOptions.repeat, UIView.AnimationOptions.allowUserInteraction],
                           animations: {
                            self.helpButton.alpha = 0.1;
                           },
                           completion: nil);
            } else {
                helpButton.isHidden = true;
            }
    }
    
    private func changeUIState(toButton button: UIView, _ enabled: Bool) {
        if(enabled) {
            button.isUserInteractionEnabled = true;
            button.backgroundColor = UIColor.white;
        } else {
            button.isUserInteractionEnabled = false;
//            button.backgroundColor = UIColor(named: "disable_color");
            button.backgroundColor = UIColor.gray;
        }
    }
    
    
    private func showQuestion(atIndex questionIndex: Int) {
        if(questionIndex <= -1 || questionIndex >= state.questions.count) {
            return;
        }
        
        removePreviousChildViewControllerIfAny();
        
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main);
        let oneQuestionViewController = storyboard.instantiateViewController(withIdentifier: "OneQuestionViewController") as! OneQuestionVC;
        addViewControllerAsChildViewController(childViewController: oneQuestionViewController);
        oneQuestionViewController.ansertSelectedDelegate = self;
        
        view.layoutIfNeeded();//very important here. do not erase this
        
        oneQuestionViewController.setQuestion(state.questions[questionIndex], andNumber: questionIndex + 1);
        
        answerSelected(OneQuestionVC.AnswerEnum.NONE_SELECTED);
        
        
        if(questionIndex <= 0 ) {
            changeUIState(toButton: previousButton, false);
            previousLabel.text = "";
        } else {
            changeUIState(toButton: previousButton, true);
            previousLabel.text = "\(questionIndex)";
        }
        
        if(questionIndex >= state.questions.count - 1) {
            changeUIState(toButton: nextButton, false);
            nextLabel.text = "";
        } else {
            changeUIState(toButton: nextButton, true);
            nextLabel.text = "\(questionIndex + 2)";
        }
        
        state.currentQuestionIdx = questionIndex;
        if(questionIndex > UserDefaults.standard.integer(forKey: Const.getKey(forSubcategory: subcategory!))) {
            UserDefaults.standard.set(questionIndex, forKey: Const.getKey(forSubcategory: subcategory!));
        }
        
        animateHelpButton();
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
