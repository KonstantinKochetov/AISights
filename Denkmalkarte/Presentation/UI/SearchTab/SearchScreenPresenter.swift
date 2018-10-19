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

    func showDetailView() {
        router.showDetailView()
    }
    
    func search(query: String,
                success: @escaping (([String]) -> Void),
                progress: @escaping ((Double) -> Void),
                failure: @escaping ((Error) -> Void)) {
        mapUseCases.getMapArrayData(query: query, success: success, progress: progress, failure: failure)
        
    }

}
