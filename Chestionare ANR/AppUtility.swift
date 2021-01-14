//
//  AppUtility.swift
//  Chestionare ANR
//
//  Created by Marius Tanasoiu on 12/13/20.
//  Copyright © 2020 NavyMasters. All rights reserved.
//

import UIKit

class AppUtility:NSObject{
    
    struct CategoryInfo {
        let totalQuestions: Int;
        let passScore:Int;
        let time:Int;
    }
    
    static let instance = AppUtility();
    var categoryInfoMap = [Int: CategoryInfo]();
    
    
    private override init() {
        super.init();

        categoryInfoMap[Const.CATEGORY_D] = CategoryInfo(totalQuestions: 26, passScore: 22, time: 3600);
        categoryInfoMap[Const.CATEGORY_DIFERENTA_D] = CategoryInfo(totalQuestions: 10, passScore: 8, time: 1200);
        categoryInfoMap[Const.CATEGORY_C] = CategoryInfo(totalQuestions: 26, passScore: 22, time: 3600);
        categoryInfoMap[Const.CATEGORY_DIFERENTA_C] = CategoryInfo(totalQuestions: 10, passScore: 8, time: 1200);
        
    }
    
    static func lockOrientation(_ orientation: UIInterfaceOrientationMask) {
        
        if let delegate = UIApplication.shared.delegate as? AppDelegate {
            delegate.orientationLock = orientation
        }
    }
    
    // OPTIONAL Added method to adjust lock and rotate to the desired orientation
    static func lockOrientation(_ orientation: UIInterfaceOrientationMask, andRotateTo rotateOrientation:UIInterfaceOrientation) {
        
        self.lockOrientation(orientation)
        
        UIDevice.current.setValue(rotateOrientation.rawValue, forKey: "orientation")
        UINavigationController.attemptRotationToDeviceOrientation()
    }
    
}
