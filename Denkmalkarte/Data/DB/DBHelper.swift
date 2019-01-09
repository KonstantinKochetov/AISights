import MapKit
protocol DbHelper {

    func saveAll(_ denkmale: [Denkmal]) throws

    func save(_ event: Denkmal) throws

    func getAll() throws -> [Denkmal]

    func clean() throws

    func getDenkmale(success: @escaping ([Denkmal]) -> Void,
                     failure: @escaping (Error) -> Void)

    func alreadyLoaded() -> Bool

    func setAlreadyLoaded()

    func getUserId() -> String

    func createUserId()

    func search(query: String, option: String, success: @escaping ([Denkmal]) -> Void, failure: @escaping (Error) -> Void)

    func bookmark(id: String,
                  success: @escaping (() -> Void),
                  failure: @escaping ((Error) -> Void))

}
