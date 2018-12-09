import MapKit
protocol MapUseCases {

    func loadMapsToRealm()

    func syncFirebaseToRealm()

    func cleanMapsRealm()

    func getDenkmale(success: @escaping ([Denkmal]) -> Void, failure: @escaping (Error) -> Void)
}
