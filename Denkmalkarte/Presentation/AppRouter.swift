import UIKit

class AppRouter: TabBarRouter {

    public enum TabTag: Int {
        case map = 0
        case search = 1
        case history = 2
        case info = 4
    }

    let tabBarController: UITabBarController
    var childRouter: [Router] = []
    let window: UIWindow

    var searchTabRouter: SearchTabRouter?

    init(window: UIWindow) {
        self.window = window
        self.tabBarController = UITabBarController()
    }

    func start() {
        showMapScreen()
    }

    func showMapScreen() {
        self.setUpTabBar()
        self.window.rootViewController = self.tabBarController
        self.window.makeKeyAndVisible()
    }

    private func setUpTabBar() {
        let mapTab = setUpMapTab()
        let searchTab = setUpSearchTab()
        let historyTab = setUpHistoryTab()
//        let infoTab = setUpInfoTab()

        tabBarController.viewControllers = [mapTab, searchTab, historyTab]
        childRouter.forEach { $0.start() }
    }

    private func setUpMapTab() -> UIViewController {
        let mapTabNavigationController = UINavigationController()

        mapTabNavigationController.tabBarItem = UITabBarItem(title: NSLocalizedString("Map", comment: ""), image: UIImage(named: "Map"), tag: TabTag.map.rawValue)
        let mapTabRouter = MapTabRouter(navigationController: mapTabNavigationController)
        childRouter.append(mapTabRouter)

        return mapTabNavigationController
    }

    private func setUpSearchTab() -> UIViewController {
        let searchTabNavigationController = UINavigationController()
        searchTabNavigationController.tabBarItem = UITabBarItem(tabBarSystemItem: .search, tag: TabTag.search.rawValue)

        let searchTabRouter = SearchTabRouter(navigationController: searchTabNavigationController)
        childRouter.append(searchTabRouter)

        return searchTabNavigationController
    }

    private func setUpHistoryTab() -> UIViewController {

        let historyTabNavigationController = UINavigationController()
        historyTabNavigationController.tabBarItem = UITabBarItem(tabBarSystemItem: .history, tag: TabTag.history.rawValue)

        let historyTabRouter = HistoryTabRouter(navigationController: historyTabNavigationController)
        childRouter.append(historyTabRouter)

        return historyTabNavigationController

    }

    private func setUpInfoTab() -> UIViewController {

        let infoTabNavigationController = UINavigationController()
        infoTabNavigationController.tabBarItem = UITabBarItem(tabBarSystemItem: .more, tag: TabTag.info.rawValue)

        let infoTabRouter = InfoTabRouter(navigationController: infoTabNavigationController)
        childRouter.append(infoTabRouter)

        return infoTabNavigationController

    }

}
