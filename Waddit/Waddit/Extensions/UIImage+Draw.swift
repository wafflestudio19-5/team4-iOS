//
//  UIImage+Draw.swift
//  Waddit
//
//  Created by Uiseop Eom on 2022/01/13.
//

import Foundation
import UIKit

extension UIImage {

    /// Remake Image
    public func remake(
        roundingCorners corners: UIRectCorner = .allCorners,
        radius: CGFloat = 0,
        strokeColor: UIColor? = nil,
        strokeLineWidth: CGFloat = 0,
        stockLineJoin: CGLineJoin = .miter) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(size, false, 0)
        defer { UIGraphicsEndImageContext() }
        guard let context = UIGraphicsGetCurrentContext() else {
            return self
        }
        context.scaleBy(x: 1, y: -1)
        context.translateBy(x: 0, y: -size.height)

        let roundedRect = CGRect(origin: CGPoint(x: 0, y: 0), size: size)
        let sideLength = min(roundedRect.size.width, roundedRect.size.height)
        if strokeLineWidth < sideLength * 0.5 {
            let roundedpath = UIBezierPath(
                roundedRect: roundedRect.insetBy(dx: strokeLineWidth, dy: strokeLineWidth),
                byRoundingCorners: corners,
                cornerRadii: CGSize(width: radius, height: strokeLineWidth)
            )
            roundedpath.close()

            context.saveGState()
            context.addPath(roundedpath.cgPath)
            context.clip()
            context.draw(cgImage!, in: roundedRect)
            context.restoreGState()
        }

        if nil != strokeColor && strokeLineWidth > 0 {
            let strokeInset = (floor(strokeLineWidth * scale) + 0.5) / scale
            let strokeRect = roundedRect.insetBy(dx: strokeInset, dy: strokeInset)
            let strokeRadius = radius > scale / 2.0 ? radius - scale / 2.0 : 0.0
            let strokePath = UIBezierPath(
                roundedRect: strokeRect,
                byRoundingCorners: corners,
                cornerRadii: CGSize(width: strokeRadius, height: strokeLineWidth)
            )
            strokePath.close()

            context.saveGState()
            context.setStrokeColor(strokeColor!.cgColor)
            context.setLineWidth(strokeLineWidth)
            context.setLineJoin(stockLineJoin)
            context.addPath(strokePath.cgPath)
            context.strokePath()
            context.restoreGState()
        }

        if let output = UIGraphicsGetImageFromCurrentImageContext() {
            return output
        }
        return self
    }

    /// Remake image
    public func remake(alpha: CGFloat) -> UIImage {
        UIGraphicsBeginImageContext(size)
        defer { UIGraphicsEndImageContext() }

        let rect = CGRect(origin: CGPoint(x: 0, y: 0), size: size)
        draw(in: rect, blendMode: .normal, alpha: alpha)
        if let output = UIGraphicsGetImageFromCurrentImageContext() {
            return output
        }
        return self
    }

    public var circle: UIImage {
        var newImage: UIImage = self
        let sideLength = min(size.width, size.height)
        if size.width != size.height {
            let center = CGPoint(x: size.width * 0.5, y: size.height * 0.5)
            let newRect = CGRect(x: center.x - sideLength * 0.5, y: center.y - sideLength * 0.5,
                                 width: sideLength, height: sideLength)
            if let image = extracting(in: newRect) {
                newImage = image
            }
        }
        return newImage.remake(radius: sideLength * 0.5)
    }

    /// Extract image
    public func extracting(in subRect: CGRect) -> UIImage? {
        if let imageRef = cgImage!.cropping(to: subRect) {
            return UIImage(cgImage: imageRef)
        }
        return nil
    }
}
