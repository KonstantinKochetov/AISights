import MapKit
protocol MapUseCases {

    func loadMapsToRealm()

    func alreadyLoaded() -> Bool

    func syncFirebaseToRealm()

    func getUserId() -> String

    func createUserId()

    func cleanMapsRealm()

    func getDenkmale(success: @escaping ([Denkmal]) -> Void, failure: @escaping (Error) -> Void)

    func search(query: String, option: String, success: @escaping ([Denkmal]) -> Void, failure: @escaping (Error) -> Void)

    func bookmark(id: String,
                  success: @escaping (() -> Void),
                  failure: @escaping ((Error) -> Void))

    func like(id: String,
              userId: String,
              success: @escaping (() -> Void),
              failure: @escaping ((Error) -> Void))
}
