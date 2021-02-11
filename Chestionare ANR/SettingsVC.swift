//
//  SettingsVC.swift
//  Chestionare ANR
//
//  Created by Marius Tanasoiu on 2/6/21.
//  Copyright © 2021 NavyMasters. All rights reserved.
//

import UIKit

class SettingsVC: UIViewController {
    
    @IBOutlet weak var fontButton12: ANRRadioButton!
    @IBOutlet weak var fontButton14: ANRRadioButton!
    @IBOutlet weak var fontButton16: ANRRadioButton!
    @IBOutlet weak var fontButton18: ANRRadioButton!
    
    
    @IBOutlet weak var showAnswerButtonYes: ANRRadioButton!
    @IBOutlet weak var showAnswerButtonNo: ANRRadioButton!
    
    @IBOutlet weak var resetLearningButton: ANRButton!
    @IBOutlet weak var resetAllButton: ANRButton!
    
    override func viewDidLoad() {
        super.viewDidLoad();
        
        updateUI();
        
        fontButton12.addGestureRecognizer(UITapGestureRecognizer(target: self, action:  #selector (changeFontClicked (_:))));
        fontButton14.addGestureRecognizer(UITapGestureRecognizer(target: self, action:  #selector (changeFontClicked (_:))));
        fontButton16.addGestureRecognizer(UITapGestureRecognizer(target: self, action:  #selector (changeFontClicked (_:))));
        fontButton18.addGestureRecognizer(UITapGestureRecognizer(target: self, action:  #selector (changeFontClicked (_:))));
        
        showAnswerButtonYes.addGestureRecognizer(UITapGestureRecognizer(target: self, action:  #selector (changeShowAnswerClicked (_:))));
        showAnswerButtonNo.addGestureRecognizer(UITapGestureRecognizer(target: self, action:  #selector (changeShowAnswerClicked (_:))));
        
        resetLearningButton.addGestureRecognizer(UITapGestureRecognizer(target: self, action:  #selector (resetLearningClicked (_:))));

        resetAllButton.addGestureRecognizer(UITapGestureRecognizer(target: self, action:  #selector (resetAllClicked (_:))));
    }
    
    @IBAction func changeFontClicked(_ sender: UITapGestureRecognizer) {
        
        var size = 16;
        
        if(sender.view! == fontButton12) {
            size = 12;
        } else if(sender.view! == fontButton14) {
            size = 14;
        } else if(sender.view! == fontButton16) {
            size = 16;
        } else if(sender.view! == fontButton18) {
            size = 18;
        }
        
        UserDefaults.standard.setValue(size, forKey: Const.KEY_FONT_SIZE);
        
        updateFontButtons(withFontSize: size);
    }
    
    private func updateFontButtons(withFontSize size: Int) {
        if(size == 12) {
            fontButton12.setChecked(true);
            fontButton14.setChecked(false);
            fontButton16.setChecked(false);
            fontButton18.setChecked(false);
        } else if(size == 14) {
            fontButton12.setChecked(false);
            fontButton14.setChecked(true);
            fontButton16.setChecked(false);
            fontButton18.setChecked(false);
        } else if(size == 16) {
            fontButton12.setChecked(false);
            fontButton14.setChecked(false);
            fontButton16.setChecked(true);
            fontButton18.setChecked(false);
        } else if(size == 18) {
            fontButton12.setChecked(false);
            fontButton14.setChecked(false);
            fontButton16.setChecked(false);
            fontButton18.setChecked(true);
        }
    }
    
    @IBAction func changeShowAnswerClicked(_ sender: UITapGestureRecognizer) {
        if(sender.view! == showAnswerButtonYes) {
            updateShowAnswerButtons(withFlag: true);
            UserDefaults.standard.setValue(true, forKey: Const.KEY_SHOW_CORRECT_ANSWER);
        } else if(sender.view! == showAnswerButtonNo) {
            UserDefaults.standard.setValue(false, forKey: Const.KEY_SHOW_CORRECT_ANSWER);
            updateShowAnswerButtons(withFlag: false);
        }
    }
    
    private func updateShowAnswerButtons(withFlag flag: Bool) {
        if(flag) {
            showAnswerButtonYes.setChecked(true);
            showAnswerButtonNo.setChecked(false);
        } else {
            showAnswerButtonYes.setChecked(false);
            showAnswerButtonNo.setChecked(true);
        }
    }
    
    @IBAction func resetLearningClicked(_ sender: UITapGestureRecognizer) {
        resetLearning();
    }
    
    private func resetLearning() {
        let defaults = UserDefaults.standard;
        
        defaults.setValue(0, forKey: Const.KEY_COVERED_SUBCATEGORY_1);
        defaults.setValue(0, forKey: Const.KEY_COVERED_SUBCATEGORY_2);
        defaults.setValue(0, forKey: Const.KEY_COVERED_SUBCATEGORY_3);
        defaults.setValue(0, forKey: Const.KEY_COVERED_SUBCATEGORY_4);
        defaults.setValue(0, forKey: Const.KEY_COVERED_SUBCATEGORY_5);
        defaults.setValue(0, forKey: Const.KEY_COVERED_SUBCATEGORY_6);
        defaults.setValue(0, forKey: Const.KEY_COVERED_SUBCATEGORY_7);
    }
    
    @IBAction func resetAllClicked(_ sender: UITapGestureRecognizer) {
        resetLearning();
        let defaults = UserDefaults.standard;
        defaults.setValue(16, forKey: Const.KEY_FONT_SIZE);
        defaults.setValue(true, forKey: Const.KEY_SHOW_CORRECT_ANSWER);
        
        CoreDataManager.shared.resetCoreData();
        
        updateUI();
    }
    
    private func updateUI() {
        updateFontButtons(withFontSize: UserDefaults.standard.integer(forKey: Const.KEY_FONT_SIZE));
        updateShowAnswerButtons(withFlag: UserDefaults.standard.bool(forKey: Const.KEY_SHOW_CORRECT_ANSWER));
    }

    
    
}
