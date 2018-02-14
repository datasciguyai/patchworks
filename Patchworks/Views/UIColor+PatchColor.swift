//
//  UIColor+PatchColor.swift
//  Patchworks
//
//  Created by Jeremy Reynolds on 1/3/18.
//  Copyright © 2018 Jeremy Reynolds. All rights reserved.
//

import UIKit

extension UIColor {
    static let patchStrokeColor = UIColor(named: "patchColor")
    static let patchFillColor = patchStrokeColor?.withAlphaComponent(0.3)
}
