import Foundation

class DetailScreenPresenter: DetailScreenPresenterProtocol {

    var router: SharedDetailRouter
    var view: DetailScreenViewProtocol?

    required init(view: DetailScreenViewProtocol, router: SharedDetailRouter) {
        self.view = view
        self.router = router
    }

}
