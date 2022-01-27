//
//  UIButton+init.swift
//  Waddit
//
//  Created by Uiseop Eom on 2022/01/28.
//

import Foundation
import UIKit

@available(iOS 11.0, tvOS 11.0, *)
extension UIButton {

    convenience public init(title: String,
                            titleColor: UIColor,
                            font: UIFont = .systemFont(ofSize: 14),
                            backgroundColor: UIColor = .clear,
                            radius: CGFloat? = nil,
                            target: Any? = nil,
                            action: Selector? = nil) {
        self.init(type: .system)
        setTitle(title, for: .normal)
        setTitleColor(titleColor, for: .normal)
        self.titleLabel?.font = font

        self.backgroundColor = backgroundColor
        if let action = action {
            addTarget(target, action: action, for: .primaryActionTriggered)
        }

        if let radius = radius {
            self.layer.cornerRadius = radius
        }
    }

    convenience public init(image: UIImage, tintColor: UIColor? = nil, target: Any? = nil, action: Selector? = nil) {
        self.init(type: .system)
        if tintColor == nil {
            setImage(image, for: .normal)
        } else {
            setImage(image.withRenderingMode(.alwaysTemplate), for: .normal)
            self.tintColor = tintColor
        }

        if let action = action {
            addTarget(target, action: action, for: .primaryActionTriggered)
        }
    }
}

class GradientButton: UIButton {
    private let gradient: CAGradientLayer = CAGradientLayer()
    private var gradientStartColor: UIColor
    private var gradientEndColor: UIColor
    private var radius: CGFloat?

    init(title: String,
         titleColor: UIColor,
         font: UIFont = .systemFont(ofSize: 14),
         backgroundColor: UIColor = .clear,
         radius: CGFloat? = nil,
         target: Any? = nil,
         action: Selector? = nil,
         gradientStartColor: UIColor,
         gradientEndColor: UIColor) {
        self.gradientStartColor = gradientStartColor
        self.gradientEndColor = gradientEndColor

        super.init(frame: .zero)
        if let radius = radius {
            self.radius = radius
        }

        self.setTitle(title, for: .normal)
        self.setTitleColor(titleColor, for: .normal)
        self.titleLabel?.font = font
  }

    required init?(coder aDecoder: NSCoder) { fatalError("init(coder:) has not been implemented") }

    override func layoutSublayers(of layer: CALayer) {
        super.layoutSublayers(of: layer)
        gradient.frame = self.bounds
    }

    override public func draw(_ rect: CGRect) {
        gradient.frame = self.bounds
        gradient.colors = [gradientEndColor.cgColor, gradientStartColor.cgColor]
        gradient.startPoint = CGPoint(x: 1, y: 0)
        gradient.endPoint = CGPoint(x: 0.2, y: 1)

        if let radius = self.radius {
            gradient.cornerRadius = radius
        }

        if gradient.superlayer == nil {
            layer.insertSublayer(gradient, at: 0)
        }
    }
}

