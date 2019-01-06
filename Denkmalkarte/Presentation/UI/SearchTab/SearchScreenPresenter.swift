import Foundation

class SearchScreenPresenter: SearchScreenPresenterProtocol {
    func showDetailView(_ denkmal: Denkmal?) {
        router.showDetailView(denkmal)
    }
    let router: SearchTabRouter
    let view: SearchScreenViewProtocol
     let mapUseCases: MapUseCases

    required init(view: SearchScreenViewProtocol, router: SearchTabRouter, mapUseCases: MapUseCases) {
        self.view = view
        self.router = router
        self.mapUseCases = mapUseCases
    }

    func search(query: String,
                success: @escaping (([Denkmal]) -> Void),
                failure: @escaping ((Error) -> Void)) {
        mapUseCases.getDenkmale(success: success, failure: failure)

    }

}
