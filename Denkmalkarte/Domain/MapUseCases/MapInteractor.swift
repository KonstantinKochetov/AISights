import MapKit
import RealmSwift

public class MapInteractor: MapUseCases {

    let dbHelper: DbHelper
    let apiHelper: ApiHelper
    let parser: Parser

    init(dbHelper: DbHelper, apiHelper: ApiHelper, parser: Parser) {
        self.dbHelper = dbHelper
        self.apiHelper = apiHelper
        self.parser = parser
    }

    func loadMapsToRealm() {
        let denkmale = parser.readJSON()
        do {
            try dbHelper.saveAll(denkmale)
            dbHelper.setAlreadyLoaded()
        } catch {
            debugPrint("fail to load local file to realm")
        }
    }

    func alreadyLoaded() -> Bool {
        return dbHelper.alreadyLoaded()
    }

    func syncFirebaseToRealm() {
        apiHelper.getFirebaseData(success: { result in
            do {
                let denkmale = self.parser.convertDataToDenkmal(result)
                try self.dbHelper.saveAll(denkmale)
            } catch {
                debugPrint("fail save firebase objects to Realm")
            }
        }, failure: { error in
            debugPrint("fail to sync Realm with Firebase: \(error)")
        })
    }

    func cleanMapsRealm() {
        do {
            try dbHelper.clean()
        } catch {
            debugPrint(error)
        }
    }

    func getDenkmale(success: @escaping ([Denkmal]) -> Void,
                     failure: @escaping (Error) -> Void) {
        dbHelper.getDenkmale(success: success, failure: failure)
    }

    func search(query: String, option: String, success: @escaping ([Denkmal]) -> Void, failure: @escaping (Error) -> Void) {
        dbHelper.search(query: query, option: option, success: success, failure: failure)
    }

    func bookmark(id: String,
                  success: @escaping (() -> Void),
                  failure: @escaping ((Error) -> Void)) {
        dbHelper.bookmark(id: id, success: success, failure: failure)
    }
}
