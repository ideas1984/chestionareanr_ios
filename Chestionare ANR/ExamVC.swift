//
//  QuestionVC.swift
//  Chestionare ANR
//
//  Created by Marius Tanasoiu on 12/23/20.
//  Copyright © 2020 NavyMasters. All rights reserved.
//

import UIKit

class ExamVC: UIViewController, AnswerSelectedProtocol {
    
    public enum ViewState {
        case NONE, COMMERCIAL_SHOWED, QUESTION_DISPLAYED
    }
    
    struct TestState {
        var questions: [Question] = [];
        var skipped: [Int] = [];
        var currentQuestionIdx = 0;
        var goodAnswers = 0;
        var badAnswers = 0;
        var originalIndexes: [Int:Int] = [:];
    }
    
    
    var testState = TestState();
    var viewState: ViewState = ViewState.NONE;
    var category:Int?;
    var selectedAnswer: OneQuestionVC.AnswerEnum = OneQuestionVC.AnswerEnum.NONE_SELECTED;
    var childVC : OneQuestionVC?;
    var startTestDate:Date?;
    var questionViewController: OneQuestionVC?;
    var timeLeftCalculatorTimer: Timer?;
    var verifyAnswerTimer: Timer?;
    
    weak var testResultdelegate: TestResultProtocol?
    
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var skipButton: ANRButton!
    @IBOutlet weak var nextButton: ANRButton!
    @IBOutlet weak var remainingQuestionsLabel: UILabel!
    @IBOutlet weak var goodAnswersLabel: UILabel!
    @IBOutlet weak var badAnswersLabel: UILabel!
    @IBOutlet weak var helpButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad();
        
        self.definesPresentationContext = true;
        
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.didEnterBackground), name: UIApplication.didEnterBackgroundNotification, object: nil);
        NotificationCenter.default.addObserver(self, selector: #selector(self.willEnterForeground), name: UIApplication.willEnterForegroundNotification, object: nil);
        
        skipButton.addGestureRecognizer(UITapGestureRecognizer(target: self, action:  #selector (skipClicked (_:))));
        nextButton.addGestureRecognizer(UITapGestureRecognizer(target: self, action:  #selector (nextClicked (_:))));
        
        //        testState = TestState(questions: XMLUtil.instance.getRandomQuestions(fromCategory: category!));
        
        testState.questions = XMLUtil.instance.getRandomQuestions(fromCategory: category!);
        
        for index in 0...testState.questions.count - 1 {
            testState.originalIndexes[testState.questions[index].id] = index + 1;
        }
        
        nextButton.setEnabled(false);
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated);
        
        if(viewState == ViewState.NONE) {
            viewState = ViewState.COMMERCIAL_SHOWED;
            let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main);
            let vc = storyboard.instantiateViewController(withIdentifier: "commercial_vc") as! CommercialVC;
            vc.modalPresentationStyle = .fullScreen;
            present(vc, animated: false, completion: nil);
        } else if(viewState == ViewState.COMMERCIAL_SHOWED) {
            viewState = ViewState.QUESTION_DISPLAYED;
            
            startTestDate = Date();
            timeLeftCalculatorTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateTimeLeft), userInfo: nil, repeats: true);
            
            showQuestion(questionIndex: testState.currentQuestionIdx);
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated);
        timeLeftCalculatorTimer?.invalidate();
        verifyAnswerTimer?.invalidate();
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self);
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
        if(testState.questions[testState.currentQuestionIdx].hints.count > 0) {
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
    
    
    func answerSelected(_ answer: OneQuestionVC.AnswerEnum) {
        selectedAnswer = answer;
        if(answer == OneQuestionVC.AnswerEnum.NONE_SELECTED) {
            nextButton.setEnabled(false);
        } else {
            nextButton.setEnabled(true);
        }
    }
    
    
    @IBAction func skipClicked(_ sender: UIView) {
        if(testState.currentQuestionIdx == testState.questions.count - 1) {
            testState.currentQuestionIdx = 0;
        } else {
            testState.currentQuestionIdx += 1;
        }
        showQuestion(questionIndex: testState.currentQuestionIdx);
    }
    
    @IBAction func nextClicked(_ sender: UIView) {
        changeUserInteraction(false);
        
        if(UserDefaults.standard.bool(forKey: Const.KEY_SHOW_CORRECT_ANSWER)) {
            questionViewController?.display(correctAnswer: testState.questions[testState.currentQuestionIdx].correctAnswerId, andWrongAnswer: selectedAnswer.rawValue);
            verifyAnswerTimer = Timer.scheduledTimer(timeInterval: 3, target: self, selector: #selector(processAnswer), userInfo: nil, repeats: false);
        } else {
            processAnswer();
        }

    }
    
    @objc private func processAnswer() {
        changeUserInteraction(true);
        
        if(testState.questions[testState.currentQuestionIdx].correctAnswerId == selectedAnswer.rawValue) {
            testState.goodAnswers += 1;
        } else {
            testState.badAnswers += 1;
            CoreDataManager.shared.saveWrongQuestion(questionId: testState.questions[testState.currentQuestionIdx].id, wrongAnswerId: selectedAnswer.rawValue);
        }
        
        testState.questions.remove(at: testState.currentQuestionIdx);
        
        if(testFailed()) {
            dismiss(animated: true, completion: {
                self.testResultdelegate?.testFinished(withResult: TestResult.FAIL_NO_NECCESARY_ANSWERS, andGoodAnswers: self.testState.goodAnswers);
            });
        } else {
            if(testState.questions.isEmpty) { // no more questions
                dismiss(animated: true, completion: {
                    self.testResultdelegate?.testFinished(withResult: TestResult.PASS, andGoodAnswers: self.testState.goodAnswers);
                });
            } else {
                if(testState.currentQuestionIdx >= testState.questions.count) {
                    testState.currentQuestionIdx = 0;
                }
                showQuestion(questionIndex: testState.currentQuestionIdx);
            }
        }
    }
    
    
    private func testFailed() -> Bool {
        let badAnswersAllowed = AppUtility.instance.categoryInfoMap[category!]?.badAnswersAllowed();
        if(testState.badAnswers > badAnswersAllowed!) {
            return true;
        }
        return false;
    }
    
    @objc func updateTimeLeft() {
        let difference = Int(Date().timeIntervalSince(startTestDate!).rounded());
        let totalTime = AppUtility.instance.categoryInfoMap[category!]?.time;
        let timeLeft = totalTime! - difference;
        
        let minutes = timeLeft / 60 < 10 ? "0\(timeLeft / 60)" : "\(timeLeft / 60)";
        let seconds = timeLeft % 60 < 10 ? "0\(timeLeft % 60)" : "\(timeLeft % 60)";
        
        timeLabel.text = "Timp rămas: " + minutes + ":" + seconds;
        
        if(timeLeft <= 0) {
            let passScore = AppUtility.instance.categoryInfoMap[category!]?.passScore;
            if(testState.goodAnswers >= passScore!) {
                dismiss(animated: true, completion: {
                    self.testResultdelegate?.testFinished(withResult: TestResult.PASS, andGoodAnswers: self.testState.goodAnswers);
                });
            } else {
                dismiss(animated: true, completion: {
                    self.testResultdelegate?.testFinished(withResult: TestResult.FAIL_TIME_EXPIRED, andGoodAnswers: self.testState.goodAnswers);
                });
            }
        }
    }
    
    private func showQuestion(questionIndex index: Int) {
        
        removePreviousChildViewControllerIfAny();
        
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main);
        let viewController = storyboard.instantiateViewController(withIdentifier: "OneQuestionViewController") as! OneQuestionVC;
        addViewControllerAsChildViewController(childViewController: viewController);
        viewController.ansertSelectedDelegate = self;
        view.layoutIfNeeded();//very important here. do not erase this
        let originalQuestionIndex = testState.originalIndexes[testState.questions[index].id]!;
        viewController.setQuestion(testState.questions[index], andNumber: originalQuestionIndex);
        questionViewController = viewController;
        
        
        remainingQuestionsLabel.text = String(testState.questions.count);
        goodAnswersLabel.text = String(testState.goodAnswers);
        badAnswersLabel.text = String(testState.badAnswers);
        
        answerSelected(OneQuestionVC.AnswerEnum.NONE_SELECTED);
        if(testState.questions.count == 1) {
            skipButton.setEnabled(false);
        }
        
        animateHelpButton();
    }
    
    
    @IBAction func backClicked(_ sender: Any) {
        let alert = UIAlertController(title: nil, message: "Oprește testul în derulare?", preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Da", style: .default, handler: { (action: UIAlertAction!) in

            if let nav = self.navigationController {
                nav.popViewController(animated: true)
            } else {
                self.dismiss(animated: true, completion: nil)
            }
            
        }))
        alert.addAction(UIAlertAction(title: "Nu", style: .cancel, handler: nil))
        present(alert, animated: true, completion: nil);
    }
    
    @IBAction func helpClicked(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main);
        let vc = storyboard.instantiateViewController(withIdentifier: "hints_vc") as! HintsVC;
        //        vc.modalPresentationStyle = .overCurrentContext;
        //        vc.modalTransitionStyle = .crossDissolve;
        vc.hints = testState.questions[testState.currentQuestionIdx].hints;
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
    
    private func changeUserInteraction(_ state: Bool) {
        helpButton.isUserInteractionEnabled = state;
        skipButton.isUserInteractionEnabled = state;
        nextButton.isUserInteractionEnabled = state;
    }
    
}
