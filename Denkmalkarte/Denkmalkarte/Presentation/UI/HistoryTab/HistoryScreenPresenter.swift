//
//  HistoryScreenPresenter.swift
//  Denkmalkarte
//
//  Created by Konstantin Kochetov on 13.10.18.
//  Copyright © 2018 htw.berlin. All rights reserved.
//

import Foundation

class HistoryScreenPresenter: HistoryScreenPresenterProtocol {

    let router: HistoryTabRouter
    let view: HistoryScreenViewProtocol

    required init(view: HistoryScreenViewProtocol, router: HistoryTabRouter) {
        self.view = view
        self.router = router
    }

}
