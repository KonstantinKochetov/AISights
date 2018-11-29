import UIKit

public class MapTabRouter: SharedDetailRouter {

    public var childRouter: [Router] = []
    public var navigationController: UINavigationController

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    public func start() {
        let view = MapScreenView.init(nibName: "MapScreenView", bundle: Bundle(for: MapTabRouter.self))
        let presenter = MapScreenPresenter(view: view, router: self, mapUseCases: assembler.resolve())
        view.presenter = presenter
        navigationController.pushViewController(view, animated: false)
    }

    public func showDetailView(_ withId: [Int]) {
        let view = DetailScreenView.init(nibName: "DetailScreenView", bundle: Bundle(for: MapTabRouter.self))
        let presenter = DetailScreenPresenter(view: view, router: self)
        view.presenter = presenter
        navigationController.present(view, animated: true, completion: nil)
    }
}
