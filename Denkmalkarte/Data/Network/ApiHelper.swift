import Foundation

protocol ApiHelper {

    func getFirebaseData(success: @escaping ([[String: AnyObject]]) -> Void,
                         failure: @escaping (Error) -> Void)

    func like(id: String,
              userId: String,
              success: @escaping (() -> Void),
              failure: @escaping ((Error) -> Void))
}
