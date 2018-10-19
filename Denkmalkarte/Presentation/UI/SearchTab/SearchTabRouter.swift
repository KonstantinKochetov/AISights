import UIKit

public class SearchTabRouter: SharedDetailRouter {

    public var childRouter: [Router] = []
    public var navigationController: UINavigationController

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    public func start() {
        let view = SearchScreenView.init(nibName: "SearchScreenView", bundle: Bundle(for: SearchTabRouter.self))
        let presenter = SearchScreenPresenter(view: view, router: self)
        view.presenter = presenter
        navigationController.pushViewController(view, animated: false)
    }

    func showDetailView() {
        let view = DetailScreenView.init(nibName: "DetailScreenView", bundle: Bundle(for: MapTabRouter.self))
        let presenter = DetailScreenPresenter(view: view, router: self)
        view.presenter = presenter
        navigationController.pushViewController(view, animated: true)
    }
}
