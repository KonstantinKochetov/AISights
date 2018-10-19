import Foundation

class MapScreenPresenter: MapScreenPresenterProtocol {

    let router: MapTabRouter
    let view: MapScreenViewProtocol
    let mapUseCases: MapUseCases

    required init(view: MapScreenViewProtocol, router: MapTabRouter, mapUseCases: MapUseCases) {
        self.view = view
        self.router = router
        self.mapUseCases = mapUseCases
    }

    func showDetailView() {
        router.showDetailView()
    }

    func getMapData(success: @escaping (String) -> Void,
                    failure: @escaping (Error) -> Void) {
        mapUseCases.getMapData(success: success, failure: failure)
    }

}
