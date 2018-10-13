//
//  SearchScreenPresenter.swift
//  Denkmalkarte
//
//  Created by Konstantin Kochetov on 12.10.18.
//  Copyright © 2018 htw.berlin. All rights reserved.
//

import Foundation

class SearchScreenPresenter: SearchScreenPresenterProtocol {

    let router: SearchTabRouter
    let view: SearchScreenViewProtocol

    required init(view: SearchScreenViewProtocol, router: SearchTabRouter) {
        self.view = view
        self.router = router

    }

    func showDetailView() {
        router.showDetailView()
    }

}
