class ApiHelperImpl: ApiHelper {

    func getMapData(success: @escaping (String) -> Void,
                    failure: @escaping (Error) -> Void) {
        // mocking
        success("map data from api")
    }
    
    func getMapArrayData(query: String,
                         success: @escaping (([String]) -> Void),
                         progress: @escaping ((Double) -> Void),
                         failure: @escaping ((Error) -> Void)) {
        let data = ["1", "2", "3"]
        success(data)
    }

}
