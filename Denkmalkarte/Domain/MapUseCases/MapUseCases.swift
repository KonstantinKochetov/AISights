import MapKit
protocol MapUseCases {

    func getMapData(success: @escaping (String) -> Void,
                    failure: @escaping (Error) -> Void)

     func getPointAnnotation(success: @escaping ([MKAnnotation]) -> Void, failure: @escaping (Error) -> Void)
}
