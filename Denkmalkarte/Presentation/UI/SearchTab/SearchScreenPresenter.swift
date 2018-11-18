import Foundation

class SearchScreenPresenter: SearchScreenPresenterProtocol {

    let router: SearchTabRouter
    let view: SearchScreenViewProtocol
     let mapUseCases: MapUseCases

    required init(view: SearchScreenViewProtocol, router: SearchTabRouter, mapUseCases: MapUseCases) {
        self.view = view
        self.router = router
        self.mapUseCases = mapUseCases
    }

    func showDetailView(_ withId: [Int]) {
        router.showDetailView(withId)
    }

    func search(query: String,
                success: @escaping (([Denkmal]) -> Void),
                failure: @escaping ((Error) -> Void)) {
        mapUseCases.getDenkmale(success: success, failure: failure)

    }

}
