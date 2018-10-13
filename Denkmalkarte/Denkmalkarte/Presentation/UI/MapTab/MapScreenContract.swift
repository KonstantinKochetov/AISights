//
//  MapTabContract.swift
//  Denkmalkarte
//
//  Created by Konstantin Kochetov on 11.10.18.
//  Copyright © 2018 htw.berlin. All rights reserved.
//

import Foundation

protocol MapScreenViewProtocol: View {
    var presenter: MapScreenPresenterProtocol? { get set }
}

protocol MapScreenPresenterProtocol: Presenter {
    var router: MapTabRouter { get }
    var view: MapScreenViewProtocol { get }
    
    func showDetailView()
    func getMapData(success: @escaping (String)->(),
                    failure: @escaping (Error)->())
}
