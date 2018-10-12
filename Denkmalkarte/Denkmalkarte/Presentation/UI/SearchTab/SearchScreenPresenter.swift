//
//  SearchScreenPresenter.swift
//  Denkmalkarte
//
//  Created by Konstantin Kochetov on 12.10.18.
//  Copyright © 2018 htw.berlin. All rights reserved.
//

import Foundation

class SearchScreenPresenter: SearchScreenPresenterContract {
    var router: SearchScreenRouter?
    var view: SearchScreenViewContract?
    
    required init(view: SearchScreenViewContract) {
        self.view = view
    }
    
    
}
