//
//  XMLReader.swift
//  Chestionare ANR
//
//  Created by Marius Tanasoiu on 10/15/20.
//  Copyright © 2020 NavyMasters. All rights reserved.
//

import Foundation

class XMLUtil : NSObject, XMLParserDelegate {
    
    static let instance = XMLUtil();

    var questionsDict = [Int: Question]();
    
    var regulamentNavigatieDQuestions: [Question] = [];
    var marinarieDQuestions: [Question] = [];
    var conducereaSiManevrareaDQuestions: [Question] = [];
    var colregCQuestions: [Question] = [];
    var navigatieMaritimaCQuestions: [Question] = [];
    var marinarieCQuestions: [Question] = [];
    var conducereaSiManevrareaCQuestions: [Question] = [];
    
    var hints = [Int:Hint]();
    
    private override init() {
        super.init();
        
        let questionParser = QuestionsParser();
        
        questionsDict = questionParser.questionsDict;
        regulamentNavigatieDQuestions = questionParser.regulamentNavigatieDQuestions;
        marinarieDQuestions = questionParser.marinarieDQuestions;
        conducereaSiManevrareaDQuestions = questionParser.conducereaSiManevrareaDQuestions;
        colregCQuestions = questionParser.colregCQuestions;
        navigatieMaritimaCQuestions = questionParser.navigatieMaritimaCQuestions;
        marinarieCQuestions = questionParser.marinarieCQuestions;
        conducereaSiManevrareaCQuestions = questionParser.conducereaSiManevrareaCQuestions;
        
        hints = HintsParser().hints;
//        print(hints);
    }
    
    func getRandomQuestions(fromCategory category: Int) -> [Question] {
        var randomQuestions: [Question] = [];
        
        switch category {
        case Const.CATEGORY_D:
            randomQuestions.append(contentsOf: getRandomQuestions(fromSubCategoryQuestions: regulamentNavigatieDQuestions, 10));
            randomQuestions.append(contentsOf: getRandomQuestions(fromSubCategoryQuestions: marinarieDQuestions, 8));
            randomQuestions.append(contentsOf: getRandomQuestions(fromSubCategoryQuestions: conducereaSiManevrareaDQuestions, 8));
            break;
        case Const.CATEGORY_DIFERENTA_D:
            randomQuestions.append(contentsOf: getRandomQuestions(fromSubCategoryQuestions: regulamentNavigatieDQuestions, 10));
            break;
        case Const.CATEGORY_C:
            randomQuestions.append(contentsOf: getRandomQuestions(fromSubCategoryQuestions: colregCQuestions, 8));
            randomQuestions.append(contentsOf: getRandomQuestions(fromSubCategoryQuestions: navigatieMaritimaCQuestions, 6));
            randomQuestions.append(contentsOf: getRandomQuestions(fromSubCategoryQuestions: marinarieCQuestions, 6));
            randomQuestions.append(contentsOf: getRandomQuestions(fromSubCategoryQuestions: conducereaSiManevrareaCQuestions, 6));
            break;
        case Const.CATEGORY_DIFERENTA_C:
            randomQuestions.append(contentsOf: getRandomQuestions(fromSubCategoryQuestions: colregCQuestions, 10));
            break;
        default:
            print();
        }
        
        return randomQuestions;
    }
    
    private func getRandomQuestions(fromSubCategoryQuestions subCategoryQuestions: [Question], _ needed: Int) -> [Question] {
        var randomQuestions: [Question] = [];
        var existingIndexes: [Int] = [];
        
        while(randomQuestions.count < needed) {
            let idx = Int.random(in: 0..<subCategoryQuestions.count);
            
            if(existingIndexes.contains(idx)) {
                continue;
            } else {
                existingIndexes.append(idx);
                randomQuestions.append(subCategoryQuestions[idx]);
            }
        }
        
        return randomQuestions;
    }
    
    public func getQuestions(fromSubcategory subcategory: Int) -> [Question] {
        if(Const.SUBCATEGORY_REGULAMENT_NAVIGATIE_D == subcategory) {
            return regulamentNavigatieDQuestions;
        } else if(Const.SUBCATEGORY_MARINARIE_D == subcategory) {
            return marinarieDQuestions;
        } else if(Const.SUBCATEGORY_CONDUCEREA_SI_MANEVRAREA_D == subcategory) {
            return conducereaSiManevrareaDQuestions;
        } else if(Const.SUBCATEGORY_COLREG_C == subcategory) {
            return colregCQuestions;
        } else if(Const.SUBCATEGORY_NAVIGATIE_MARITIMA_C == subcategory) {
            return navigatieMaritimaCQuestions;
        } else if(Const.SUBCATEGORY_MARINARIE_C == subcategory) {
            return marinarieCQuestions;
        } else if(Const.SUBCATEGORY_CONDUCEREA_SI_MANEVRAREA_C == subcategory) {
            return conducereaSiManevrareaCQuestions;
        }
        
        return [];
    }
    
    public func getQuestion(withID questionID: Int) -> Question {
        return questionsDict[questionID]!;
    }
    
}

