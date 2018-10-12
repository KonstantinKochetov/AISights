//
//  MapScreenRouter.swift
//  Denkmalkarte
//
//  Created by Konstantin Kochetov on 11.10.18.
//  Copyright © 2018 htw.berlin. All rights reserved.
//

import UIKit

public class MapScreenRouter: NavigationRouter {
    public var childRouter: [Router] = []
    public var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    public func start() {
        let view = MapScreenView.init(nibName: "MapScreenView", bundle: Bundle(for: MapScreenRouter.self))
        let presenter = MapScreenPresenter(view: view)
        presenter.router = self
        view.presenter = presenter
        navigationController.pushViewController(view, animated: false)
    }
    
    public func showDetailMapView() {
        let view = DetailMapScreenView.init(nibName: "DetailMapScreenView", bundle: Bundle(for: MapScreenRouter.self))
        let presenter = DetailMapScreenPresenter(view: view)
        presenter.router = self
        view.presenter = presenter
        navigationController.pushViewController(view, animated: false)
    }
    
}
