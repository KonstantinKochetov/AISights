import Foundation
import MapKit
import RealmSwift

class RealmDenkmal: Object {

    @objc dynamic var id: String?
    @objc dynamic var title: String?
    @objc dynamic var location: String?
    @objc dynamic var street: String?
    @objc dynamic var date: String?
    @objc dynamic var execution: String?
    @objc dynamic var builderOwner: String?
    @objc dynamic var literature: String?
    @objc dynamic var design: String?
    @objc dynamic var lat: String?
    @objc dynamic var long: String?
    @objc dynamic var image: String?
    @objc dynamic var text: String?
    @objc dynamic var baubeginn: String?
    @objc dynamic var reconstruction: String?

    override public static func primaryKey() -> String? {
        return "id"
    }

    public convenience init(id: String? = UUID().uuidString,
                            title: String? = nil,
                            location: String? = nil,
                            street: String? = nil,
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
        self.image = image
        self.text = text
        self.baubeginn = baubeginn
        self.reconstruction = reconstruction
    }

    func toDenkmal() -> Denkmal {
        return Denkmal(id: id,
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
