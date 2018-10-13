//
//  MapScreenPresenter.swift
//  Denkmalkarte
//
//  Created by Konstantin Kochetov on 11.10.18.
//  Copyright © 2018 htw.berlin. All rights reserved.
//

import Foundation

class MapScreenPresenter: MapScreenPresenterProtocol {
    
    let router: MapTabRouter
    let view: MapScreenViewProtocol
    let mapUseCases: MapUseCases
    
    required init(view: MapScreenViewProtocol, router: MapTabRouter, mapUseCases: MapUseCases) {
        self.view = view
        self.router = router
        self.mapUseCases = mapUseCases
    }
    
    func showDetailView() {
        router.showDetailView()
    }
    
    func getMapData(success: @escaping (String)->(),
                    failure: @escaping (Error)->()) {
        mapUseCases.getMapData(success: success, failure: failure)
    }
    
    
    
    
}
