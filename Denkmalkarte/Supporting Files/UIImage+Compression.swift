//
//  UIImage+Compression.swift
//  Denkmalkarte
//
//  Created by Julian Caramel on 1/11/19.
//  Copyright © 2019 htw.berlin. All rights reserved.
//

import Foundation
import UIKit
import MobileCoreServices

fileprivate let maxImageSize: CGFloat = 1024
fileprivate let minImageSize: CGFloat = 512
fileprivate let compressionAmount: CGFloat = 0.7

enum ImageCompressionError: Error {
    case imageTooSmall
    case badImageRatio
}

extension UIImage {

    public func compress(completion: @escaping (Data?, CGFloat?, CGFloat?, Error?) -> Void) {
        let width = self.size.width
        let height = self.size.height

        if width < 512 || height < 512 {
            completion(nil, nil, nil, ImageCompressionError.imageTooSmall)
            return
        }

        if width < height / 2 || height < width / 2 {
            completion(nil, nil, nil, ImageCompressionError.badImageRatio)
            return
        }

        let newWidth: CGFloat
        let newHeight: CGFloat

        if width <= maxImageSize && height <= maxImageSize {
            newWidth = width
            newHeight = height
        } else if width > height {
            let factor = maxImageSize / width

            newWidth = maxImageSize
            newHeight = height * factor
        } else if width < height {
            let factor = maxImageSize / height

            newWidth = width * factor
            newHeight = maxImageSize
        } else {
            newWidth = maxImageSize
            newHeight = maxImageSize
        }

        let rect = CGRect(x: 0, y: 0, width: newWidth, height: newHeight)

        UIGraphicsBeginImageContext(rect.size)
        self.draw(in: rect)
        let scaledImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()

        let jpegImage = (scaledImage ?? UIImage()).jpegData(compressionQuality: compressionAmount)

        completion(jpegImage, newWidth, newHeight, nil)
    }

}
