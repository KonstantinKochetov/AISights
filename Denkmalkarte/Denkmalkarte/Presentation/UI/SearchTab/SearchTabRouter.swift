//
//  SearchTabRouter.swift
//  Denkmalkarte
//
//  Created by Konstantin Kochetov on 11.10.18.
//  Copyright © 2018 htw.berlin. All rights reserved.
//

import UIKit

public class SearchTabRouter: SharedDetailRouter {
    
    public var childRouter: [Router] = []
    public var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    public func start() {
        let view = SearchScreenView.init(nibName: "SearchScreenView", bundle: Bundle(for: SearchTabRouter.self))
        let presenter = SearchScreenPresenter(view: view)
        presenter.router = self
        view.presenter = presenter
        navigationController.pushViewController(view, animated: false)
    }
    
    func showDetailView() {
        let view = DetailScreenView.init(nibName: "DetailScreenView", bundle: Bundle(for: MapTabRouter.self))
        let presenter = DetailScreenPresenter(view: view)
        presenter.router = self
        view.presenter = presenter
        navigationController.pushViewController(view, animated: true)
    }
}
