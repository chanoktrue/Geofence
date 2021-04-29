//
//  ViewController.swift
//  Geofence
//
//  Created by Thongchai Subsaidee on 29/4/2564 BE.
//

import UIKit
import MapKit
import CoreLocation

class ViewController: UIViewController {
    
    private var map: MKMapView = {
        let map = MKMapView()
        map.frame = UIScreen.main.bounds
        return map
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(map)
        
        LocationManager.shared.getUserLocation { [weak self] location in
            guard let strongSelf = self else {
                return
            }
            
            // MARK: - Pin
            strongSelf.addMapPin(location: location)
            
            // MARK: - Geofence
            LocationManager.shared.addGeofence(location: location, radius: 3000) {
                if $0 == true  {
                    print("Exit")
                }else if $1 == true {
                    print("Enter")
                }
            }
        }
        
    }

    private func addMapPin(location: CLLocation) {
        let pin = MKPointAnnotation()
        pin.coordinate = location.coordinate
                    
        let span = MKCoordinateSpan(latitudeDelta: 0.7, longitudeDelta: 0.7)
        let region = MKCoordinateRegion(center: location.coordinate, span: span)
        map.setRegion(region, animated: true)
        
        map.addAnnotation(pin)
    }
    


}

