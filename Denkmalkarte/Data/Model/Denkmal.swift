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
    var image: String
    var text: String
    var baubeginn: String
    var reconstruction: String

    override init() {
        self.title = ""
        self.location = ""
        self.street = ""
        self.date = ""
        self.execution = ""
        self.builderOwner = ""
        self.literature = ""
        self.design = ""
        self.lat = ""
        self.long = ""
        self.image = ""
        self.text = ""
        self.baubeginn = ""
        self.reconstruction = ""
        self.coordinate = CLLocationCoordinate2D(latitude: 0, longitude: 0)
        super.init()
    }

    var subtitle: String? {
        return location
    }

}
