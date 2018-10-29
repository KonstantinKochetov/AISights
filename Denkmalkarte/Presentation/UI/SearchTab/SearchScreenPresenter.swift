import Foundation

class SearchScreenPresenter: SearchScreenPresenterProtocol {

    let router: SearchTabRouter
    let view: SearchScreenViewProtocol

    required init(view: SearchScreenViewProtocol, router: SearchTabRouter) {
        self.view = view
        self.router = router

    }

    func showDetailView(_ withId: [Int]) {
        router.showDetailView(withId)
    }

}
