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
        let denkmale = readJSON()
        do {
            try dbHelper.saveAll(denkmale)
            dbHelper.setAlreadyLoaded()
        } catch {
            print("fail to load local file to realm")
        }
    }

    func alreadyLoaded() -> Bool {
        return dbHelper.alreadyLoaded()
    }

    func syncFirebaseToRealm() {
        apiHelper.getFirebaseData(success: { result in
            do {
                let denkmale = self.convertDataToDenkmal(result)
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

    private func readJSON() -> [Denkmal] {
        do {
            if let file = Bundle.main.url(forResource: "short_denkmaeler2", withExtension: "json") {
                let data = try Data(contentsOf: file)
                let json = try JSONSerialization.jsonObject(with: data, options: [])
                if let object = json as? [String: Any] {
                    // json is a dictionary
                    // do nothing for now
                } else if let object = json as? [[String: AnyObject]] {
                    // json is an array
                    let data = convertDataToDenkmal(object)
                    return data
                } else {
                    print("JSON is invalid")
                }
            } else {
                print("no file")
            }
        } catch {
            print(error.localizedDescription)
        }
        return []
    }

    private func convertDataToDenkmal(_ firebaseData: [[String: AnyObject]]) -> [Denkmal] { // TODO do it in utils
        var denkmale: [Denkmal] = []
        for element in firebaseData {
            denkmale.append(Denkmal(id: element["id"] as? String ?? "", // TODO make K constants
                markiert: false,
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
