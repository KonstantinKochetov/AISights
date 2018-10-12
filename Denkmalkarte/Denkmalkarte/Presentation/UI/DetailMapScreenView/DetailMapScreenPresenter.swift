//
//  DetailMapScreenPresenter.swift
//  Denkmalkarte
//
//  Created by Konstantin Kochetov on 12.10.18.
//  Copyright © 2018 htw.berlin. All rights reserved.
//

import Foundation

class DetailMapScreenPresenter: DetailMapScreenPresenterProtocol {
    var router: MapScreenRouter?
    var view: DetailMapScreenViewProtocol?
    
    required init(view: DetailMapScreenViewProtocol) {
        self.view = view
    }
    
    
}
