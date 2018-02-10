//
//  UIColor+ShapeColor.swift
//  Patchworks
//
//  Created by Jeremy Reynolds on 1/3/18.
//  Copyright © 2018 Jeremy Reynolds. All rights reserved.
//

import UIKit

extension UIColor {
    static let shapeStrokeColor = UIColor(named: "blockColor")
    static let shapeFillColor = shapeStrokeColor?.withAlphaComponent(0.3)
}
