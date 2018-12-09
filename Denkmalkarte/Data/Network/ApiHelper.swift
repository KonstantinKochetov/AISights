import Foundation

protocol ApiHelper {

    func getFirebaseData(success: @escaping (NSArray) -> Void,
                     failure: @escaping (Error) -> Void)

}
