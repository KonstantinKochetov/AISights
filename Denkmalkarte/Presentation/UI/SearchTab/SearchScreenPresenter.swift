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

    func showDetailView(_ denkmal: Denkmal?) {
        router.showDetailView(denkmal)
    }

    func search(query: String,
                option: String,
                success: @escaping (([Denkmal]) -> Void),
                failure: @escaping ((Error) -> Void)) {
        mapUseCases.search(query: query, option: option, success: success, failure: failure)

    }

}
