//
//  CommercialVC.swift
//  Chestionare ANR
//
//  Created by Marius Tanasoiu on 12/19/20.
//  Copyright © 2020 NavyMasters. All rights reserved.
//

import UIKit

class CommercialVC: UIViewController {
    @IBOutlet weak var polymorphicView: UIView!
    @IBOutlet weak var commercialImageView: UIImageView!
    
    var timeLabel1: UILabel?;
    var timeLeftCalculatorTimer: Timer?;
    var secondsToWait = 3;
    
    override func viewDidLoad() {
        super.viewDidLoad();
        
        timeLabel1 = UILabel();
        timeLabel1?.text = "\(secondsToWait)";
        timeLabel1?.textAlignment = .center;
        timeLabel1?.font = UIFont.systemFont(ofSize: 26);
        timeLabel1?.textColor = UIColor(named: "text_color");
        setView(timeLabel1!);
        
        let imageName =  "reclama_mare_0\(Int.random(in: 1..<4))";
        commercialImageView.image =  UIImage(named: imageName);
        
        commercialImageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(openCommercialWebsite)));
        commercialImageView.isUserInteractionEnabled = true;
        commercialImageView.contentMode = UIView.ContentMode.scaleToFill;
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated);
        
        if(secondsToWait > 0 ) {
            timeLabel1?.text = "\(secondsToWait)";
            timeLeftCalculatorTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateTimeLeft), userInfo: nil, repeats: true);
        }
    }
    
    @objc func openCommercialWebsite() {
        AppUtility.navigateTo(url: "https://www.navymasters.ro");
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated);
        timeLeftCalculatorTimer?.invalidate();
    }
    
    @IBAction func closeClicked(_ sender: UIView) {
        if let nav = self.navigationController {
            nav.popViewController(animated: true);
        } else {
            self.dismiss(animated: true, completion: nil);
        }
    }
    
    @objc func updateTimeLeft() {
        secondsToWait -= 1;
        
        if(secondsToWait == 0) {
            timeLeftCalculatorTimer?.invalidate();
        
            timeLabel1?.removeFromSuperview();
            
            let closeButton = UIButton();
            closeButton.setImage(UIImage(named: "close"), for: .normal);
            closeButton.addGestureRecognizer(UITapGestureRecognizer(target: self, action:  #selector (closeClicked (_:))));
            
            setView(closeButton);
        } else {
            timeLabel1?.text = "\(secondsToWait)";
        }
    }
    
    private func setView(_ view: UIView) {
        polymorphicView.addSubview(view);
        
        view.translatesAutoresizingMaskIntoConstraints = false;
        
        view.leadingAnchor.constraint(equalTo: polymorphicView.leadingAnchor, constant: 0).isActive = true;
        view.trailingAnchor.constraint(equalTo: polymorphicView.trailingAnchor, constant: 0).isActive = true;
        view.bottomAnchor.constraint(equalTo: polymorphicView.bottomAnchor, constant: 0).isActive = true;
        view.topAnchor.constraint(equalTo: polymorphicView.topAnchor, constant: 0).isActive = true;
    }
    
}
