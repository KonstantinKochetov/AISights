//
//  SearchScreenContract.swift
//  Denkmalkarte
//
//  Created by Konstantin Kochetov on 12.10.18.
//  Copyright © 2018 htw.berlin. All rights reserved.
//

import Foundation

protocol SearchScreenViewContract: View {
    var presenter: SearchScreenPresenterContract? { get set }
}

protocol SearchScreenPresenterContract: Presenter {
    var router: SearchScreenRouter? { set get }
    var view: SearchScreenViewContract? { set get }
    
}

