//
//  InfoPinCell.swift
//  Denkmalkarte
//
//  Created by Konstantin Kochetov on 16.11.18.
//  Copyright © 2018 htw.berlin. All rights reserved.
//

import UIKit

class InfoPinCell: UITableViewCell {

    @IBOutlet weak var labelView: UILabel!
    
    public static let identifier = "InfoPinCell"
    
    public func set(result: String) {
        labelView.text = result
    }
    
}
