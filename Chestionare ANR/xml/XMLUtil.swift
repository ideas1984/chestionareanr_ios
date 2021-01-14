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
    
    //    var books: [Book] = [];
    var questions: [Question] = [];
    var hints = [Int:Hint]();
    
    private override init() {
        super.init();
        
        //        books = BooksParser().books;
        //        print(books);
        
        questions = QuestionsParser().questions;
        hints = HintsParser().hints;
//        print(hints);
    }
    
    func getRandomQuestions(fromCategory category: Int) -> [Question] {
        
        var regulamentNavigatieDQuestions: [Question] = [];
        var marinarieDQuestions: [Question] = [];
        var conducereaSiManevrareaDQuestions: [Question] = [];
        var colregCQuestions: [Question] = [];
        var navigatieMaritimaCQuestions: [Question] = [];
        var marinarieCQuestions: [Question] = [];
        var conducereaSiManevrareaCQuestions: [Question] = [];
        
        for item in questions {
            switch item.subcategory {
            case Const.SUBCATEGORY_REGULAMENT_NAVIGATIE_D:
                regulamentNavigatieDQuestions.append(item);
                break;
            case Const.SUBCATEGORY_MARINARIE_D:
                marinarieDQuestions.append(item);
                break;
            case Const.SUBCATEGORY_CONDUCEREA_SI_MANEVRAREA_D:
                conducereaSiManevrareaDQuestions.append(item);
                break;
            case Const.SUBCATEGORY_COLREG_C:
                colregCQuestions.append(item);
                break;
            case Const.SUBCATEGORY_NAVIGATIE_MARITIMA_C:
                navigatieMaritimaCQuestions.append(item);
                break;
            case Const.SUBCATEGORY_MARINARIE_C:
                marinarieCQuestions.append(item);
                break;
            case Const.SUBCATEGORY_CONDUCEREA_SI_MANEVRAREA_C:
                conducereaSiManevrareaCQuestions.append(item);
                break;
            default:
                print();
            }
        }
        
        
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
        
    
    
    
}

