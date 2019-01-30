//
//  PhotoCell.swift
//  Denkmalkarte
//
//  Created by Julian Caramel on 1/11/19.
//  Copyright © 2019 htw.berlin. All rights reserved.
//

import UIKit
import FirebaseStorage

protocol PhotoCellDelegate: class {
    func cellDidStartLongPress(_ cell: PhotoCell)
    func cellDidEndLongPress(_ cell: PhotoCell)
}

class PhotoCell: UICollectionViewCell {

    @IBOutlet private var imageView: UIImageView!
    @IBOutlet private var cameraImageView: UIImageView!

    public static let identifier = "PhotoCell"

    weak var delegate: PhotoCellDelegate?

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

        setupGestureRecognizer()
    }

    // MARK: Helpers

    private func setupGestureRecognizer() {
        let longPressGestureRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(handleGesture))
        addGestureRecognizer(longPressGestureRecognizer)
    }

    @objc private func handleGesture(_ sender: UILongPressGestureRecognizer) {
        switch sender.state {
        case .began:
            delegate?.cellDidStartLongPress(self)
        case .ended:
            delegate?.cellDidEndLongPress(self)
        default:
            return
        }
    }

}
