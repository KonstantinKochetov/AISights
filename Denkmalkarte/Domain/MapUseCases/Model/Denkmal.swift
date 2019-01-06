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
    var image: [String]
    var strasse: [String]
    var planung: String
    var entwurfUndBauherr: String
    var eigentuemer: String
    var datierung: [String]
    var coordinate: CLLocationCoordinate2D

    public init(id: String,
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
                image: [String],
                strasse: [String],
                planung: String,
                entwurfUndBauherr: String,
                eigentuemer: String,
                datierung: [String]) {
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
        if !longitude.isEmpty && !latitude.isEmpty {
            let lon =  NumberFormatter().number(from: longitude)?.doubleValue
            let lat =  NumberFormatter().number(from: latitude)?.doubleValue
            self.coordinate = CLLocationCoordinate2D(latitude: Double(lat ?? 0), longitude: Double(lon ?? 0))
        } else {
            self.coordinate = CLLocationCoordinate2D(latitude: 0, longitude: 0)
        }
        super.init()
    }

    var subtitle: String? {
        return ort
    }

    func toRealmDenkmal() -> RealmDenkmal {
        return RealmDenkmal(id: id,
                            markiert: markiert,
                            title: title ?? "",
                            ort: ort,
                            latitude: latitude,
                            longitude: longitude,
                            entwurfUndAusfuehrung: convertArrayToRealmList(array: entwurfUndAusfuehrung),
                            ausfuehrung: convertArrayToRealmList(array: ausfuehrung),
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
                            entwurf: convertArrayToRealmList(array: entwurf),
                            bauherr: convertArrayToRealmList(array: bauherr),
                            text: text,
                            wiederaufbau: wiederaufbau,
                            umbau: umbau,
                            entwurfUndBaubeginn: entwurfUndBaubeginn,
                            image: convertArrayToRealmList(array: image),
                            strasse: convertArrayToRealmList(array: strasse),
                            planung: planung,
                            entwurfUndBauherr: entwurfUndBauherr,
                            eigentuemer: eigentuemer,
                            datierung: convertArrayToRealmList(array: datierung))
    }

    private func convertArrayToRealmList(array: [String]) -> List<String> {
        let list = List<String>()
        for el in array {
            list.append(el)
        }
        return list
    }
}
