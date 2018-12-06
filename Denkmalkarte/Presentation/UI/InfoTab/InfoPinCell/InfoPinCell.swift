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
    
    
    public static let identifier = "InfoPinCell"
    
    public func set(pinImages: UIImage, textForPin: String, textForPinHeader: String) {
        //labelView.text = result
        //pinImage.image = UIImage(named:"red-pin")
        pinImage.image = pinImages
        textViewForPin.text = textForPin
        textViewForPinHeader.text = textForPinHeader
        
    }
    
}
