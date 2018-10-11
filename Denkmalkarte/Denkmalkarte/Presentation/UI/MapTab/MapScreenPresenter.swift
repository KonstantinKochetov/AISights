//
//  MapScreenPresenter.swift
//  Denkmalkarte
//
//  Created by Konstantin Kochetov on 11.10.18.
//  Copyright © 2018 htw.berlin. All rights reserved.
//

import Foundation

class MapScreenPresenter: MapScreenPresenterContract {
    var router: MapScreenRouter?
    var view: MapScreenViewContract?
    
    required init(view: MapScreenViewContract) {
        self.view = view
    }
    
    
}
