//
//  SearchTabRouter.swift
//  Denkmalkarte
//
//  Created by Konstantin Kochetov on 11.10.18.
//  Copyright © 2018 htw.berlin. All rights reserved.
//

import UIKit

public class SearchTabRouter: NavigationRouter {
    public var childRouter: [Router] = []
    public var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    public func start() {
        let router = SearchScreenRouter(navigationController: self.navigationController)
        childRouter.append(router)
        router.start()
    }
}
