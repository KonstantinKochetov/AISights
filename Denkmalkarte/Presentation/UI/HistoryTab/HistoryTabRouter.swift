import UIKit

public class HistoryTabRouter: NavigationRouter {

    public var childRouter: [Router] = []
    public var navigationController: UINavigationController

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    public func start() {
        let view = HistoryScreenView.init(nibName: "HistoryScreenView", bundle: Bundle(for: HistoryTabRouter.self))
        let presenter = HistoryScreenPresenter(view: view, router: self)
        view.presenter = presenter
        navigationController.pushViewController(view, animated: false)
}

}
