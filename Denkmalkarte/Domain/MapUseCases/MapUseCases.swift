import MapKit
protocol MapUseCases {
    
    func getMapArrayData(query: String,
                         success: @escaping (([String]) -> Void),
                         progress: @escaping ((Double) -> Void),
                         failure: @escaping ((Error) -> Void))
    
    func loadMapsToRealm()
    
    func cleanMapsRealm()
    
    func getDenkmale(success: @escaping ([Denkmal]) -> Void, failure: @escaping (Error) -> Void)
}
