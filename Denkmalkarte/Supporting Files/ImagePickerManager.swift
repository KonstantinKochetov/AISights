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
        return imagePickerController
    }
    
    weak var delegate: ImagePickerManagerDelegate?
    
    func showOptionsAlertController(inViewController viewController: UIViewController) {
        let takePhotoAction = UIAlertAction(title: "Take Photo", style: .default) { _ in
            self.imagePickerController.sourceType = .camera
            viewController.present(self.imagePickerController, animated: true, completion: nil)
        }
        
        let choosePhotoAction = UIAlertAction(title: "Choose from Library", style: .default) { _ in
            self.imagePickerController.sourceType = .photoLibrary
            viewController.present(self.imagePickerController, animated: true, completion: nil)
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        let choosePhotoAlterController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        choosePhotoAlterController.addAction(takePhotoAction)
        choosePhotoAlterController.addAction(choosePhotoAction)
        choosePhotoAlterController.addAction(cancelAction)
        
        viewController.present(choosePhotoAlterController, animated: true, completion: nil)
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
