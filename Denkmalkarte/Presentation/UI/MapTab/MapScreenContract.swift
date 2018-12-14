import Foundation
import MapKit
protocol MapScreenViewProtocol: View {
    var presenter: MapScreenPresenterProtocol? { get set }
}

protocol MapScreenPresenterProtocol: Presenter {
    var router: MapTabRouter { get }
    var view: MapScreenViewProtocol { get }

    func showDetailView(_ denkmal: [Denkmal]?)

    func getDenkmale(success: @escaping ([MKAnnotation]) -> Void, failure: @escaping (Error) -> Void)
}
