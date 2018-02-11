//
//  BlockView+ChurnDash.swift
//  Patchworks
//
//  Created by Jeremy Reynolds on 12/8/17.
//  Copyright © 2017 Jeremy Reynolds. All rights reserved.
//

import UIKit
extension BlockView {
    var churnDash: [ShapeView] {
        let triangleWidth = CGFloat(sqrt((bounds.maxX / 3 * bounds.maxX / 3) + (bounds.maxY / 3 * bounds.maxY / 3)))
        let triangleHeight = triangleWidth / 2
        return [
            
            // Triangles
            ShapeView(frame: CGRect(x: bounds.minX, y: bounds.minY, width: triangleWidth, height: triangleHeight), rotation: CGFloat(45.0), shapeType: .triangle),
            ShapeView(frame: CGRect(x: bounds.minX, y: bounds.minY, width: triangleWidth, height: triangleHeight), rotation: CGFloat(225.0), shapeType: .triangle),
            ShapeView(frame: CGRect(x: bounds.maxX / 1.5, y: bounds.minY, width: triangleWidth, height: triangleHeight), rotation: CGFloat(315.0), shapeType: .triangle),
            ShapeView(frame: CGRect(x: bounds.maxX / 1.5, y: bounds.minY, width: triangleWidth, height: triangleHeight), rotation: CGFloat(135.0), shapeType: .triangle),
            ShapeView(frame: CGRect(x: bounds.minX, y: bounds.maxY / 1.5, width: triangleWidth, height: triangleHeight), rotation: CGFloat(135.0), shapeType: .triangle),
            ShapeView(frame: CGRect(x: bounds.minX, y: bounds.maxY / 1.5, width: triangleWidth, height: triangleHeight), rotation: CGFloat(315.0), shapeType: .triangle),
            ShapeView(frame: CGRect(x: bounds.maxX / 1.5, y: bounds.maxY / 1.5, width: triangleWidth, height: triangleHeight), rotation: CGFloat(225.0), shapeType: .triangle),
            ShapeView(frame: CGRect(x: bounds.maxX / 1.5, y: bounds.maxY / 1.5, width: triangleWidth, height: triangleHeight), rotation: CGFloat(45.0), shapeType: .triangle),
            
            // Rectangles
            ShapeView(frame: CGRect(x: bounds.maxX / 3, y: bounds.minY, width: bounds.maxX / 3, height: bounds.maxY / 6), rotation: CGFloat(0.0), shapeType: .rectangle),
            ShapeView(frame: CGRect(x: bounds.maxX / 3, y: bounds.maxY / 6, width: bounds.maxX / 3, height: bounds.maxY / 6), rotation: CGFloat(0.0), shapeType: .rectangle),
            ShapeView(frame: CGRect(x: bounds.minX, y: bounds.maxY / 3, width: bounds.maxX / 6, height: bounds.maxY / 3), rotation: CGFloat(0.0), shapeType: .rectangle),
            ShapeView(frame: CGRect(x: bounds.maxX / 6, y: bounds.maxY / 3, width: bounds.maxX / 6, height: bounds.maxY / 3), rotation: CGFloat(0.0), shapeType: .rectangle),
            ShapeView(frame: CGRect(x: bounds.maxX / 3, y: bounds.maxY / 3, width: bounds.maxX / 3, height: bounds.maxY / 3), rotation: CGFloat(0.0), shapeType: .rectangle),
            ShapeView(frame: CGRect(x: bounds.maxX / 1.5, y: bounds.maxY / 3, width: bounds.maxX / 6, height: bounds.maxY / 3), rotation: CGFloat(0.0), shapeType: .rectangle),
            ShapeView(frame: CGRect(x: bounds.maxX / 1.2, y: bounds.maxY / 3, width: bounds.maxX / 6, height: bounds.maxY / 3), rotation: CGFloat(0.0), shapeType: .rectangle),
            ShapeView(frame: CGRect(x: bounds.maxX / 3, y: bounds.maxY / 1.5, width: bounds.maxX / 3, height: bounds.maxY / 6), rotation: CGFloat(0.0), shapeType: .rectangle),
            ShapeView(frame: CGRect(x: bounds.maxX / 3, y: bounds.maxY / 1.2, width: bounds.maxX / 3, height: bounds.maxY / 6), rotation: CGFloat(0.0), shapeType: .rectangle)
        ]
    }
}
