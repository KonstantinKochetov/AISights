//
//  DetailScreenContract.swift
//  Denkmalkarte
//
//  Created by Konstantin Kochetov on 12.10.18.
//  Copyright © 2018 htw.berlin. All rights reserved.
//

import Foundation

protocol DetailScreenViewProtocol: View {
    var presenter: DetailScreenPresenterProtocol? { get set }
}

protocol DetailScreenPresenterProtocol: Presenter {
    var router: SharedDetailRouter { get set }
    var view: DetailScreenViewProtocol? { get set }

}
