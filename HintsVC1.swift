//
//  HintsVC1.swift
//  Chestionare ANR
//
//  Created by Marius Tanasoiu on 1/13/21.
//  Copyright © 2021 NavyMasters. All rights reserved.
//

import UIKit

class HintsVC1: UIViewController {

    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var scrollView: UIScrollView!
    
    override func viewDidLoad() {
        super.viewDidLoad();
        
        scrollView.contentLayoutGuide.bottomAnchor.constraint(equalTo:label.bottomAnchor).isActive = true;

        label.text = "Aenean a tristique mi. Nam mattis dolor vitae vulputate lobortis. Mauris pharetra turpis vel nulla venenatis tincidunt. Donec fringilla ultrices tellus, finibus fringilla ex elementum eget. Sed scelerisque in lacus et iaculis. Sed ornare ipsum tortor, eget semper ipsum aliquam viverra. Pellentesque a libero volutpat, rutrum mauris ac, aliquet dolor. Aliquam ut purus faucibus, volutpat diam ut, malesuada sem. Aenean a tristique mi. Nam mattis dolor vitae vulputate lobortis. Mauris pharetra turpis vel nulla venenatis tincidunt. Donec fringilla ultrices tellus, finibus fringilla ex elementum eget. Sed scelerisque in lacus et iaculis. Sed ornare ipsum tortor, eget semper ipsum aliquam viverra. Pellentesque a libero volutpat, rutrum mauris ac, aliquet dolor. Aliquam ut purus faucibus, volutpat diam ut, malesuada sem.";
    }

}
