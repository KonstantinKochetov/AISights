import Foundation
import MapKit
import RealmSwift

class RealmDenkmal: Object {

    @objc dynamic var id: String = ""
    @objc dynamic var beschreibung: String = ""
    @objc dynamic var ort: String = ""
    @objc dynamic var latitude: String = ""
    @objc dynamic var longitude: String = ""
    var entwurfUndAusfuehrung: List<String> = List<String>()
    var ausfuehrung: List<String> = List<String>()
    @objc dynamic var baubeginn: String = ""
    @objc dynamic var fertigstellung: String = ""
    @objc dynamic var ausfuehrungUndBauherrUndEntwurf: String = ""
    @objc dynamic var entwurfUndFertigstellung: String = ""
    @objc dynamic var literatur: String = ""
    @objc dynamic var ausfuehrungUndBauherr: String = ""
    @objc dynamic var planungsbeginn: String = ""
    @objc dynamic var entwurfUndDatierung: String = ""
    @objc dynamic var planungUndAusfuehrung: String = ""
    @objc dynamic var entwurfUndBaubeginnUndFertigstellung: String = ""
    var entwurf: List<String> = List<String>()
    var bauherr: List<String> = List<String>()
    @objc dynamic var text: String = ""
    @objc dynamic var wiederaufbau: String = ""
    @objc dynamic var umbau: String = ""
    @objc dynamic var entwurfUndBaubeginn: String = ""
    @objc dynamic var image: String = ""
    var strasse: List<String> = List<String>()
    @objc dynamic var planung: String = ""
    @objc dynamic var entwurfUndBauherr: String = ""
    @objc dynamic var eigentuemer: String = ""
    var datierung: List<String> = List<String>()

    override public static func primaryKey() -> String {
        return "id"
    }

    public convenience init(id: String = "",
                            beschreibung: String = "",
                            ort: String = "",
                            latitude: String = "",
                            longitude: String = "",
                            entwurfUndAusfuehrung: List<String> = List<String>(),
                            ausfuehrung: List<String> = List<String>(),
                            baubeginn: String = "",
                            fertigstellung: String = "",
                            ausfuehrungUndBauherrUndEntwurf: String = "",
                            entwurfUndFertigstellung: String = "",
                            literatur: String = "",
                            ausfuehrungUndBauherr: String = "",
                            planungsbeginn: String = "",
                            entwurfUndDatierung: String = "",
                            planungUndAusfuehrung: String = "",
                            entwurfUndBaubeginnUndFertigstellung: String = "",
                            entwurf: List<String> = List<String>(),
                            bauherr: List<String> = List<String>(),
                            text: String = "",
                            wiederaufbau: String = "",
                            umbau: String = "",
                            entwurfUndBaubeginn: String = "",
                            image: String = "",
                            strasse: List<String> = List<String>(),
                            planung: String = "",
                            entwurfUndBauherr: String = "",
                            eigentuemer: String = "",
                            datierung: List<String> = List<String>()) {
        self.init()
        self.id = id
        self.beschreibung = beschreibung
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
    }

    func toDenkmal() -> Denkmal {
        return Denkmal(id: id,
                       beschreibung: beschreibung,
                       ort: ort,
                       latitude: latitude,
                       longitude: longitude,
                       entwurfUndAusfuehrung: Array(entwurfUndAusfuehrung),
                       ausfuehrung: Array(ausfuehrung),
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
                       entwurf: Array(entwurf),
                       bauherr: Array(bauherr),
                       text: text,
                       wiederaufbau: wiederaufbau,
                       umbau: umbau,
                       entwurfUndBaubeginn: entwurfUndBaubeginn,
                       image: image,
                       strasse: Array(strasse),
                       planung: planung,
                       entwurfUndBauherr: entwurfUndBauherr,
                       eigentuemer: eigentuemer,
                       datierung: Array(datierung))
    }
}
