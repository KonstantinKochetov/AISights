import UIKit

public class SearchTabRouter: SharedDetailRouter {
    public var childRouter: [Router] = []
    public var navigationController: UINavigationController

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    public func start() {
        let view = SearchScreenView.init(nibName: "SearchScreenView", bundle: Bundle(for: SearchTabRouter.self))
        let presenter = SearchScreenPresenter(view: view, router: self, mapUseCases: assembler.resolve())
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
        navigationController.pushViewController(view, animated: true)
    }
}
