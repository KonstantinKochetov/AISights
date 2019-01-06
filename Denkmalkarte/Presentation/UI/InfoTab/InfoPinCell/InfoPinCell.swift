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
    @IBOutlet weak var pinImage: UIImageView!

    @IBOutlet weak var textViewForPinHeader: UITextView!
    @IBOutlet weak var textViewForPin: UITextView!
    @IBOutlet weak var shovelImage: UIImageView!
    @IBOutlet weak var shovelImage2: UIImageView!
    @IBOutlet weak var shovelImage3: UIImageView!

    @IBOutlet weak var textImage: UITextView!
    @IBOutlet weak var textImage2: UITextView!
    @IBOutlet weak var textImage3: UITextView!

    var cellType: CellType?

    public static let identifier = "InfoPinCell"

    public func set(pinImages: UIImage, textForPin: String, textForPinHeader: String, shovelImages: UIImage, textForShovels: [String], indexRow: Int) {
        //labelView.text = result
        //pinImage.image = UIImage(named:"red-pin")
        pinImage.image = pinImages
        textViewForPin.text = textForPin
        textViewForPinHeader.text = textForPinHeader
        if indexRow == 2 {
            shovelImage.image = shovelImages
            shovelImage2.image = shovelImages
            shovelImage3.image = shovelImages
            textImage.text = textForShovels[0]
            textImage2.text = textForShovels[1]
            textImage3.text = textForShovels[2]
        }
    }
}
