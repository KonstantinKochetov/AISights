//
//  HistoryScreenPresenter.swift
//  Denkmalkarte
//
//  Created by Konstantin Kochetov on 13.10.18.
//  Copyright © 2018 htw.berlin. All rights reserved.
//

import Foundation

class HistoryScreenPresenter: HistoryScreenPresenterProtocol {
    var router: HistoryTabRouter?
    var view: HistoryScreenViewProtocol?
    
    required init(view: HistoryScreenViewProtocol) {
        self.view = view
    }
    
}

