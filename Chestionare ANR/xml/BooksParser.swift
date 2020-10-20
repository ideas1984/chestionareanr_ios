//
//  QuestionsParser.swift
//  Chestionare ANR
//
//  Created by Marius Tanasoiu on 10/16/20.
//  Copyright © 2020 NavyMasters. All rights reserved.
//

import UIKit

class BooksParser: NSObject, XMLParserDelegate {
    
    var books: [Book] = [];
    
    var elementName: String = String();
    
    var id = Int();
    var bookTitle = String();
    var bookAuthor = String();
    
    override init() {
        super.init();
        readXML();
    }
    
    
    private func readXML() {
        if let path = Bundle.main.url(forResource: "Books", withExtension: "xml") {
            if let parser = XMLParser(contentsOf: path) {
                parser.delegate = self;
                parser.parse();
            }
        }
    }
    
    
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String] = [:]) {
        
        print("attributeDict=\(attributeDict)");
        
        let myString1 = "556"
        let myInt1 = Int(attributeDict["id"]!)
        
        var x = Int();
        x = myInt1!;        
        if elementName == "book" {
            id = Int(attributeDict["id"]!)!;
            bookTitle = String()
            bookAuthor = String()
        }
        
        self.elementName = elementName
    }
    
    // 2
    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        if elementName == "book" {
            let book = Book(id: id, bookTitle: bookTitle, bookAuthor: bookAuthor)
            books.append(book)
        }
    }
    
    // 3
    func parser(_ parser: XMLParser, foundCharacters string: String) {
        let data = string.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines);
        
//        print("elementName=\(elementName)");
        
        if (!data.isEmpty) {
            if self.elementName == "title" {
                bookTitle += data
            } else if self.elementName == "author" {
                bookAuthor += data
            }
        }
    }
//
//    func parser(_ parser: XMLParser, foundAttributeDeclarationWithName attributeName: String, forElement elementName: String, type: String?, defaultValue: String?) {
//        print("attributeName= \(attributeName)  elementName=\(elementName)  type=\(type!)   defaultValue=\(defaultValue!)");
//    }
    
}
