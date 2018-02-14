//
//  PatchView+Rectangle.swift
//  Patchworks
//
//  Created by Jeremy Reynolds on 12/15/17.
//  Copyright © 2017 Jeremy Reynolds. All rights reserved.
//

import UIKit

extension PatchView {
    var rectangle: UIBezierPath {
        let rectanglePath = UIBezierPath(rect: bounds)
        let pathTransform = CGAffineTransform(rotationAngle: -rotationAngle * CGFloat.pi / 180)
        rectanglePath.apply(pathTransform.concatenating(CGAffineTransform(translationX: bounds.midX, y: bounds.midY)))
        return rectanglePath
    }
}
