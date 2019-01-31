import UIKit

public class HistoryTabRouter: SharedDetailRouter {

    public var childRouter: [Router] = []
    public var navigationController: UINavigationController

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    public func start() {
        let view = HistoryScreenView.init(nibName: "HistoryScreenView", bundle: Bundle(for: HistoryTabRouter.self))
        let presenter = HistoryScreenPresenter(view: view, router: self, mapUseCases: assembler.resolve())
        view.presenter = presenter
        navigationController.pushViewController(view, animated: false)
}

    func showDetailView(_ denkmal: Denkmal?) {
        let view = DetailScreenView.init(nibName: "DetailScreenView", bundle: Bundle(for: MapTabRouter.self))
        let presenter = DetailScreenPresenter(view: view, router: self, mapUseCases: assembler.resolve())
        view.presenter = presenter
        if let denkmal = denkmal {
            view.monument = denkmal
        }
        navigationController.present(view, animated: true, completion: nil)
    }

}



