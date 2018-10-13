//
//  InfoScreenContract.swift
//  Denkmalkarte
//
//  Created by Konstantin Kochetov on 13.10.18.
//  Copyright © 2018 htw.berlin. All rights reserved.
//

import Foundation

protocol InfoScreenViewProtocol: View {
    var presenter: InfoScreenPresenterProtocol? { get set }
}

protocol InfoScreenPresenterProtocol: Presenter {
    var router: InfoTabRouter? { set get }
    var view: InfoScreenViewProtocol? { set get }
    
}
