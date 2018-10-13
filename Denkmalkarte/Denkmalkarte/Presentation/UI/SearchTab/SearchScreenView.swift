//
//  SearchScreenView.swift
//  Denkmalkarte
//
//  Created by Konstantin Kochetov on 12.10.18.
//  Copyright © 2018 htw.berlin. All rights reserved.
//

import UIKit

public class SearchScreenView: UIViewController, SearchScreenViewProtocol {
    
    var presenter: SearchScreenPresenterProtocol? = nil
    
    @IBAction func goToDetailButton(_ sender: Any) {
        presenter?.showDetailView()
    }

}



