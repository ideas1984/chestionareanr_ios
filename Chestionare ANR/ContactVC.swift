//
//  AboutVC.swift
//  Chestionare ANR
//
//  Created by Marius Tanasoiu on 2/9/21.
//  Copyright © 2021 NavyMasters. All rights reserved.
//

import UIKit
import MapKit

class ContactVC: UIViewController {
    
    @IBAction func buttonTapped(_ sender: UITapGestureRecognizer) {
        
        switch sender.view?.accessibilityIdentifier?.description {
        case "but_address":
            openMaps();
        case "but_phone":
            makeACall();
        case "but_email":
            opneEmail();
        case "but_www":
            openWebPage();
        default:
            print("no button recognized");
        }
    }
    
    private func openMaps() {
        //        let source = MKMapItem(placemark: MKPlacemark(coordinate: CLLocationCoordinate2D(latitude: lat, longitude: lng)))
        //        source.name = "Source"
        
        let destination = MKMapItem(placemark: MKPlacemark(coordinate: CLLocationCoordinate2D(latitude: 44.259848134225955, longitude: 26.05501047319706)))
        destination.name = "Destination"
        
        MKMapItem.openMaps(with: [/*source,*/ destination], launchOptions: [MKLaunchOptionsDirectionsModeKey: MKLaunchOptionsDirectionsModeDriving])
    }
    
    private func makeACall() {
        if let url = URL(string: "tel://" + "+40787646111") {
            if #available(iOS 10.0, *) {
                UIApplication.shared.open(url)
            } else {
                UIApplication.shared.openURL(url)
            }
        }
    }
    
    private func opneEmail() {
        let email = "navymasters@yahoo.com"
        if let url = URL(string: "mailto:\(email)") {
            if #available(iOS 10.0, *) {
                UIApplication.shared.open(url)
            } else {
                UIApplication.shared.openURL(url)
            }
        }
    }
    
    private func openWebPage() {
        AppUtility.navigateTo(url: "https://www.navymasters.ro");
    }
}
