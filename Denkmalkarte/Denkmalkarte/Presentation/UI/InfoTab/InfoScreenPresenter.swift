import Foundation

class InfoScreenPresenter: InfoScreenPresenterProtocol {

    let router: InfoTabRouter
    let view: InfoScreenViewProtocol

    required init(view: InfoScreenViewProtocol, router: InfoTabRouter) {
        self.view = view
        self.router = router
    }

}
