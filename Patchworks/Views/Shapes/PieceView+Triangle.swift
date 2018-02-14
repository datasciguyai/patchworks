//
//  PieceView+Triangle.swift
//  Patchworks
//
//  Created by Jeremy Reynolds on 12/15/17.
//  Copyright © 2017 Jeremy Reynolds. All rights reserved.
//

import UIKit

extension PieceView {
    var triangle: UIBezierPath {
        let trianglePath = UIBezierPath()
        trianglePath.move(to: CGPoint(x: bounds.midX, y: bounds.minY))
        trianglePath.addLine(to: CGPoint(x: bounds.maxX, y: bounds.maxY))
        trianglePath.addLine(to: CGPoint(x: bounds.minX, y: bounds.maxY))
        trianglePath.close()
        let pathTransform = CGAffineTransform(rotationAngle: -rotationAngle * CGFloat.pi / 180)
        trianglePath.apply(pathTransform.concatenating(CGAffineTransform(translationX: bounds.midX, y: bounds.midY)))
        return trianglePath
    }
}
