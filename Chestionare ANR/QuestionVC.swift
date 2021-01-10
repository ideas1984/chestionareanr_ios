//
//  QuestionVC.swift
//  Chestionare ANR
//
//  Created by Marius Tanasoiu on 12/23/20.
//  Copyright © 2020 NavyMasters. All rights reserved.
//

import UIKit

class QuestionVC: UIViewController, AnswerSelectedDelegate {
    
    struct TestState {
        var questions: [Question];
        var skipped: [Int] = [];
        var currentQuestionIdx = 0;
        var goodAnswers = 0;
        var badAnswers = 0;
    }
    
    
    var testState: TestState?;
    var isCommercialShowed = false;
    var category:Int?;
    
    @IBOutlet weak var containerView: UIView!
    
    @IBOutlet weak var skipButton: UIView!
    @IBOutlet weak var nextButton: UIView!
    @IBOutlet weak var remainingQuestionsLabel: UILabel!
    @IBOutlet weak var goodAnswersLabel: UILabel!
    @IBOutlet weak var badAnswersLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad();
        
        skipButton.layer.cornerRadius = 10;
        nextButton.layer.cornerRadius = 10;
        
        skipButton.addGestureRecognizer(UITapGestureRecognizer(target: self, action:  #selector (skipClicked (_:))));
        nextButton.addGestureRecognizer(UITapGestureRecognizer(target: self, action:  #selector (nextClicked (_:))));
        
        skipButton.isUserInteractionEnabled = false;
        
        
        testState = TestState(questions: XMLUtil.instance.getRandomQuestions(fromCategory: category!));
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated);
        
//        if(!isCommercialShowed) {
//            isCommercialShowed = true;
//            let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main);
//            let vc = storyboard.instantiateViewController(withIdentifier: "commercial_vc") as! CommercialVC;
//            vc.modalPresentationStyle = .fullScreen;
//            present(vc, animated: false, completion: nil);
//        } else {
            let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main);
            let viewController = storyboard.instantiateViewController(withIdentifier: "OneQuestionViewController") as! OneQuestionVC;
            addViewControllerAsChildViewController(childViewController: viewController);
            viewController.ansertSelectedDelegate = self;
            
            view.layoutIfNeeded();//very important here. do not erase this
            
            
            viewController.setQuestion((testState?.questions[testState!.currentQuestionIdx])!);
            
            remainingQuestionsLabel.text = String(testState!.questions.count - testState!.goodAnswers - testState!.badAnswers);
            goodAnswersLabel.text = String(testState!.goodAnswers);
            badAnswersLabel.text = String(testState!.badAnswers);
            
            
//            viewController.setQuestion(getDummyQuestion());
//        }
        
    }
    
    
    func answerSelected(_ answer: OneQuestionVC.AnswerEnum) {
        print("ANSWER=",answer);
    }
    
    
    @IBAction func skipClicked(_ sender: UIView) {
        print("skip");
    }
    
    @IBAction func nextClicked(_ sender: UIView) {
        print("next");
    }
    
    
    @IBAction func backClicked(_ sender: Any) {
        if let nav = self.navigationController {
            nav.popViewController(animated: true)
        } else {
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    private func addViewControllerAsChildViewController(childViewController: UIViewController) {
        addChild(childViewController);
        containerView.addSubview(childViewController.view);
        childViewController.view.frame = containerView.bounds;
        childViewController.view.autoresizingMask = [.flexibleWidth, .flexibleHeight];
        childViewController.didMove(toParent: self);
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
