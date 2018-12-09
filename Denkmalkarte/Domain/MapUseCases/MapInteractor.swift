import MapKit
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
        let parser = Parser()
        if let denkmale = parser.readXML() {
            do {
                try dbHelper.saveAll(denkmale)
            } catch {
                print("fail to load xml to realm")
            }
        } else {
            print("fail to parse xml")
        }
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

    private func convertFirebaseDataToDenkmal(_ firebaseData: NSArray) -> [Denkmal] {
        var denkmale: [Denkmal] = []
        for element in firebaseData {
            
        }
        return []
    }
}
