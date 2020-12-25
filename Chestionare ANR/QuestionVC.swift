//
//  QuestionVC.swift
//  Chestionare ANR
//
//  Created by Marius Tanasoiu on 12/23/20.
//  Copyright © 2020 NavyMasters. All rights reserved.
//

import UIKit

class QuestionVC: UIViewController {
    
    var isCommercialShowed = false;
    var category:String?;
    
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var questionHeightConstraint: NSLayoutConstraint!;
    
    
    override func viewDidLoad() {
        super.viewDidLoad();
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated);
        
        let softWrappedQuotation = "The White Rabbit put on his spectacles.  Where shall I begin, please your Majesty? he asked.Begin at the eginning, the King said gravely, and go on till you come to the end; then stop. asd asd si mai adaug eu ceva aici sa vedem ce o sa iasa . ideea e ssa fie o chesti emare The White Rabbit put on his spectacles.  Where shall I begin, please your Majesty? he asked.Begin at the eginning, the King said gravely, and go on till you come to the end; then stop. asd asd si mai adaug eu ceva aici sa vedem ce o sa iasa . ideea e ssa fie o chesti emare The White Rabbit put on his spectacles.  Where shall I begin, please your Majesty? he asked.Begin at the eginning, the King said gravely, and go on till you come to the end; then stop. asd asd si mai adaug eu ceva aici sa vedem ce o sa iasa . ideea e ssa fie o chesti emare The White Rabbit put on his spectacles.  Where shall I begin, please your Majesty? he asked.Begin at the eginning, the King said gravely, and go on till you come to the end; then stop. asd asd si mai adaug eu ceva aici sa vedem ce o sa iasa . ideea e ssa fie o chesti emare";
        
        
        let font = UIFont(name: "Helvetica", size: 20.0);
        let height = heightForView(text:softWrappedQuotation, font: font!, width: self.view.frame.width);
        label.text = softWrappedQuotation;
        label.font = font;
        questionHeightConstraint.constant = height;
//        label.layoutIfNeeded();
        
        
        
        
//        if(!isCommercialShowed) {
//            isCommercialShowed = true;
//            let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main);
//            let vc = storyboard.instantiateViewController(withIdentifier: "commercial_vc") as! CommercialVC;
//            vc.modalPresentationStyle = .fullScreen;
//            present(vc, animated: false, completion: nil);
//        } else {
//            switch category {
//                case "categoria_d":
//                    break;
//                case "categoria_diferenta_d":
//                    break;
//            case "categoria_c":
//                break;
//            case "categoria_diferenta_c":
//                break;
//                default:
//                    print("default");
//            }
//        }
        
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

    
    @IBAction func backClicked(_ sender: Any) {
        if let nav = self.navigationController {
                    nav.popViewController(animated: true)
                } else {
                    self.dismiss(animated: true, completion: nil)
                }
    }
    
}
