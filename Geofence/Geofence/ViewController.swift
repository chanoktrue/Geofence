//
//  ViewController.swift
//  Geofence
//
//  Created by Thongchai Subsaidee on 29/4/2564 BE.
//

import UIKit
import MapKit

class ViewController: UIViewController {
    
    private var map: MKMapView = {
        let map = MKMapView()
        map.frame = UIScreen.main.bounds
        return map
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(map)
        
        LocationManager.shared.getUserLocaton { location in
            print(location)
        }
    }


}

