//
//  SearchScreenRouter.swift
//  Denkmalkarte
//
//  Created by Konstantin Kochetov on 12.10.18.
//  Copyright © 2018 htw.berlin. All rights reserved.
//

import UIKit

public class SearchScreenRouter: NavigationRouter {
    public var childRouter: [Router] = []
    public var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    public func start() {
        let view = SearchScreenView.init(nibName: "SearchScreenView", bundle: Bundle(for: SearchScreenRouter.self))
        let presenter = SearchScreenPresenter(view: view)
        presenter.router = self
        view.presenter = presenter
        navigationController.pushViewController(view, animated: false)
    }
    
}
