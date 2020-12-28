//
//  OneQuestionVC.swift
//  Chestionare ANR
//
//  Created by Marius Tanasoiu on 12/26/20.
//  Copyright © 2020 NavyMasters. All rights reserved.
//

import UIKit

class OneQuestionVC: UIViewController {
    
//    var mainController: MainViewController!
    
    @IBOutlet weak var questionView: UIView!
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var questionHeightConstraint: NSLayoutConstraint!
    
    
    @IBOutlet weak var aAnswerView: UIView!
    @IBOutlet weak var aAnswerLabel: UILabel!
    @IBOutlet weak var aAnswerHeightConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var bAnswerView: UIView!
    @IBOutlet weak var bAnswerLabel: UILabel!
    @IBOutlet weak var bAnswerHeightConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var cAnswerView: UIView!
    @IBOutlet weak var cAnswerLabel: UILabel!
    @IBOutlet weak var cAnswerHeightConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var dAnswerView: UIView!
    @IBOutlet weak var dAnswerLabel: UILabel!
    @IBOutlet weak var dAnswerHeightConstraint: NSLayoutConstraint!
    
    
    @IBOutlet weak var c1: NSLayoutConstraint!
    @IBOutlet weak var c2: NSLayoutConstraint!
    @IBOutlet weak var c3: NSLayoutConstraint!
    @IBOutlet weak var c4: NSLayoutConstraint!
    @IBOutlet weak var c5: NSLayoutConstraint!
    @IBOutlet weak var c6: NSLayoutConstraint!
    @IBOutlet weak var c7: NSLayoutConstraint!
    
    
    override func viewDidLoad() {
        super.viewDidLoad();
        
        questionView.layer.cornerRadius = 10;
        aAnswerView.layer.cornerRadius = 10;
        bAnswerView.layer.cornerRadius = 10;
        cAnswerView.layer.cornerRadius = 10;
        dAnswerView.layer.cornerRadius = 10;
        
        
        aAnswerView.addGestureRecognizer(UITapGestureRecognizer(target: self, action:  #selector (answerAClicked (_:))));
        bAnswerView.addGestureRecognizer(UITapGestureRecognizer(target: self, action:  #selector (answerBClicked (_:))));
        cAnswerView.addGestureRecognizer(UITapGestureRecognizer(target: self, action:  #selector (answerCClicked (_:))));
        dAnswerView.addGestureRecognizer(UITapGestureRecognizer(target: self, action:  #selector (answerDClicked (_:))));
    }
    
    
    public func setQuestion(_ question: Question) {
        let font = UIFont(name: "Helvetica", size: 20.0);
        
        questionHeightConstraint.constant = heightForView(text:question.name, font: font!, width: self.view.frame.width - 32) + 16;
        questionLabel.text = question.name;
        questionLabel.font = font;
        
        aAnswerHeightConstraint.constant = heightForView(text:question.answers[1]!, font: font!, width: self.view.frame.width - 79) + 16;
        aAnswerLabel.text = question.answers[1];
        aAnswerLabel.font = font;
        
        bAnswerHeightConstraint.constant = heightForView(text:question.answers[2]!, font: font!, width: self.view.frame.width - 79) + 16;
        bAnswerLabel.text = question.answers[2];
        bAnswerLabel.font = font;

        cAnswerHeightConstraint.constant = heightForView(text:question.answers[3]!, font: font!, width: self.view.frame.width - 79) + 16;
        cAnswerLabel.text = question.answers[3];
        cAnswerLabel.font = font;

        if(question.answers[4] != nil) {
            dAnswerHeightConstraint.constant = heightForView(text:question.answers[4]!, font: font!, width: self.view.frame.width - 79) + 16;
            dAnswerLabel.text = question.answers[4];
            dAnswerLabel.font = font;
        } else {
            dAnswerHeightConstraint.constant = 0;
            c1.constant = 0;
            c2.constant = 0;
            c3.constant = 0;
            c4.constant = 0;
            c5.constant = 0;
            c6.constant = 0;
            c7.constant = 0;
        }

        
        
        view.layoutIfNeeded();
    }
    
    @IBAction func answerAClicked(_ sender: UIView) {
        print("AAA");
    }
    
    @IBAction func answerBClicked(_ sender: UIView) {
        print("BBB");
    }
    
    @IBAction func answerCClicked(_ sender: UIView) {
        print("CCC");
    }
    
    @IBAction func answerDClicked(_ sender: UIView) {
        print("DDD");
    }
    

    func heightForView(text:String, font:UIFont, width:CGFloat) -> CGFloat{
        let label:UILabel = UILabel(frame: CGRect(x:0, y:0, width:width, height:CGFloat.greatestFiniteMagnitude));
        label.numberOfLines = 0;
        label.lineBreakMode = NSLineBreakMode.byWordWrapping;
        label.font = font;
        label.text = text;

        label.sizeToFit();
        return label.frame.height;
    }

    @IBAction func categorySelected(_ sender: UITapGestureRecognizer) {
        
//        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main);
//        let pdfVC = storyboard.instantiateViewController(withIdentifier: "PDFViewerVC") as! PDFViewerVC;
//        pdfVC.modalPresentationStyle = .fullScreen;
//        mainController.present(pdfVC, animated: true, completion: nil);
//
//        switch sender.view?.accessibilityIdentifier?.description {
//            case "but_nav_dunare":
//                print("but_nav_dunare");
//            case "but_marinarie_1":
//                print("but_marinarie_1");
//            case "but_conducerea_manevrarea_1":
//                print("but_conducerea_manevrarea_1");
//            case "but_colreg":
//                print("but_colreg");
//            case "but_mavigatie_maritima":
//                print("but_mavigatie_maritima");
//            case "but_marinarie_2":
//                print("but_marinarie_2");
//            case "but_conducerea_manevrarea_2":
//                print("but conducerea si manevrarea 2");
//            default:
//                print("default");
//        }

    }
    
//    @IBAction func menuClicked(_ sender: CustomButton) {
//        mainController.mainMenuClicked(sender.accessibilityIdentifier!)
//    }
//
//    public func setMainController(_ mainController: MainViewController) {
//        self.mainController = mainController;
//    }
    


}
