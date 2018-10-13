//
//  HistoryScreenContract.swift
//  Denkmalkarte
//
//  Created by Konstantin Kochetov on 13.10.18.
//  Copyright © 2018 htw.berlin. All rights reserved.
//

import Foundation

protocol HistoryScreenViewProtocol: View {
    var presenter: HistoryScreenPresenterProtocol? { get set }
}

protocol HistoryScreenPresenterProtocol: Presenter {
    var router: HistoryTabRouter { set get }
    var view: HistoryScreenViewProtocol? { set get }
    
}
