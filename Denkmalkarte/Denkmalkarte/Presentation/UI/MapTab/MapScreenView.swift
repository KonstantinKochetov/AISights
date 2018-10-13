//
//  MapScreenView.swift
//  Denkmalkarte
//
//  Created by Konstantin Kochetov on 12.10.18.
//  Copyright © 2018 htw.berlin. All rights reserved.
//

import UIKit

public class MapScreenView: UIViewController, MapScreenViewProtocol {
    @IBOutlet weak var dataLabel: UILabel!

    var presenter: MapScreenPresenterProtocol?

    @IBAction func mapTestButton(_ sender: Any) {
        presenter?.showDetailView()
    }
    @IBAction func dataTestButton(_ sender: Any) {
        presenter?.getMapData(success: { result in
            self.dataLabel.text = result

        }, failure: { error in
            self.dataLabel.text = error.localizedDescription

        }
        )
    }
}
