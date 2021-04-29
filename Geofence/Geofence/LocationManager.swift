//
//  LocationManager.swift
//  Geofence
//
//  Created by Thongchai Subsaidee on 29/4/2564 BE.
//

import Foundation
import CoreLocation

enum GeofenceType: String {
    case exit, enter
}

class LocationManager: NSObject {
    
    static let shared = LocationManager()
    let locationManager = CLLocationManager()
    
    var completionManager: ((CLLocation) -> ())?
    var completionGeofence: ((GeofenceType) -> ())?
}

// MARK: - Location Manger
extension LocationManager: CLLocationManagerDelegate {

    public func getUserLocation(completion: @escaping (CLLocation) -> ()) {
        self.completionManager = completion
        locationManager.requestWhenInUseAuthorization()
        locationManager.delegate = self
        locationManager.startUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.first else {
            return
        }
        completionManager?(location)
        locationManager.stopUpdatingLocation()
    }
        
}

// MARK: - Geofence

extension LocationManager {
    
    public func addGeofence(location: CLLocation, radius: CLLocationDistance, completion: @escaping ((GeofenceType) ->())) {
        self.completionGeofence = completion
        let center: CLLocationCoordinate2D = location.coordinate
        let geofence = CLCircularRegion(center: center, radius: radius, identifier: "notifyWhenEnter")
        geofence.notifyOnExit = true
        geofence.notifyOnEntry = true
        locationManager.startMonitoring(for: geofence)
    }
    
    func locationManager(_ manager: CLLocationManager, didExitRegion region: CLRegion) {
        completionGeofence?(.exit)
    }
    
    func locationManager(_ manager: CLLocationManager, didEnterRegion region: CLRegion) {
        completionGeofence?(.enter)
    }
}


