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
    
    func cleanMapsRealm() {
        do {
            try dbHelper.clean()
        } catch {
            print(error)
        }
    }
    
    func getMapArrayData(query: String,
                         success: @escaping (([String]) -> Void),
                         progress: @escaping ((Double) -> Void),
                         failure: @escaping ((Error) -> Void)) {
        apiHelper.getMapArrayData(query: query, success: success, progress: progress, failure: failure)
    }
    
    func getDenkmale(success: @escaping ([Denkmal]) -> Void,
                     failure: @escaping (Error) -> Void) {
        dbHelper.getDenkmale(success: success, failure: failure)
    }
}
