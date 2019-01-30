import Foundation
import UIKit

protocol ApiHelper {

    func getFirebaseData(success: @escaping ([[String: AnyObject]]) -> Void,
                         failure: @escaping (Error) -> Void)

    func like(id: String,
              userId: String,
              success: @escaping (() -> Void),
              failure: @escaping ((Error) -> Void))
    
    func upload(_ image: UIImage,
                withMonumentId monumentId: String,
                progressHandler: @escaping ((Float) -> Void),
                success: @escaping (() -> Void),
                failure: @escaping ((Error) -> Void))
}
