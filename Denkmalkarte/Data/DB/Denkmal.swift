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

    var id: Int = 0
    var title: String?
    var location: String
    var street: String
    var date: String
    var execution: String
    var builderOwner: String
    var literature: String
    var design: String
    var lat: String
    var long: String
    var coordinate: CLLocationCoordinate2D

    init(title: String, location: String, street: String, date: String, execution: String, builderOwner: String, literature: String, design: String, lat: String, long: String, coordinate: CLLocationCoordinate2D) {
        self.title = title
        self.location = location
        self.street = street
        self.date = date
        self.execution = execution
        self.builderOwner = builderOwner
        self.literature = literature
        self.design = design
        self.lat = lat
        self.long = long
        self.coordinate = coordinate
        super.init()
    }

    var subtitle: String? {
        return location
    }

}
