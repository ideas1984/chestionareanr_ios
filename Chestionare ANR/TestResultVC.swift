//
//  TestResult.swift
//  Chestionare ANR
//
//  Created by Marius Tanasoiu on 1/15/21.
//  Copyright © 2021 NavyMasters. All rights reserved.
//

import UIKit

class TestResultVC: UIViewController {
    
    var testResult: TestResult?;
    var goodAnswers: Int?;
    
    @IBOutlet weak var testResultlabel: UILabel!
    @IBOutlet weak var goodAnswersLabel: UILabel!
    @IBOutlet weak var buttonLabel: UILabel!
    @IBOutlet weak var eventButton: UIView!
    @IBOutlet weak var eventButtonLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if(testResult == TestResult.PASS) {
            testResultlabel.text = "ADMIS";
            testResultlabel.textColor = UIColor.green;
            goodAnswersLabel.text = "Raspunsuri corecte: \(goodAnswers!)";
            buttonLabel.text = "Dacă sunteți de părere că această aplicație vă este de ajutor, va rugăm să ne apreciați efortul cu un review de 5 stele. Mulțumim!";
            eventButtonLabel.text = "Apreciază aplicația";
            eventButton.addGestureRecognizer(UITapGestureRecognizer(target: self, action:  #selector (createReview (_:))));
        } else {
            testResultlabel.text = "RESPINS";
            testResultlabel.textColor = UIColor.red;
            if(testResult == TestResult.FAIL_NO_NECCESARY_ANSWERS) {
                goodAnswersLabel.text = "Nu ai reușit să te încadrezi în barem";
            } else { //TestResult.FAIL_TIME_EXPIRED
                goodAnswersLabel.text = "Timpul a expirat";
            }
            buttonLabel.text = "Întrebările greșite pot fi revizuite în secțiunea Istoric și Rapoarte";
            eventButtonLabel.text = "Vezi întrebările greșite";
            eventButton.addGestureRecognizer(UITapGestureRecognizer(target: self, action:  #selector (viewWrongAnswers (_:))));
        }
    }
    
    @IBAction func createReview(_ sender: UIView) {
        print("createReview");
    }
    
    @IBAction func viewWrongAnswers(_ sender: UIView) {
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main);
        let reviewBadAnswersVC = storyboard.instantiateViewController(withIdentifier: "review_bad_answers_vc") as! ReviewBadAnswersVC;
        reviewBadAnswersVC.modalPresentationStyle = .fullScreen;
        present(reviewBadAnswersVC, animated: false, completion: nil);
    }

}
