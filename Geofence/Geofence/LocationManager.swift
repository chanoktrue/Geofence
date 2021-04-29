//
//  LocationManager.swift
//  Geofence
//
//  Created by Thongchai Subsaidee on 29/4/2564 BE.
//

import Foundation
import CoreLocation

class LocationManager: NSObject {
    
    static let shared = LocationManager()
    let locationManager = CLLocationManager()
    var completion: ((CLLocation) -> ())?
}

// MARK: - Location Manger
extension LocationManager: CLLocationManagerDelegate {

    public func getUserLocation(completion: @escaping (CLLocation) -> ()) {
        self.completion = completion
        locationManager.requestWhenInUseAuthorization()
        locationManager.delegate = self
        locationManager.startUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.first else {
            return
        }
        completion?(location)
        locationManager.stopUpdatingLocation()
    }
        
}

// MARK: - Geofence

extension LocationManager {
    
    public func addGeofence(location: CLLocation, radius: CLLocationDistance) {
        let center: CLLocationCoordinate2D = location.coordinate
        let geofence = CLCircularRegion(center: center, radius: radius, identifier: "notifyWhenEnter")
        geofence.notifyOnExit = true
        geofence.notifyOnEntry = true
        locationManager.startMonitoring(for: geofence)
    }
    
    func locationManager(_ manager: CLLocationManager, didExitRegion region: CLRegion) {
        print("Exit")
    }
    
    func locationManager(_ manager: CLLocationManager, didEnterRegion region: CLRegion) {
        print("Enter")
    }
}


