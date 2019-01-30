import Foundation

class HistoryScreenPresenter: HistoryScreenPresenterProtocol {



    let router: HistoryTabRouter
    let view: HistoryScreenViewProtocol
    let mapUseCases: MapUseCases

    required init(view: HistoryScreenViewProtocol, router: HistoryTabRouter, mapUseCases: MapUseCases) {
        self.view = view
        self.router = router
        self.mapUseCases = mapUseCases

    }

    func showDetailView(_ denkmal: Denkmal?) {
        router.showDetailView(denkmal);
    }

    func search(query: Bool,
                option: String,
                success: @escaping (([Denkmal]) -> Void),
                failure: @escaping ((Error) -> Void)) {
        mapUseCases.search(query: query, option: option, success: success, failure: failure)

    }

    func search(query: String,
                option: String,
                success: @escaping (([Denkmal]) -> Void),
                failure: @escaping ((Error) -> Void)) {
        mapUseCases.search(query: query, option: option, success: success, failure: failure)

    }

}
