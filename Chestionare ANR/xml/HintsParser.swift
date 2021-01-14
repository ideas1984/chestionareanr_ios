//
//  Hintsparser.swift
//  Chestionare ANR
//
//  Created by Marius Tanasoiu on 1/13/21.
//  Copyright © 2021 NavyMasters. All rights reserved.
//

import UIKit

class HintsParser: NSObject, XMLParserDelegate {
    
    var hints = [Int:Hint]();
    
    var elementName: String = String();
    
    var id = Int();
    var content = String();
    
    override init() {
        super.init();
        readXML();
    }
    
    
    private func readXML() {
        if let path = Bundle.main.url(forResource: "hints", withExtension: "xml") {
            if let parser = XMLParser(contentsOf: path) {
                parser.delegate = self;
                parser.parse();
            }
        }
    }
    
    // start element event
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String] = [:]) {
        
        if elementName == "hint" {
            id = Int(attributeDict["id"]!)!;
            content = String();
        }
        
        self.elementName = elementName;
    }
    
    // end element event
    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        if elementName == "hint" {
            hints[id] = Hint(id: id, content: content);
        }
    }
    
    // parse content
    func parser(_ parser: XMLParser, foundCharacters string: String) {
        let trimmed = string.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines);
        
        if (!trimmed.isEmpty) {
            if self.elementName == "hint" {
                let noNewLines = string.trimmingCharacters(in: CharacterSet.newlines);
                content += noNewLines;
            }
        }
    }
    
}
