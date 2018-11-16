import MapKit
public class MapInteractor: MapUseCases {

    let dbHelper: DbHelper
    let apiHelper: ApiHelper

    init(dbHelper: DbHelper, apiHelper: ApiHelper) {
        self.dbHelper = dbHelper
        self.apiHelper = apiHelper
    }

    func getMapArrayData(query: String,
                         success: @escaping (([String]) -> Void),
                         progress: @escaping ((Double) -> Void),
                         failure: @escaping ((Error) -> Void)) {
        apiHelper.getMapArrayData(query: query, success: success, progress: progress, failure: failure)
    }

    func getPointAnnotation(success: @escaping ([MKAnnotation]) -> Void, failure: @escaping (Error) -> Void) {
        if let ponitAnno = dbHelper.getPointAnnotation() {
            success(ponitAnno)
        } else {
            failure(NSError(domain: "", code: 406, userInfo: nil))
        }
    }

}
