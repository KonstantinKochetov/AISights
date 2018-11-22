import Foundation
import MapKit
class MapScreenPresenter: MapScreenPresenterProtocol {

    let router: MapTabRouter
    let view: MapScreenViewProtocol
    let mapUseCases: MapUseCases

    required init(view: MapScreenViewProtocol, router: MapTabRouter, mapUseCases: MapUseCases) {
        self.view = view
        self.router = router
        self.mapUseCases = mapUseCases
    }

    func showDetailView(_ withId: [Int]) {
        router.showDetailView(withId)
    }

    func getDenkmale(success: @escaping ([MKAnnotation]) -> Void, failure: @escaping (Error) -> Void) {
        mapUseCases.getDenkmale(success: success, failure: failure)
    }

}
