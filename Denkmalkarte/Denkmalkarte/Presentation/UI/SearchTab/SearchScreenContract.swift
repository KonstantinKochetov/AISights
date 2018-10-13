//
//  SearchScreenContract.swift
//  Denkmalkarte
//
//  Created by Konstantin Kochetov on 12.10.18.
//  Copyright © 2018 htw.berlin. All rights reserved.
//

import Foundation

protocol SearchScreenViewProtocol: View {
    var presenter: SearchScreenPresenterProtocol? { get set }
}

protocol SearchScreenPresenterProtocol: Presenter {
    var router: SearchTabRouter { get }
    var view: SearchScreenViewProtocol { get }
    
    func showDetailView()
    
}

