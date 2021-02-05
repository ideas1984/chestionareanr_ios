//
//  Const.swift
//  Chestionare ANR
//
//  Created by Marius Tanasoiu on 1/9/21.
//  Copyright © 2021 NavyMasters. All rights reserved.
//

import UIKit

struct Const {
    static let CATEGORY_D: Int = 1;
    static let CATEGORY_DIFERENTA_D: Int = 2;
    static let CATEGORY_C: Int = 3;
    static let CATEGORY_DIFERENTA_C: Int = 4;
    
    static let SUBCATEGORY_REGULAMENT_NAVIGATIE_D: Int = 1;
    static let SUBCATEGORY_MARINARIE_D: Int = 2;
    static let SUBCATEGORY_CONDUCEREA_SI_MANEVRAREA_D: Int = 3;
    static let SUBCATEGORY_COLREG_C: Int = 4;
    static let SUBCATEGORY_NAVIGATIE_MARITIMA_C: Int = 5;
    static let SUBCATEGORY_MARINARIE_C: Int = 6;
    static let SUBCATEGORY_CONDUCEREA_SI_MANEVRAREA_C: Int = 7;
    
    
    static let KEY_COVERED_SUBCATEGORY_1: String = "covered_subcategory_1";
    static let KEY_COVERED_SUBCATEGORY_2: String = "covered_subcategory_2";
    static let KEY_COVERED_SUBCATEGORY_3: String = "covered_subcategory_3";
    static let KEY_COVERED_SUBCATEGORY_4: String = "covered_subcategory_4";
    static let KEY_COVERED_SUBCATEGORY_5: String = "covered_subcategory_5";
    static let KEY_COVERED_SUBCATEGORY_6: String = "covered_subcategory_6";
    static let KEY_COVERED_SUBCATEGORY_7: String = "covered_subcategory_7";
    
    public static func getKey(forSubcategory subcategory: Int) -> String {
        if(SUBCATEGORY_REGULAMENT_NAVIGATIE_D == subcategory) {
            return KEY_COVERED_SUBCATEGORY_1;
        } else if(SUBCATEGORY_MARINARIE_D == subcategory) {
            return KEY_COVERED_SUBCATEGORY_2;
        } else if(SUBCATEGORY_CONDUCEREA_SI_MANEVRAREA_D == subcategory) {
            return KEY_COVERED_SUBCATEGORY_3;
        } else if(SUBCATEGORY_COLREG_C == subcategory) {
            return KEY_COVERED_SUBCATEGORY_4;
        } else if(SUBCATEGORY_NAVIGATIE_MARITIMA_C == subcategory) {
            return KEY_COVERED_SUBCATEGORY_5;
        } else if(SUBCATEGORY_MARINARIE_C == subcategory) {
            return KEY_COVERED_SUBCATEGORY_6;
        } else if(SUBCATEGORY_CONDUCEREA_SI_MANEVRAREA_C == subcategory) {
            return KEY_COVERED_SUBCATEGORY_7;
        }
        return "none";
    }
    
}
