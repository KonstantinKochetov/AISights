import MapKit
protocol MapUseCases {

    func loadMapsToRealm()

    func cleanMapsRealm()

    func getDenkmale(success: @escaping ([Denkmal]) -> Void, failure: @escaping (Error) -> Void)
}
