//
//  Denkmal.swift
//  Denkmalkarte
//
//  Created by Konstantin Kochetov on 17.11.18.
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
    
    // MARK: to deal with RealmDenkmal object
    convenience init (id: Int,
                      title: String? = "",
                      location: String? = "",
                      street: String? = "",
                      date: String? = "",
                      execution: String? = "",
                      builderOwner: String? = "",
                      literature: String? = "",
                      design: String? = "",
                      lat: String? = "",
                      long: String? = "",
                      image: String? = "",
                      text: String? = "",
                      baubeginn: String? = "",
                      reconstruction: String? = "") {
        self.init()
        self.id = id
        self.title = title!
        self.location = location!
        self.street = street!
        self.date = date!
        self.execution = execution!
        self.builderOwner = builderOwner!
        self.literature = literature!
        self.design = design!
        self.lat = lat!
        self.long = long!
        self.image = image!
        self.text = text!
        self.baubeginn = baubeginn!
        self.reconstruction = reconstruction!
        self.coordinate = CLLocationCoordinate2D(latitude: Double(self.lat)!, longitude: Double(self.long)!)
    }
    
    func toRealmDenkmal() -> RealmDenkmal {
        return RealmDenkmal(id: id,
                            location: location,
                            street: street,
                            date: date,
                            execution: execution,
                            builderOwner: builderOwner,
                            literature: literature,
                            design: design,
                            lat: lat,
                            long: long,
                            image: image,
                            text: text,
                            baubeginn: baubeginn,
                            reconstruction: reconstruction)
    }
    
}
