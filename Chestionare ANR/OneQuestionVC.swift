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
    
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var questionHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var questionView: UIView!
    @IBOutlet weak var aAnswerView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad();
        
        questionView.layer.cornerRadius = 10;
        aAnswerView.layer.cornerRadius = 10;
    }
    
    
    public func setQuestion(_ question: Question) {
        let font = UIFont(name: "Helvetica", size: 20.0);
        let height = heightForView(text:question.name, font: font!, width: self.view.frame.width - 32) + 16;
        questionLabel.text = question.name;
        questionLabel.font = font;
        questionHeightConstraint.constant = height;
        view.layoutIfNeeded();
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
