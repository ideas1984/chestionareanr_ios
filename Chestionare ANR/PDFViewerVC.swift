//
//  PDFViewerViewController.swift
//  Chestionare ANR
//
//  Created by Marius Tanasoiu on 11/22/20.
//  Copyright © 2020 NavyMasters. All rights reserved.
//

import UIKit
import PDFKit

class PDFViewerVC: UIViewController {
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated);
       
        AppUtility.lockOrientation(.all);
       // Or to rotate and lock
       // AppUtility.lockOrientation(.portrait, andRotateTo: .portrait)
   }
    
    override func viewDidLoad() {
        
        if #available(iOS 11.0, *) {
            let pdfViewer = PDFView();
            
            if let path = Bundle.main.url(forResource: "anexe", withExtension: "pdf") {
                pdfViewer.document = PDFDocument(url: path);
            }
            
            
            pdfViewer.maxScaleFactor = 4.0;
            pdfViewer.minScaleFactor = pdfViewer.scaleFactorForSizeToFit;
            pdfViewer.autoScales = true;
           

            
            self.view.addSubview(pdfViewer);
            pdfViewer.translatesAutoresizingMaskIntoConstraints = false;
            
            pdfViewer.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 0).isActive = true;
            pdfViewer.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: 0).isActive = true;
            pdfViewer.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: 0).isActive = true;
            pdfViewer.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 0).isActive = true;
            

            
        } else {
            let pdfViewer = UIWebView();
            pdfViewer.scalesPageToFit = true;
            self.view.addSubview(pdfViewer);
            
            pdfViewer.translatesAutoresizingMaskIntoConstraints = false;
            
            pdfViewer.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 0).isActive = true;
            pdfViewer.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: 0).isActive = true;
            pdfViewer.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: 0).isActive = true;
            pdfViewer.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 0).isActive = true;
            
            if let path = Bundle.main.url(forResource: "anexe", withExtension: "pdf") {
                pdfViewer.loadRequest(URLRequest(url:path));
            }
            
        }
        
        let backButton = UIImageView(image: UIImage(named: "back.png"));
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageTapped(tapGestureRecognizer:)))
        backButton.isUserInteractionEnabled = true;
        backButton.addGestureRecognizer(tapGestureRecognizer);
        
        backButton.translatesAutoresizingMaskIntoConstraints = false;
        self.view.addSubview(backButton);
        
        backButton.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 16).isActive = true;
        backButton.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 32).isActive = true;
        backButton.heightAnchor.constraint(equalToConstant: 50).isActive = true;
        backButton.widthAnchor.constraint(equalToConstant: 50).isActive = true;
        
    }
    
    @objc func imageTapped(tapGestureRecognizer: UITapGestureRecognizer) {
        if let nav = self.navigationController {
                    nav.popViewController(animated: true)
                } else {
                    self.dismiss(animated: true, completion: nil)
                }
    }
    
}
