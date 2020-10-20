//
//  QuestionsParser.swift
//  Chestionare ANR
//
//  Created by Marius Tanasoiu on 10/16/20.
//  Copyright © 2020 NavyMasters. All rights reserved.
//

import UIKit

class QuestionsParser: NSObject, XMLParserDelegate {
    
    var books: [Book] = [];
    
    var elementName: String = String();
    var bookTitle = String();
    var bookAuthor = String();
    
    override init() {
        super.init();
        readXML();
    }
    
    
    private func readXML() {
        if let path = Bundle.main.url(forResource: "questions_test", withExtension: "xml") {
            if let parser = XMLParser(contentsOf: path) {
                parser.delegate = self;
                parser.parse();
            }
        }
    }
    
    
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String] = [:]) {
        
        if elementName == "book" {
            bookTitle = String()
            bookAuthor = String()
        }
        
        self.elementName = elementName
    }
    
    // 2
    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        if elementName == "book" {
            let book = Book(id: 1, bookTitle: bookTitle, bookAuthor: bookAuthor)
            books.append(book)
        }
    }
    
    // 3
    func parser(_ parser: XMLParser, foundCharacters string: String) {
        let data = string.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        
        if (!data.isEmpty) {
            if self.elementName == "title" {
                bookTitle += data
            } else if self.elementName == "author" {
                bookAuthor += data
            }
        }
    }
    
}
