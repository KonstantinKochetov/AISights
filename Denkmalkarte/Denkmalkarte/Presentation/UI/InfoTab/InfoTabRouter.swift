//
//  InfoTabRouter.swift
//  Denkmalkarte
//
//  Created by Konstantin Kochetov on 13.10.18.
//  Copyright © 2018 htw.berlin. All rights reserved.
//

import UIKit

public class InfoTabRouter: NavigationRouter {
    
    public var childRouter: [Router] = []
    public var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    public func start() {
        let view = InfoScreenView.init(nibName: "InfoScreenView", bundle: Bundle(for: InfoTabRouter.self))
        let presenter = InfoScreenPresenter(view: view, router: self)
        view.presenter = presenter
        navigationController.pushViewController(view, animated: false)
    }
    
}
