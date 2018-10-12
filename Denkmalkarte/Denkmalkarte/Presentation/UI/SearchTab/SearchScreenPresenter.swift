//
//  SearchScreenPresenter.swift
//  Denkmalkarte
//
//  Created by Konstantin Kochetov on 12.10.18.
//  Copyright © 2018 htw.berlin. All rights reserved.
//

import Foundation

class SearchScreenPresenter: SearchScreenPresenterProtocol {
    var router: SearchScreenRouter?
    var view: SearchScreenViewProtocol?
    
    required init(view: SearchScreenViewProtocol) {
        self.view = view
    }
    
    
}
