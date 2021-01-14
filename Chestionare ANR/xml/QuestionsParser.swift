//
//  QuestionsParser.swift
//  Chestionare ANR
//
//  Created by Marius Tanasoiu on 10/16/20.
//  Copyright © 2020 NavyMasters. All rights reserved.
//

import UIKit

class QuestionsParser: NSObject, XMLParserDelegate {
    
    var questions: [Question] = [];
    var elementName: String = String();
    var answerId = Int();
    
    var id = Int();
    var name = String();
    var category = [Int]();
    var subcategory = Int();
    var image = String();
    var answers = [Int: String]();
    var correctAnswerId = Int();
    var hints = [Int]();
    
    override init() {
        super.init();
        readXML();
    }
    
    
    private func readXML() {
        if let path = Bundle.main.url(forResource: "questions", withExtension: "xml") {
            if let parser = XMLParser(contentsOf: path) {
                parser.delegate = self;
                parser.parse();
            }
        }
    }
    
    // start element event
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String] = [:]) {
        
        if elementName == "question" {
            id = Int(attributeDict["id"]!)!;
            name = String();
            category  = [];
            subcategory = Int();
            image = String();
            answers = [Int: String]();
            correctAnswerId = Int();
            hints  = [];
        } else if elementName == "answer" {
            answerId = Int(attributeDict["id"]!)!;
        }
        
        self.elementName = elementName;
    }
    
    // end element event
    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        if elementName == "question" {
            let question = Question(id: id, name: name, category: category,subcategory: subcategory,image: image,answers: answers, correctAnswerId: correctAnswerId,hints: hints);
            questions.append(question);
        }
    }
    
    // parse content
    func parser(_ parser: XMLParser, foundCharacters string: String) {
        let trimmed = string.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines);
        
        if (!trimmed.isEmpty) {
            if self.elementName == "name" {
                let noNewLines = string.trimmingCharacters(in: CharacterSet.newlines);
                name += noNewLines;
            } else if self.elementName == "category" {
                category = trimmed.components(separatedBy: ",").map{Int($0)!};
            } else if self.elementName == "subcategory" {
                subcategory = (trimmed as NSString).integerValue;
            } else if self.elementName == "subcategory" {
                image += trimmed;
            } else if self.elementName == "answer" {
                let noNewLines = string.trimmingCharacters(in: CharacterSet.newlines);
                if(answers[answerId] != nil) {
                    answers[answerId] = answers[answerId]! + noNewLines;
                } else {
                    answers[answerId] = noNewLines;
                }
            } else if self.elementName == "correct_answer" {
                correctAnswerId = Int(trimmed)!;
            } else if self.elementName == "hint" {
                hints = trimmed.components(separatedBy: ",").map{Int($0)!};
            }
        }
    }
    
}
