//
//  MapScreenView.swift
//  Denkmalkarte
//
//  Created by Konstantin Kochetov on 12.10.18.
//  Copyright © 2018 htw.berlin. All rights reserved.
//

import UIKit

public class MapScreenView: UIViewController, MapScreenViewProtocol {
    
    var presenter: MapScreenPresenterProtocol? = nil
    
    @IBAction func mapTestButton(_ sender: Any) {
        print("testMapButton, going to DetailMapView")
        presenter?.showDetailMapView()
    }
    @IBAction func dataTestButton(_ sender: Any) {
        print("testDataButton, getting mocked data to display")
//        presenter?.getMockedData()
    }
}
