//
//  OneQuestionVC.swift
//  Chestionare ANR
//
//  Created by Marius Tanasoiu on 12/26/20.
//  Copyright © 2020 NavyMasters. All rights reserved.
//

import UIKit

class OneQuestionVC: UIViewController {
    
    weak var ansertSelectedDelegate: AnswerSelectedProtocol?;
    var selectedAnswer:AnswerEnum = AnswerEnum.NONE_SELECTED;
    
    @IBOutlet weak var questionView: UIView!
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var questionHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var questionNumberLabel: UILabel!
    
    
    @IBOutlet weak var aAnswerView: AnswerButton!
    @IBOutlet weak var aAnswerLabel: UILabel!
    @IBOutlet weak var aAnswerHeightConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var bAnswerView: AnswerButton!
    @IBOutlet weak var bAnswerLabel: UILabel!
    @IBOutlet weak var bAnswerHeightConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var cAnswerView: AnswerButton!
    @IBOutlet weak var cAnswerLabel: UILabel!
    @IBOutlet weak var cAnswerHeightConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var dAnswerView: AnswerButton!
    @IBOutlet weak var dAnswerLabel: UILabel!
    @IBOutlet weak var dAnswerHeightConstraint: NSLayoutConstraint!
    
    
    @IBOutlet weak var c1: NSLayoutConstraint!
    @IBOutlet weak var c2: NSLayoutConstraint!
    @IBOutlet weak var c3: NSLayoutConstraint!
    @IBOutlet weak var c4: NSLayoutConstraint!
    @IBOutlet weak var c5: NSLayoutConstraint!
    @IBOutlet weak var c6: NSLayoutConstraint!
    @IBOutlet weak var c7: NSLayoutConstraint!
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var imageViewHeightConstraint: NSLayoutConstraint!
    
    public enum AnswerEnum : Int {
        case A_SELECTED = 1, B_SELECTED = 2, C_SELECTED = 3, D_SELECTED = 4, NONE_SELECTED = -1
    }
    
    override func viewDidLoad() {
        super.viewDidLoad();
        
        questionView.layer.shadowColor = UIColor.black.cgColor;
        questionView.layer.shadowRadius = 4;
        questionView.layer.shadowOpacity = 0.6;
        questionView.layer.shadowOffset = CGSize(width: 0, height: 0);
        
        aAnswerView.addGestureRecognizer(UITapGestureRecognizer(target: self, action:  #selector (answerAClicked (_:))));
        bAnswerView.addGestureRecognizer(UITapGestureRecognizer(target: self, action:  #selector (answerBClicked (_:))));
        cAnswerView.addGestureRecognizer(UITapGestureRecognizer(target: self, action:  #selector (answerCClicked (_:))));
        dAnswerView.addGestureRecognizer(UITapGestureRecognizer(target: self, action:  #selector (answerDClicked (_:))));
    }
    
    
    public func setQuestion(_ question: Question, andNumber questionNumber: Int) {
        
        let fontSize = UserDefaults.standard.integer(forKey: Const.KEY_FONT_SIZE);
        
        let qFont = UIFont(name: "Helvetica", size: CGFloat(fontSize + 4));
        
        questionHeightConstraint.constant = heightForView(text:question.name, font: qFont!, width: self.view.frame.width - 79) + 16;
        questionLabel.text = question.name;
        questionLabel.font = qFont;
        questionNumberLabel.text = String(questionNumber);
        
        
        if let filePath = Bundle.main.path(forResource: "image" + String(question.id), ofType: "png"), let image = UIImage(contentsOfFile: filePath) {
            imageViewHeightConstraint.constant = 150;
            imageView.contentMode = .scaleAspectFit;
            imageView.image = image;
        } else {
            imageViewHeightConstraint.constant = 0;
        }
        
        
        let aFont = UIFont(name: "Helvetica", size: CGFloat(fontSize));
        
        aAnswerHeightConstraint.constant = heightForView(text:question.answers[1]!, font: aFont!, width: self.view.frame.width - 79) + 16;
        aAnswerLabel.text = question.answers[1];
        aAnswerLabel.font = aFont;
        
        bAnswerHeightConstraint.constant = heightForView(text:question.answers[2]!, font: aFont!, width: self.view.frame.width - 79) + 16;
        bAnswerLabel.text = question.answers[2];
        bAnswerLabel.font = aFont;
        
        cAnswerHeightConstraint.constant = heightForView(text:question.answers[3]!, font: aFont!, width: self.view.frame.width - 79) + 16;
        cAnswerLabel.text = question.answers[3];
        cAnswerLabel.font = aFont;
        
        if(question.answers[4] != nil) {
            dAnswerHeightConstraint.constant = heightForView(text:question.answers[4]!, font: aFont!, width: self.view.frame.width - 79) + 16;
            dAnswerLabel.text = question.answers[4];
            dAnswerLabel.font = aFont;
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
        if(selectedAnswer != AnswerEnum.A_SELECTED) {
            selectedAnswer = AnswerEnum.A_SELECTED;
        } else {
            selectedAnswer = AnswerEnum.NONE_SELECTED;
        }
        ansertSelectedDelegate?.answerSelected(selectedAnswer);
        updateUI(selectedAnswer);
    }
    
    @IBAction func answerBClicked(_ sender: UIView) {
        if(selectedAnswer != AnswerEnum.B_SELECTED) {
            selectedAnswer = AnswerEnum.B_SELECTED;
        } else {
            selectedAnswer = AnswerEnum.NONE_SELECTED;
        }
        ansertSelectedDelegate?.answerSelected(selectedAnswer);
        updateUI(selectedAnswer);
    }
    
    @IBAction func answerCClicked(_ sender: UIView) {
        if(selectedAnswer != AnswerEnum.C_SELECTED) {
            selectedAnswer = AnswerEnum.C_SELECTED;
        } else {
            selectedAnswer = AnswerEnum.NONE_SELECTED;
        }
        ansertSelectedDelegate?.answerSelected(selectedAnswer);
        updateUI(selectedAnswer);
    }
    
    @IBAction func answerDClicked(_ sender: UIView) {
        if(selectedAnswer != AnswerEnum.D_SELECTED) {
            selectedAnswer = AnswerEnum.D_SELECTED;
        } else {
            selectedAnswer = AnswerEnum.NONE_SELECTED;
        }
        ansertSelectedDelegate?.answerSelected(selectedAnswer);
        updateUI(selectedAnswer);
    }
    
    func updateUI(_ selectedAnswer: OneQuestionVC.AnswerEnum) {
        switch selectedAnswer {
        case .A_SELECTED:
            aAnswerView.setState(AnswerButton.ButtonState.SELECTED);
            bAnswerView.setState(AnswerButton.ButtonState.DEFAULT);
            cAnswerView.setState(AnswerButton.ButtonState.DEFAULT);
            dAnswerView.setState(AnswerButton.ButtonState.DEFAULT);
            break;
        case .B_SELECTED:
            aAnswerView.setState(AnswerButton.ButtonState.DEFAULT);
            bAnswerView.setState(AnswerButton.ButtonState.SELECTED);
            cAnswerView.setState(AnswerButton.ButtonState.DEFAULT);
            dAnswerView.setState(AnswerButton.ButtonState.DEFAULT);
            break;
        case .C_SELECTED:
            aAnswerView.setState(AnswerButton.ButtonState.DEFAULT);
            bAnswerView.setState(AnswerButton.ButtonState.DEFAULT);
            cAnswerView.setState(AnswerButton.ButtonState.SELECTED);
            dAnswerView.setState(AnswerButton.ButtonState.DEFAULT);
            break;
        case .D_SELECTED:
            aAnswerView.setState(AnswerButton.ButtonState.DEFAULT);
            bAnswerView.setState(AnswerButton.ButtonState.DEFAULT);
            cAnswerView.setState(AnswerButton.ButtonState.DEFAULT);
            dAnswerView.setState(AnswerButton.ButtonState.SELECTED);
            break;
        case .NONE_SELECTED:
            aAnswerView.setState(AnswerButton.ButtonState.DEFAULT);
            bAnswerView.setState(AnswerButton.ButtonState.DEFAULT);
            cAnswerView.setState(AnswerButton.ButtonState.DEFAULT);
            dAnswerView.setState(AnswerButton.ButtonState.DEFAULT);
        }
    }
    
    
    func heightForView(text:String, font:UIFont, width:CGFloat) -> CGFloat {
        let label:UILabel = UILabel(frame: CGRect(x:0, y:0, width:width, height:CGFloat.greatestFiniteMagnitude));
        label.numberOfLines = 0;
        label.lineBreakMode = NSLineBreakMode.byWordWrapping;
        label.font = font;
        label.text = text;
        
        label.sizeToFit();
        return label.frame.height;
    }
    
    // only used for Exam
    public func display(correctAnswer goodAnswerID: Int, andWrongAnswer wrongAnswerID: Int) {
        getAnswerButton(ofID: wrongAnswerID)?.setState(AnswerButton.ButtonState.WRONG_ANSWER);
        
        let correctAnswerButton = getAnswerButton(ofID: goodAnswerID);
        correctAnswerButton?.setState(AnswerButton.ButtonState.CORRECT_ANSWER);
        
        UIView.animate(withDuration: 0.5,
                       delay: 0,
                       options: [UIView.AnimationOptions.autoreverse, UIView.AnimationOptions.repeat],
                       animations: {
                        correctAnswerButton?.setState(AnswerButton.ButtonState.DEFAULT);
                       },
                       completion: nil);
        
        
        aAnswerView.isUserInteractionEnabled = false;
        bAnswerView.isUserInteractionEnabled = false;
        cAnswerView.isUserInteractionEnabled = false;
        dAnswerView.isUserInteractionEnabled = false;
    }
    
    // only for learning and review questions
    public func display(correctAnswer goodAnswerID: Int, andWrongAnswer wrongAnswerID: Int, _ disable: Bool) {
        getAnswerButton(ofID: wrongAnswerID)?.setState(AnswerButton.ButtonState.WRONG_ANSWER);
        getAnswerButton(ofID: goodAnswerID)?.setState(AnswerButton.ButtonState.CORRECT_ANSWER);
        
        if(disable) {
            aAnswerView.isUserInteractionEnabled = false;
            bAnswerView.isUserInteractionEnabled = false;
            cAnswerView.isUserInteractionEnabled = false;
            dAnswerView.isUserInteractionEnabled = false;
        }
    }
    
    private func getAnswerButton(ofID answerID: Int) -> AnswerButton? {
        if(AnswerEnum.A_SELECTED.rawValue == answerID) {
            return aAnswerView;
        } else if(AnswerEnum.B_SELECTED.rawValue == answerID) {
            return bAnswerView;
        } else if(AnswerEnum.C_SELECTED.rawValue == answerID) {
            return cAnswerView;
        } else if(AnswerEnum.D_SELECTED.rawValue == answerID) {
            return dAnswerView;
        }
        
        return nil;
    }
    
}
