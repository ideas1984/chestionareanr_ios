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
    var viewState: ViewState = ViewState.COMMERCIAL_SHOWED;
    var category:Int?;
    var selectedAnswer: OneQuestionVC.AnswerEnum = OneQuestionVC.AnswerEnum.NONE_SELECTED;
    var childVC : OneQuestionVC?;
    var startTestDate:Date?;
    var timeLeftCalculatorTimer: Timer?;
    
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
            
            //            viewController.setQuestion(getDummyQuestion());
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated);
        timeLeftCalculatorTimer?.invalidate();
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
    
    
    private func getDummyQuestion() -> Question {
        //        let softWrappedQuotation = "Morbi consectetur purus rhoncus est vulputate semper. Integer dictum diam vitae metus vulputate gravida. Sed sollicitudin, enim id tempor interdum, orci enim congue dui, in viverra velit magna non felis. Cras sit amet lorem nunc. Integer et lectus et est lobortis aliquet. Class aptent taciti sociosqu ad litora torquent per conubia nostra, per inceptos himenaeos. Nulla et elit elit. Duis non urna ut libero sollicitudin aliquet. Suspendisse bibendum, velit quis laoreet luctus, quam ligula viverra neque, ac tristique eros elit a ligula. Donec a laoreet diam. Vestibulum eget arcu consectetur, suscipit lectus a, convallis magna. Aliquam quis accumsan orci.";
        let softWrappedQuotation = "Pentru executarea navigației în siguranță pe vreme rea vor fi luați în considerare următorii factori:";
        
        //        let answerA = "Aenean a tristique mi. Nam mattis dolor vitae vulputate lobortis. Mauris pharetra turpis vel nulla venenatis tincidunt. Donec fringilla ultrices tellus, finibus fringilla ex elementum eget. Sed scelerisque in lacus et iaculis. Sed ornare ipsum tortor, eget semper ipsum aliquam viverra. Pellentesque a libero volutpat, rutrum mauris ac, aliquet dolor. Aliquam ut purus faucibus, volutpat diam ut, malesuada sem.";
        let answerA = "analiza forței și direcției vântului, a alurilor corecte, în funcție de suprafața velica și comportarea navei.";
        //        let answerB = "Aenean a tristique mi. Nam mattis dolor vitae vulputate lobortis. Mauris pharetra turpis vel nulla venenatis tincidunt. Donec fringilla ultrices tellus, finibus fringilla ex elementum eget. Sed scelerisque in lacus et iaculis. Sed ornare ipsum tortor, eget semper ipsum aliquam viverra. Pellentesque a libero volutpat, rutrum mauris ac, aliquet dolor. Aliquam ut purus faucibus, volutpat diam ut, malesuada sem.";
        let answerB = "verificarea instalațiilor de ancorare și remorcare, pentru utilizarea lor în situații neprevăzute.";
        let answerC = "Aenean a tristique mi. Nam mattis dolor vitae vulputate lobortis. Mauris pharetra turpis vel nulla venenatis tincidunt. Donec fringilla ultrices tellus, finibus fringilla ex elementum eget. Sed scelerisque in lacus et iaculis. Sed ornare ipsum tortor, eget semper ipsum aliquam viverra. Pellentesque a libero volutpat, rutrum mauris ac, aliquet dolor. Aliquam ut purus faucibus, volutpat diam ut, malesuada sem.";
        //        let answerC = "analiza posibilităților de utilizare a mijloacelor colective de salvare în situații neprevăzute.";
        let answerD = "Aenean a tristique mi. Nam mattis dolor vitae vulputate lobortis. Mauris pharetra turpis vel nulla venenatis tincidunt. Donec fringilla ultrices tellus, finibus fringilla ex elementum eget. Sed scelerisque in lacus et iaculis. Sed ornare ipsum tortor, eget semper ipsum aliquam viverra. Pellentesque a libero volutpat, rutrum mauris ac, aliquet dolor. Aliquam ut purus faucibus, volutpat diam ut, malesuada sem.";
        //        let answerD = "analiza condițiilor de navigație pe vreme rea, ținându-se cont de vânt.";
        
        var answers = [Int: String]();
        answers[1] = answerA;
        answers[2] = answerB;
        answers[3] = answerC;
        answers[4] = answerD;
        
        let question = Question(id:1036, name: softWrappedQuotation,category: [],subcategory: 1,image: "",answers: answers,correctAnswerId:  1,hints: []);
        
        return question;
    }
    
}
