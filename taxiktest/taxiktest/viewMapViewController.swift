//
//  viewMapViewController.swift
//  taxiktest
//
//  Created by Nikita Kuznetsov on 08.09.16.
//  Copyright © 2016 Nikita Kuznetsov. All rights reserved.
//


import UIKit
import MapKit

class viewMapViewController: UIViewController, MKMapViewDelegate {
    
    var city_name : String = ""
    
    var city_latitude : Double = 0.0
    
    var city_longitude : Double = 0.0
    
    
    @IBOutlet weak var mapView: MKMapView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = city_name
        
        mapView.delegate = self

        let location = CLLocationCoordinate2D(
            latitude: city_latitude,
            longitude: city_longitude
        )
    
        let annotation = MKPointAnnotation()
        annotation.coordinate = location
        annotation.title = city_name
    
        mapView.addAnnotation(annotation)
    }

    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        let reuseIdentifier = "pin"
        var pin = mapView.dequeueReusableAnnotationView(withIdentifier: reuseIdentifier) as? MKPinAnnotationView
        if pin == nil {
            pin = MKPinAnnotationView(annotation: annotation, reuseIdentifier: reuseIdentifier)
            if #available(iOS 9.0, *) {
                pin!.pinTintColor = UIColor .red
            }
            pin!.canShowCallout = true
        } else {
            pin!.annotation = annotation
        }
        return pin
    }




}
