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
    @IBOutlet weak var containerView: UIView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad();
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated);
        
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main);
        let viewController = storyboard.instantiateViewController(withIdentifier: "OneQuestionViewController") as! OneQuestionVC;
        addViewControllerAsChildViewController(childViewController: viewController);
        
        view.layoutIfNeeded();//very important here. do not erase this
        
        
        
        let softWrappedQuotation = "Morbi consectetur purus rhoncus est vulputate semper. Integer dictum diam vitae metus vulputate gravida. Sed sollicitudin, enim id tempor interdum, orci enim congue dui, in viverra velit magna non felis. Cras sit amet lorem nunc. Integer et lectus et est lobortis aliquet. Class aptent taciti sociosqu ad litora torquent per conubia nostra, per inceptos himenaeos. Nulla et elit elit. Duis non urna ut libero sollicitudin aliquet. Suspendisse bibendum, velit quis laoreet luctus, quam ligula viverra neque, ac tristique eros elit a ligula. Donec a laoreet diam. Vestibulum eget arcu consectetur, suscipit lectus a, convallis magna. Aliquam quis accumsan orci.";
        
//        let softWrappedQuotation = "Morbi consectetur purus?";
        
        let question = Question(id:1, name: softWrappedQuotation,category: [],subcategory: 1,image: "",answers: [Int: String](),correctAnswerId:  1,hints: []);
        
        viewController.setQuestion(question);

        
        
        
        
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
    
}
