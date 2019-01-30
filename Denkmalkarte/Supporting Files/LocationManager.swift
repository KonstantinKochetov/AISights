//
//  LocationManager.swift
//  Denkmalkarte
//
//  Created by Julian on 1/30/19.
//  Copyright © 2019 htw.berlin. All rights reserved.
//

import Foundation
import MapKit

class LocationManager: NSObject {

    static let shared = LocationManager()

    private let locationManager = CLLocationManager()

    var location: CLLocation?

    private override init() {
        super.init()
        locationManager.delegate = self
        locationManager.startUpdatingLocation()
    }

}

extension LocationManager: CLLocationManagerDelegate {

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        location = locations.first
    }

    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error.localizedDescription)
    }

}
