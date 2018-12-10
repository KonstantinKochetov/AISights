import Foundation
import MapKit
import RealmSwift

class Denkmal: NSObject, MKAnnotation {

    var id: String
    var markiert: Bool
    var title: String?
    var ort: String
    var latitude: String
    var longitude: String
    var entwurfUndAusfuehrung: [String]
    var ausfuehrung: [String]
    var baubeginn: String
    var fertigstellung: String
    var ausfuehrungUndBauherrUndEntwurf: String
    var entwurfUndFertigstellung: String
    var literatur: String
    var ausfuehrungUndBauherr: String
    var planungsbeginn: String
    var entwurfUndDatierung: String
    var planungUndAusfuehrung: String
    var entwurfUndBaubeginnUndFertigstellung: String
    var entwurf: [String]
    var bauherr: [String]
    var text: String
    var wiederaufbau: String
    var umbau: String
    var entwurfUndBaubeginn: String
    var image: String
    var strasse: [String]
    var planung: String
    var entwurfUndBauherr: String
    var eigentuemer: String
    var datierung: [String]
    var coordinate: CLLocationCoordinate2D


    // TODO temporary delete after deleting xml parser
    override init() {
        self.id = ""
        self.markiert = false
        self.title = ""
        self.ort = ""
        self.latitude = ""
        self.longitude = ""
        self.entwurfUndAusfuehrung = []
        self.ausfuehrung = []
        self.baubeginn = ""
        self.fertigstellung = ""
        self.ausfuehrungUndBauherrUndEntwurf = ""
        self.entwurfUndFertigstellung = ""
        self.literatur = ""
        self.ausfuehrungUndBauherr = ""
        self.planungsbeginn = ""
        self.entwurfUndDatierung = ""
        self.planungUndAusfuehrung = ""
        self.entwurfUndBaubeginnUndFertigstellung = ""
        self.entwurf = []
        self.bauherr = []
        self.text = ""
        self.wiederaufbau = ""
        self.umbau = ""
        self.entwurfUndBaubeginn = ""
        self.image = ""
        self.strasse = []
        self.planung = ""
        self.entwurfUndBauherr = ""
        self.eigentuemer = ""
        self.datierung = []
        self.coordinate = CLLocationCoordinate2D(latitude: 0, longitude: 0)
        super.init()
    }

    // MARK official main constructor
    convenience init(id: String,
                     markiert: Bool,
                     title: String,
                     ort: String,
                     latitude: String,
                     longitude: String,
                     entwurfUndAusfuehrung: [String],
                     ausfuehrung: [String],
                     baubeginn: String,
                     fertigstellung: String,
                     ausfuehrungUndBauherrUndEntwurf: String,
                     entwurfUndFertigstellung: String,
                     literatur: String,
                     ausfuehrungUndBauherr: String,
                     planungsbeginn: String,
                     entwurfUndDatierung: String,
                     planungUndAusfuehrung: String,
                     entwurfUndBaubeginnUndFertigstellung: String,
                     entwurf: [String],
                     bauherr: [String],
                     text: String,
                     wiederaufbau: String,
                     umbau: String,
                     entwurfUndBaubeginn: String,
                     image: String,
                     strasse: [String],
                     planung: String,
                     entwurfUndBauherr: String,
                     eigentuemer: String,
                     datierung: [String]) {
        self.init()
        self.id = id
        self.markiert = markiert
        self.title = title
        self.ort = ort
        self.latitude = latitude
        self.longitude = longitude
        self.entwurfUndAusfuehrung = entwurfUndAusfuehrung
        self.ausfuehrung = ausfuehrung
        self.baubeginn = baubeginn
        self.fertigstellung = fertigstellung
        self.ausfuehrungUndBauherrUndEntwurf = ausfuehrungUndBauherrUndEntwurf
        self.entwurfUndFertigstellung = entwurfUndFertigstellung
        self.literatur = literatur
        self.ausfuehrungUndBauherr = ausfuehrungUndBauherr
        self.planungsbeginn = planungsbeginn
        self.entwurfUndDatierung = entwurfUndDatierung
        self.planungUndAusfuehrung = planungUndAusfuehrung
        self.entwurfUndBaubeginnUndFertigstellung = entwurfUndBaubeginnUndFertigstellung
        self.entwurf = entwurf
        self.bauherr = bauherr
        self.text = text
        self.wiederaufbau = wiederaufbau
        self.umbau = umbau
        self.entwurfUndBaubeginn = entwurfUndBaubeginn
        self.image = image
        self.strasse = strasse
        self.planung = planung
        self.entwurfUndBauherr = entwurfUndBauherr
        self.eigentuemer = eigentuemer
        self.datierung = datierung
        self.coordinate = getCoordinates(lat: latitude, long: longitude)
    }

    var subtitle: String? {
        return ort
    }

    private func getCoordinates(lat: String, long: String) -> CLLocationCoordinate2D { // TODO in utils
        if (long != nil && !long.isEmpty && lat != nil && !lat.isEmpty) {
            let lon =  NumberFormatter().number(from: long )?.doubleValue
            let lat =  NumberFormatter().number(from: lat)?.doubleValue
            return CLLocationCoordinate2D(latitude: Double(lat!), longitude: lon!) // TODO fix this
        }
        return CLLocationCoordinate2D(latitude: 0, longitude: 0)

    }

    func toRealmDenkmal() -> RealmDenkmal {

        let realmEntwurfUndAusfuehrung = List<String>()
        for el in entwurfUndAusfuehrung {
            realmEntwurfUndAusfuehrung.append(el)
        }

        let realmAusfuehrung = List<String>()
        for el in ausfuehrung {
            realmAusfuehrung.append(el)
        }

        let realmEntwurf = List<String>()
        for el in entwurf {
            realmEntwurf.append(el)
        }

        let realmBauherr = List<String>()
        for el in bauherr {
            realmBauherr.append(el)
        }

        let realmStrasse = List<String>()
        for el in strasse {
            realmStrasse.append(el)
        }

        let realmDatierung = List<String>()
        for el in datierung {
            realmDatierung.append(el)
        }

        return RealmDenkmal(id: id,
                            markiert: markiert,
                            title: title ?? "",
                            ort: ort,
                            latitude: latitude,
                            longitude: longitude,
                            entwurfUndAusfuehrung: realmEntwurfUndAusfuehrung,
                            ausfuehrung: realmAusfuehrung,
                            baubeginn: baubeginn,
                            fertigstellung: fertigstellung,
                            ausfuehrungUndBauherrUndEntwurf: ausfuehrungUndBauherrUndEntwurf,
                            entwurfUndFertigstellung: entwurfUndFertigstellung,
                            literatur: literatur,
                            ausfuehrungUndBauherr: ausfuehrungUndBauherr,
                            planungsbeginn: planungsbeginn,
                            entwurfUndDatierung: entwurfUndDatierung,
                            planungUndAusfuehrung: planungUndAusfuehrung,
                            entwurfUndBaubeginnUndFertigstellung: entwurfUndBaubeginnUndFertigstellung,
                            entwurf: realmEntwurf,
                            bauherr: realmBauherr,
                            text: text,
                            wiederaufbau: wiederaufbau,
                            umbau: umbau,
                            entwurfUndBaubeginn: entwurfUndBaubeginn,
                            image: image,
                            strasse: realmStrasse,
                            planung: planung,
                            entwurfUndBauherr: entwurfUndBauherr,
                            eigentuemer: eigentuemer,
                            datierung: realmDatierung)
    }
}
