//
//  UIColor+ShapeColor.swift
//  Patchworks
//
//  Created by Jeremy Reynolds on 1/3/18.
//  Copyright © 2018 Jeremy Reynolds. All rights reserved.
//

import UIKit

extension UIColor {
    
    static let shapeStrokeColor = UIColor(red: 0.889, green: 0.000, blue: 1.000, alpha: 1.000)
    
    static let shapeFillColor = shapeStrokeColor.withAlphaComponent(0.3)
}
