//
//  PhotoCell.swift
//  Denkmalkarte
//
//  Created by Julian Caramel on 1/11/19.
//  Copyright © 2019 htw.berlin. All rights reserved.
//

import UIKit
import FirebaseStorage

class PhotoCell: UICollectionViewCell {

    @IBOutlet private var imageView: UIImageView!
    @IBOutlet private var cameraImageView: UIImageView!

    public static let identifier = "PhotoCell"

    override func prepareForReuse() {
        imageView.image = nil
        cameraImageView.isHidden = true
    }

    func setupWithCameraIcon() {
        cameraImageView.isHidden = false
    }

    func setup(withImageId imageId: String) {
        let ref = Storage.storage().reference().child("user-uploads").child(imageId)
        ref.downloadURL { url, error in
            if error != nil {
                print("Could not create download url.")
            }

            if let url = url {
                self.imageView.af_setImage(withURL: url)
            }
        }
    }

}
