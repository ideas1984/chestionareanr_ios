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
        scrollView.contentLayoutGuide.bottomAnchor.constraint(equalTo:label.bottomAnchor).isActive = true;
        
        var text = String();
        let hintsMap = XMLUtil.instance.hints;
//        for hintID in hints {
//            text.append(hintsMap[hintID]!.content.replacingOccurrences(of: "[", with: "<").replacingOccurrences(of: "]", with: ">"));
//            text.append("\n\n");
//        }
        
        for hintID in 1...10 {
            text.append(hintsMap[hintID]!.content.replacingOccurrences(of: "[", with: "<").replacingOccurrences(of: "]", with: ">"));
            text.append("<br><br>");
        }
        
        label.attributedText = stringFromHtml(string: text);
        
//        label.text = "<b>Aenean</b> a tristique mi. Nam mattis dolor vitae vulputate lobortis. Mauris pharetra turpis vel nulla venenatis tincidunt. Donec fringilla ultrices tellus, finibus fringilla ex elementum eget. Sed scelerisque in lacus et iaculis. Sed ornare ipsum tortor, eget semper ipsum aliquam viverra. Pellentesque a libero volutpat, rutrum mauris ac, aliquet dolor. Aliquam ut purus faucibus, volutpat diam ut, malesuada sem. Aenean a tristique mi. Nam mattis dolor vitae vulputate lobortis. Mauris pharetra turpis vel nulla venenatis tincidunt. Donec fringilla ultrices tellus, finibus fringilla ex elementum eget. Sed scelerisque in lacus et iaculis. Sed ornare ipsum tortor, eget semper ipsum aliquam viverra. Pellentesque a libero volutpat, rutrum mauris ac, aliquet dolor. Aliquam ut purus faucibus, volutpat diam ut, malesuada sem.";
        
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

