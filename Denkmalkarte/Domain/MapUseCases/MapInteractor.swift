import MapKit
import RealmSwift

public class MapInteractor: MapUseCases {

    let dbHelper: DbHelper
    let apiHelper: ApiHelper
    //    let parser: Parser

    init(dbHelper: DbHelper, apiHelper: ApiHelper//, parser: Parser
        ) {
        self.dbHelper = dbHelper
        self.apiHelper = apiHelper
        //        self.parser = parser
    }

    func loadMapsToRealm() {
        //        let parser = Parser()
        //        if let denkmale = parser.readXML() {
        //            do {
        //                try dbHelper.saveAll(denkmale)
        //            } catch {
        //                print("fail to load xml to realm")
        //            }
        //        } else {
        //            print("fail to parse xml")
        //        }
    }

    func syncFirebaseToRealm() {
        apiHelper.getFirebaseData(success: { result in
            do {
                let denkmale = self.convertFirebaseDataToDenkmal(result)
                try self.dbHelper.saveAll(denkmale)
            } catch {
                print("fail save firebase objects to Realm")
            }
        }, failure: { error in
            print("fail to sync Realm with Firebase")
        })
    }

    func cleanMapsRealm() {
        do {
            try dbHelper.clean()
        } catch {
            print(error)
        }
    }

    func getDenkmale(success: @escaping ([Denkmal]) -> Void,
                     failure: @escaping (Error) -> Void) {
        //dbHelper.getDenkmale(success: success, failure: failure)
    }

    private func convertFirebaseDataToDenkmal(_ firebaseData: [[String: AnyObject]]) -> [Denkmal] { // TODO do it in utils
        var denkmale: [Denkmal] = []
        for element in firebaseData {
            denkmale.append(Denkmal(id: element["id"] as? String ?? "",
                                    beschreibung: element["beschreibung"] as? String ?? "",
                                    ort: element["ort"] as? String ?? "",
                                    latitude: element["latitude"] as? String ?? "",
                                    longitude: element["longitude"] as? String ?? "",
                                    entwurfUndAusfuehrung: element["entwurfUndAusfuehrung"] as? [String] ?? [],
                                    ausfuehrung: element["ausfuehrung"] as? [String] ?? [],
                                    baubeginn: element["baubeginn"] as? String ?? "",
                                    fertigstellung: element["fertigstellung"] as? String ?? "",
                                    ausfuehrungUndBauherrUndEntwurf: element["ausfuehrungUndBauherrUndEntwurf"] as? String ?? "",
                                    entwurfUndFertigstellung: element["entwurfUndFertigstellung"] as? String ?? "",
                                    literatur: element["literatur"] as? String ?? "",
                                    ausfuehrungUndBauherr: element["ausfuehrungUndBauherr"] as? String ?? "",
                                    planungsbeginn: element["planungsbeginn"] as? String ?? "",
                                    entwurfUndDatierung: element["entwurfUndDatierung"] as? String ?? "",
                                    planungUndAusfuehrung: element["planungUndAusfuehrung"] as? String ?? "",
                                    entwurfUndBaubeginnUndFertigstellung: element["entwurfUndBaubeginnUndFertigstellung"] as? String ?? "",
                                    entwurf: element["entwurf"] as? [String] ?? [],
                                    bauherr: element["bauherr"] as? [String] ?? [],
                                    text: element["text"] as? String ?? "",
                                    wiederaufbau: element["wiederaufbau"] as? String ?? "",
                                    umbau: element["umbau"] as? String ?? "",
                                    entwurfUndBaubeginn: element["entwurfUndBaubeginn"] as? String ?? "",
                                    image: element["image"] as? String ?? "",
                                    strasse: element["strasse"] as? [String] ?? [],
                                    planung: element["planung"] as? String ?? "",
                                    entwurfUndBauherr: element["entwurfUndBauherr"] as? String ?? "",
                                    eigentuemer: element["eigentuemer"] as? String ?? "",
                                    datierung: element["datierung"] as? [String] ?? []))
        }
        return denkmale
    }
}
