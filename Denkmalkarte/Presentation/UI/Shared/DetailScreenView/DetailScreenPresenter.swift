import Foundation
import UIKit

class DetailScreenPresenter: DetailScreenPresenterProtocol {    

    var router: SharedDetailRouter
    var view: DetailScreenViewProtocol?
    let mapUseCases: MapUseCases

    required init(view: DetailScreenViewProtocol, router: SharedDetailRouter, mapUseCases: MapUseCases) {
        self.view = view
        self.router = router
        self.mapUseCases = mapUseCases
    }

    func getUserId() -> String {
        return mapUseCases.getUserId()
    }

    func bookmark(id: String,
                  success: @escaping (() -> Void),
                  failure: @escaping ((Error) -> Void)) {
        mapUseCases.bookmark(id: id, success: success, failure: failure)
    }

    func like(id: String,
              userId: String,
              success: @escaping (() -> Void),
              failure: @escaping ((Error) -> Void)) {
        mapUseCases.like(id: id, userId: userId, success: success, failure: failure)
    }
    
    func upload(_ image: UIImage,
                withMonumentId monumentId: String,
                progressHandler: @escaping ((Float) -> Void),
                success: @escaping (() -> Void),
                failure: @escaping ((Error) -> Void)) {
        mapUseCases.upload(image, withMonumentId: monumentId, progressHandler: progressHandler, success: success, failure: failure)
    }

}
