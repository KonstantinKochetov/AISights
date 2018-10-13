//
//  MapScreenPresenter.swift
//  Denkmalkarte
//
//  Created by Konstantin Kochetov on 11.10.18.
//  Copyright © 2018 htw.berlin. All rights reserved.
//

import Foundation

class MapScreenPresenter: MapScreenPresenterProtocol {
    var router: MapTabRouter?
    var view: MapScreenViewProtocol?
    
    required init(view: MapScreenViewProtocol) {
        self.view = view
    }
    
    func showDetailView() {
        router?.showDetailView()
    }
    
    
    
    
}
