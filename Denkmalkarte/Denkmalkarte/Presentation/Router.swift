import UIKit

public protocol Router {
    var childRouter: [Router] { get }

    func start()
}

public protocol NavigationRouter: Router {
    var navigationController: UINavigationController { get }
}

public protocol TabBarRouter: Router {
    var tabBarController: UITabBarController { get }
}
