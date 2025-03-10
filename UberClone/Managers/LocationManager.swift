//
//  LocationManager.swift
//  UberClone
//
//  Created by Johanan Edmeade on 1/6/24.
//

import CoreLocation

class LocationManager: NSObject, ObservableObject{
    static var shared = LocationManager()
    private let locationManager = CLLocationManager()
    @Published var userLocation: CLLocationCoordinate2D?
    
    override init() {
        super.init()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        
    }
}

extension LocationManager: CLLocationManagerDelegate{
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        //first location in array
        guard let location = locations.first else {return}
        //adds location to var user variable
        self.userLocation = location.coordinate
        locationManager.stopUpdatingLocation()
    }
}

