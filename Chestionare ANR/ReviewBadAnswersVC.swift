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
    
    @IBOutlet weak var previousButton: ANRButton!;
    @IBOutlet weak var deleteButton: ANRButton!;
    @IBOutlet weak var nextButton: ANRButton!;
    
    @IBOutlet weak var helpButton: UIButton!
    @IBOutlet weak var questionIndexLabel: UILabel!
    
    var childVC : OneQuestionVC?;
    
    struct State {
        var wrongAnswers: [WrongAnswer] = [];
        var currentWrongAnswerIdx = 0;
    }
    
    var state = State();
    
    override func viewDidLoad() {
        super.viewDidLoad();
        
        self.definesPresentationContext = true;
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.didEnterBackground), name: UIApplication.didEnterBackgroundNotification, object: nil);
        NotificationCenter.default.addObserver(self, selector: #selector(self.willEnterForeground), name: UIApplication.willEnterForegroundNotification, object: nil);
        
        previousButton.addGestureRecognizer(UITapGestureRecognizer(target: self, action:  #selector (previousClicked (_:))));
        deleteButton.addGestureRecognizer(UITapGestureRecognizer(target: self, action:  #selector (deleteClicked (_:))));
        nextButton.addGestureRecognizer(UITapGestureRecognizer(target: self, action:  #selector (nextClicked (_:))));
        
        state = State(wrongAnswers: CoreDataManager.shared.loadWrongAnswers());
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated);
        
        showQuestion(atIndex: 0);
    }
    
    @IBAction func previousClicked(_ sender: UIView) {
        showQuestion(atIndex: state.currentWrongAnswerIdx - 1);
    }
    
    @IBAction func nextClicked(_ sender: UIView) {
        showQuestion(atIndex: state.currentWrongAnswerIdx + 1);
    }
    
    @IBAction func deleteClicked(_ sender: UIView) {
        let wrongAnswer = state.wrongAnswers[state.currentWrongAnswerIdx];
        CoreDataManager.shared.deleteWrongAnswer(wrongAnswer: wrongAnswer);
        
        state.wrongAnswers.remove(at: state.currentWrongAnswerIdx);
        
        if(state.currentWrongAnswerIdx >= state.wrongAnswers.count) {
            showQuestion(atIndex: state.currentWrongAnswerIdx - 1);
        } else {
            showQuestion(atIndex: state.currentWrongAnswerIdx);
        }
    }
    
    private func showQuestion(atIndex questionIndex: Int) {
        if(state.wrongAnswers.count == 0) {
            showNoData();
        } else {
            removePreviousChildViewControllerIfAny();
            
            let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main);
            let oneQuestionViewController = storyboard.instantiateViewController(withIdentifier: "OneQuestionViewController") as! OneQuestionVC;
            addViewControllerAsChildViewController(childViewController: oneQuestionViewController);

            view.layoutIfNeeded();//very important here. do not erase this
            
            let question = XMLUtil.instance.getQuestion(withID: Int(state.wrongAnswers[questionIndex].id));
            oneQuestionViewController.setQuestion(question, andNumber: questionIndex + 1);
            oneQuestionViewController.display(correctAnswer: question.correctAnswerId, andWrongAnswer: Int(state.wrongAnswers[questionIndex].wrongAnswerID));
            
            if(questionIndex <= 0 ) {
                previousButton.setEnabled(false);
            } else {
                previousButton.setEnabled(true);
            }

            
            if(questionIndex >= state.wrongAnswers.count - 1) {
                nextButton.setEnabled(false);
            } else {
                nextButton.setEnabled(true);
            }
            
            questionIndexLabel.text = "Întrebarea \(questionIndex + 1) din \(state.wrongAnswers.count)";

            state.currentWrongAnswerIdx = questionIndex;
        }
        
        animateHelpButton();
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
        
        questionIndexLabel.text = "Întrebarea 0 din 0";
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
        vc.hints = XMLUtil.instance.getQuestion(withID: Int(state.wrongAnswers[state.currentWrongAnswerIdx].id)).hints;
        present(vc, animated: false, completion: nil);
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
        
        if(state.wrongAnswers.count > 0 &&
            XMLUtil.instance.getQuestion(withID: Int(state.wrongAnswers[state.currentWrongAnswerIdx].id)).hints.count > 0) {
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
