//
//  MapTabContract.swift
//  Denkmalkarte
//
//  Created by Konstantin Kochetov on 11.10.18.
//  Copyright © 2018 htw.berlin. All rights reserved.
//

import Foundation

protocol MapScreenViewContract: View {
    var presenter: MapScreenPresenterContract? { get set }
}

protocol MapScreenPresenterContract: Presenter {
    var router: MapScreenRouter? { set get }
    var view: MapScreenViewContract? { set get }
    
}
