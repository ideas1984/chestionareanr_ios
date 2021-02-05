//
//  HistoryAndReportsVC.swift
//  Chestionare ANR
//
//  Created by Marius Tanasoiu on 2/5/21.
//  Copyright © 2021 NavyMasters. All rights reserved.
//

import UIKit

class HistoryAndReportsVC: UIViewController {
    
    @IBOutlet weak var percentageAllLabel: UILabel!
    @IBOutlet weak var passedAllLabel: UILabel!
    @IBOutlet weak var failedAllLabel: UILabel!
    @IBOutlet weak var totalAllLabel: UILabel!
    
    @IBOutlet weak var percentage10Label: UILabel!
    @IBOutlet weak var passed10label: UILabel!
    @IBOutlet weak var failed10Label: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad();

        let testResultsList = CoreDataManager.shared.loadTestResults();
        
        let allCount = testResultsList.count;
        let allGood = testResultsList.filter { result in
            return result.result == TestResult.PASS.rawValue;
        }.count;
        
        print(Double(100*allGood)/Double(allCount));
        
        let allPercentage:Double = Double(100*allGood)/Double(allCount);
        
        if(allCount == 0) {
            percentageAllLabel.text = "0%";
        } else {
            percentageAllLabel.text = "\(String(format: "%.0f", allPercentage))%";
        }
        
        passedAllLabel.text = "\(allGood)";
        failedAllLabel.text = "\(allCount - allGood)";
        totalAllLabel.text = "\(allCount)";
        
    
        let last10TestResultsList = Array(testResultsList.suffix(10));
        
        let last10Count = last10TestResultsList.count;
        let last10Good = last10TestResultsList.filter { result in
            return result.result == TestResult.PASS.rawValue;
        }.count;
        let last10Percentage:Double = Double(100*last10Good)/Double(last10Count);
        
        if(last10Count == 0) {
            percentage10Label.text = "0%";
        } else {
            percentage10Label.text = "\(String(format: "%.0f", last10Percentage))%";
        }
        passed10label.text = "\(last10Good)";
        failed10Label.text = "\(last10Count - last10Good)";
    }
    
    
    @IBAction func showWrongAnswers(_ sender: UITapGestureRecognizer) {
    }
    
    
}
