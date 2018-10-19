class ApiHelperImpl: ApiHelper {

    func getMapData(success: @escaping (String) -> Void,
                    failure: @escaping (Error) -> Void) {
        // mocking
        success("map data from api")
    }

}
