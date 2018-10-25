//
//  Denkmal.swift
//  Denkmalkarte
//
//  Created by Florian Häusler on 23.10.18.
//  Copyright © 2018 htw.berlin. All rights reserved.
//

import Foundation
import MapKit

class Denkmal: NSObject, MKAnnotation {
    
    let title:String?
    let locationName:String
    let descriptions: String
    let coordinate:CLLocationCoordinate2D
    
    init(title: String, locationName: String, descriptions: String,coordinate: CLLocationCoordinate2D){
        self.title = title
        self.locationName = locationName
        self.descriptions = descriptions
        self.coordinate = coordinate
        super.init()
    }
    var subtitle: String?{
        return locationName
    }
    
    
}
