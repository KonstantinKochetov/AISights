import MapKit
protocol MapUseCases {

    func getMapArrayData(query: String,
                         success: @escaping (([String]) -> Void),
                         progress: @escaping ((Double) -> Void),
                         failure: @escaping ((Error) -> Void))

     func getPointAnnotation(success: @escaping ([MKAnnotation]) -> Void, failure: @escaping (Error) -> Void)
}
