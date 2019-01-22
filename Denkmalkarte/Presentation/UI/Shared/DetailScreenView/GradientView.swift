//
//  GradientView.swift
//  Denkmalkarte
//
//  Created by Julian Caramel on 1/12/19.
//  Copyright © 2019 htw.berlin. All rights reserved.
//

import UIKit

class GradientView: UIView {

    @IBInspectable var firstColor: UIColor = .white
    @IBInspectable var secondColor: UIColor = .white

    lazy var shapeLayer: CAShapeLayer = {
        let shapeLayer = CAShapeLayer()
        shapeLayer.path = UIBezierPath(roundedRect: bounds, cornerRadius: layer.cornerRadius).cgPath
        return shapeLayer
    }()

    lazy var gradientLayer: CAGradientLayer = {
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = bounds
        gradientLayer.colors = [firstColor.cgColor, secondColor.cgColor]
        gradientLayer.locations = [0.0, 1.0]
        gradientLayer.startPoint = CGPoint(x: 0, y: 0)
        gradientLayer.endPoint = CGPoint(x: 0, y: 1)
        gradientLayer.mask = shapeLayer
        return gradientLayer
    }()

    override func draw(_ rect: CGRect) {
        layer.insertSublayer(gradientLayer, at: 0)
    }

}
