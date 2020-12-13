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
    
    private override init() {
        super.init();
        print("s-a initializat");
        
//        books = BooksParser().books;
//        print(books);
        
        questions = QuestionsParser().questions;
        print(questions);
        
    }

    
}

