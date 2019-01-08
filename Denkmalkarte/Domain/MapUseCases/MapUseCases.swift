import MapKit
protocol MapUseCases {

    func loadMapsToRealm()

    func alreadyLoaded() -> Bool

    func syncFirebaseToRealm()

    func cleanMapsRealm()

    func getDenkmale(success: @escaping ([Denkmal]) -> Void, failure: @escaping (Error) -> Void)

    func search(query: String, option: String, success: @escaping ([Denkmal]) -> Void, failure: @escaping (Error) -> Void)
}
