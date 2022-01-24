//
//  UIImage+scalePreservingResizing.swift
//  Waddit
//
//  Created by Uiseop Eom on 2022/01/24.
//

import Foundation

import UIKit

extension UIImage {
    
    /**
    Resize the image to the size you want (the parameter)
     - Parameters:
        - targetSize: the target size you want your image to fit in
     
     - Returns: UIImage
     - Examples::
        ```
            let targetSize = CGSize(width: 100, height: 100)
            var image = UIImage(systemName: "person.crop.circle")
            image = image.scalePreservingAspectRatio(targetSize)
        ```
     */
    func scalePreservingAspectRatio(targetSize: CGSize) -> UIImage {
        // Determine the scale factor that preserves aspect ratio
        let widthRatio = targetSize.width / size.width
        let heightRatio = targetSize.height / size.height
        
        let scaleFactor = min(widthRatio, heightRatio)
        
        // Compute the new image size that preserves aspect ratio
        let scaledImageSize = CGSize(
            width: size.width * scaleFactor,
            height: size.height * scaleFactor
        )

        // Draw and return the resized UIImage
        let renderer = UIGraphicsImageRenderer(
            size: scaledImageSize
        )

        let scaledImage = renderer.image { _ in
            self.draw(in: CGRect(
                origin: .zero,
                size: scaledImageSize
            ))
        }
        
        return scaledImage
    }
}
