//
//  HintsVC1.swift
//  Chestionare ANR
//
//  Created by Marius Tanasoiu on 1/13/21.
//  Copyright © 2021 NavyMasters. All rights reserved.
//

import UIKit

class HintsVC: UIViewController {

    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var scrollView: UIScrollView!
    
    var hints : [Int] = [];
    
    override func viewDidLoad() {
        super.viewDidLoad();
        
        containerView.layer.cornerRadius = 10;
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated);
        
        scrollView.isDirectionalLockEnabled = true;
//        scrollView.contentLayoutGuide.bottomAnchor.constraint(equalTo:label.bottomAnchor).isActive = true;
        
        var text = String();
        let hintsMap = XMLUtil.instance.hints;
        
        for (index, element) in hints.enumerated() {
            text.append(hintsMap[element]!.content.replacingOccurrences(of: "[", with: "<").replacingOccurrences(of: "]", with: ">"));
            if(index != hints.count - 1) {
                text.append("\n\n");
            }
        }
        
//        for hintID in hints {
//            text.append(hintsMap[hintID]!.content.replacingOccurrences(of: "[", with: "<").replacingOccurrences(of: "]", with: ">"));
//            text.append("\n\n");
//        }
        
        for hintID in 1...10 {
            text.append(hintsMap[hintID]!.content.replacingOccurrences(of: "[", with: "<").replacingOccurrences(of: "]", with: ">"));
            
            if(hintID != 10) {
                text.append("<br><br>");
            }
        }
        
        label.attributedText = stringFromHtml(string: text);
        
//        label.text = text;
        
    }
    
    private func stringFromHtml(string: String) -> NSAttributedString? {
        
        let html = """
                        <html>
                        <body>
                        <p style="font-size: 18px;">
                        """
                        + string +
                        """
                        </p>
                        </body>
                        </html>
                        """;
        
        let data = Data(html.utf8);
//        let data = html.data(using: String.Encoding.utf16, allowLossyConversion: true);
        if let attributedString = try? NSAttributedString(data: data, options: [.documentType: NSAttributedString.DocumentType.html, .characterEncoding:String.Encoding.utf8.rawValue], documentAttributes: nil) {
            return attributedString;
        }
        return nil;
    }
    
}

