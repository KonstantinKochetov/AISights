//
//  InfoScreenPresenter.swift
//  Denkmalkarte
//
//  Created by Konstantin Kochetov on 13.10.18.
//  Copyright © 2018 htw.berlin. All rights reserved.
//

import Foundation

class InfoScreenPresenter: InfoScreenPresenterProtocol {
    
    let router: InfoTabRouter
    let view: InfoScreenViewProtocol
    
    required init(view: InfoScreenViewProtocol, router: InfoTabRouter) {
        self.view = view
        self.router = router
    }
    
}
