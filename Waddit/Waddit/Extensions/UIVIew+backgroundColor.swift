//
//  UIVIew+backgroundColor.swift
//  UIkitFundamentals
//
//  Created by Uiseop Eom on 2022/01/09.
//

import Foundation

#if canImport(UIKit)
import UIKit

extension UIView {
    public static func changeViewBackgroundColor(view: UIView, color: UIColor) {
        view.backgroundColor = color
    }
}

#endif

