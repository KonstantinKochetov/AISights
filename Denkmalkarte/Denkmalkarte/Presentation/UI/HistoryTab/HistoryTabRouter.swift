//
//  HistoryTabRouter.swift
//  Denkmalkarte
//
//  Created by Konstantin Kochetov on 13.10.18.
//  Copyright © 2018 htw.berlin. All rights reserved.
//


import UIKit

public class HistoryTabRouter: NavigationRouter {
    
    public var childRouter: [Router] = []
    public var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    public func start() {
        let view = HistoryScreenView.init(nibName: "HistoryScreenView", bundle: Bundle(for: HistoryTabRouter.self))
        let presenter = HistoryScreenPresenter(view: view)
        presenter.router = self
        view.presenter = presenter
        navigationController.pushViewController(view, animated: false)
}

}
