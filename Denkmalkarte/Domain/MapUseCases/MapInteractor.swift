public class MapInteractor: MapUseCases {

    let dbHelper: DbHelper
    let apiHelper: ApiHelper

    init(dbHelper: DbHelper, apiHelper: ApiHelper) {
        self.dbHelper = dbHelper
        self.apiHelper = apiHelper
    }

    func getMapData(success: @escaping (String) -> Void,
                    failure: @escaping (Error) -> Void) {
        // mocking
        if let mapData = dbHelper.getMapData() {
            success(mapData)
        } else {
            apiHelper.getMapData(success: success, failure: failure)
        }

    }

}