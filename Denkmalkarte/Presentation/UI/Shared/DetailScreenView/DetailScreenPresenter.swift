import Foundation

class DetailScreenPresenter: DetailScreenPresenterProtocol {

    var router: SharedDetailRouter
    var view: DetailScreenViewProtocol?
    let mapUseCases: MapUseCases

    required init(view: DetailScreenViewProtocol, router: SharedDetailRouter, mapUseCases: MapUseCases) {
        self.view = view
        self.router = router
        self.mapUseCases = mapUseCases
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

}
