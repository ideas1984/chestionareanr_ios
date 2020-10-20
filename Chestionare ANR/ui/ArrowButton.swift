//
//  ArrowButton.swift
//  Chestionare ANR
//
//  Created by Marius Tanasoiu on 8/3/20.
//  Copyright © 2020 NavyMasters. All rights reserved.
//

import UIKit

class ArrowButton: UIButton {

    override func didMoveToWindow() {
        self.backgroundColor = UIColor.white;
        self.layer.cornerRadius = 0;
        self.setImage(UIImage(named: "play_50.png"), for: .normal);
        
        
        self.imageView?.contentMode = .scaleAspectFit;
        self.imageView?.layer.transform = CATransform3DMakeScale(0.8, 0.8, 0.8);
//        self.imageEdgeInsets = UIEdgeInsets(top:40, left:40, bottom:40, right:40);
        
//        self.semanticContentAttribute = UIApplication.shared
//            .userInterfaceLayoutDirection == .rightToLeft ? .forceLeftToRight : .forceRightToLeft;
        
        self.contentHorizontalAlignment = .left
        self.setTitleColor(UIColor.black, for: .normal);
        self.layer.shadowColor = UIColor.blue.cgColor;
        self.layer.shadowRadius = 0;
        self.layer.shadowOpacity = 0.5;
        self.layer.shadowOffset = CGSize(width: 0, height: 0);
        
        alignImageAndTitleVertically()
    }
    
    func alignImageAndTitleVertically(padding: CGFloat = 4.0) {
        let imageSize = imageView!.frame.size
        let titleSize = titleLabel!.frame.size
        let totalHeight = imageSize.height + titleSize.height + padding

        imageEdgeInsets = UIEdgeInsets(
            top: -(totalHeight - imageSize.height),
            left: 0,
            bottom: 0,
            right: -titleSize.width
        )

        titleEdgeInsets = UIEdgeInsets(
            top: 0,
            left: -imageSize.width,
            bottom: -(totalHeight - titleSize.height),
            right: 0
        )
    }

}
