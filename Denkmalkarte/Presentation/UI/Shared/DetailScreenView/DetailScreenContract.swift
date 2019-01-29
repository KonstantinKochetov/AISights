import Foundation
import UIKit

protocol DetailScreenViewProtocol: View {
    var presenter: DetailScreenPresenterProtocol? { get set }

}

protocol DetailScreenPresenterProtocol: Presenter {
    var router: SharedDetailRouter { get set }
    var view: DetailScreenViewProtocol? { get set }

    func getUserId() -> String

    func bookmark(id: String,
                  success: @escaping (() -> Void),
                  failure: @escaping ((Error) -> Void))

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
