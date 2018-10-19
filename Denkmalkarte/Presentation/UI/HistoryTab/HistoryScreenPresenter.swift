import Foundation

class HistoryScreenPresenter: HistoryScreenPresenterProtocol {

    let router: HistoryTabRouter
    let view: HistoryScreenViewProtocol

    required init(view: HistoryScreenViewProtocol, router: HistoryTabRouter) {
        self.view = view
        self.router = router
    }

}
