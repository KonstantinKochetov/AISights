import Foundation

protocol MapScreenViewProtocol: View {
    var presenter: MapScreenPresenterProtocol? { get set }
}

protocol MapScreenPresenterProtocol: Presenter {
    var router: MapTabRouter { get }
    var view: MapScreenViewProtocol { get }

    func showDetailView()
    func getMapData(success: @escaping (String) -> Void,
                    failure: @escaping (Error) -> Void)
}
