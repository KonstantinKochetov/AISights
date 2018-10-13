//
//  Router.swift
//  Denkmalkarte
//
//  Created by Konstantin Kochetov on 11.10.18.
//  Copyright © 2018 htw.berlin. All rights reserved.
//

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
