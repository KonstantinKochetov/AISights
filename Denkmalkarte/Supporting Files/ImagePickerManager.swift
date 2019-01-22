//
//  ImagePickerManager.swift
//  Denkmalkarte
//
//  Created by Julian Caramel on 1/11/19.
//  Copyright © 2019 htw.berlin. All rights reserved.
//

import Foundation
import UIKit
import MobileCoreServices

protocol ImagePickerManagerDelegate: class {
    func manager(_ manager: ImagePickerManager, didPickImage image: UIImage)
}

class ImagePickerManager: NSObject {

    private var imagePickerController: UIImagePickerController {
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        imagePickerController.mediaTypes = [kUTTypeImage as String]
        imagePickerController.sourceType = .camera
        return imagePickerController
    }

    weak var delegate: ImagePickerManagerDelegate?

    func showCamera(in viewController: UIViewController) {
        viewController.present(imagePickerController, animated: true, completion: nil)
    }
}

extension ImagePickerManager: UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
        picker.dismiss(animated: true, completion: nil)
        if let image = info[.originalImage] as? UIImage {
            delegate?.manager(self, didPickImage: image)
        }
    }
}
