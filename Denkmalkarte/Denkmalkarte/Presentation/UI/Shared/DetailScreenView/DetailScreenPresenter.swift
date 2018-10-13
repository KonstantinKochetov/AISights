//
//  DetailScreenPresenter.swift
//  Denkmalkarte
//
//  Created by Konstantin Kochetov on 12.10.18.
//  Copyright © 2018 htw.berlin. All rights reserved.
//

import Foundation

class DetailScreenPresenter: DetailScreenPresenterProtocol {
    var router: SharedDetailRouter?
    var view: DetailScreenViewProtocol?
    
    required init(view: DetailScreenViewProtocol) {
        self.view = view
    }
    
    
}
