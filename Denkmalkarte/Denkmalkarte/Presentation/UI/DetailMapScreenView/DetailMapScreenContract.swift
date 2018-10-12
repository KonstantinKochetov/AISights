//
//  DetailMapScreenContract.swift
//  Denkmalkarte
//
//  Created by Konstantin Kochetov on 12.10.18.
//  Copyright © 2018 htw.berlin. All rights reserved.
//

import Foundation

protocol DetailMapScreenViewProtocol: View {
    var presenter: DetailMapScreenPresenterProtocol? { get set }
}

protocol DetailMapScreenPresenterProtocol: Presenter {
    var router: MapScreenRouter? { set get }
    var view: DetailMapScreenViewProtocol? { set get }
    
}
