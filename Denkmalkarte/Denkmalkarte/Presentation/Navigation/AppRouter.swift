//
//  AppRouter.swift
//  Denkmalkarte
//
//  Created by Konstantin Kochetov on 11.10.18.
//  Copyright © 2018 htw.berlin. All rights reserved.
//

import UIKit

class AppRouter: TabBarRouter {
    
    public enum TabTag: Int {
        case map = 0
        case search = 2
}

    var tabBarController: UITabBarController
    var childRouter: [Router] = []
    var window: UIWindow
    
    var searchTabRouter: SearchTabRouter? = nil
    
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
        
        tabBarController.viewControllers = [mapTab, searchTab]
        childRouter.forEach { $0.start() }
    }
    
    private func setUpMapTab() -> UIViewController {
        let mapTabNavigationController = UINavigationController()
        mapTabNavigationController.tabBarItem = UITabBarItem(title: "Map", image: UIImage(named: "Map"), tag: TabTag.map.rawValue)
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
    
    
    

}
