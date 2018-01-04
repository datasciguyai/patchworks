//
//  BlockView+DoubleCross.swift
//  Patchworks
//
//  Created by Jeremy Reynolds on 12/13/17.
//  Copyright © 2017 Jeremy Reynolds. All rights reserved.
//

import UIKit
extension BlockView {
    var doubleCross: [ShapeView] {
        let smallTriangleWidth = CGFloat(sqrt((bounds.maxX / 4 * bounds.maxX / 4) + (bounds.maxY / 4 * bounds.maxY / 4)))
        let smallTriangleHeight = smallTriangleWidth / 2
        let rectDiag = CGFloat(sqrt((bounds.maxX * bounds.maxX) + (bounds.maxY * bounds.maxY))) / 4
        let triangleWidth = CGFloat(sqrt((rectDiag * rectDiag) + (rectDiag * rectDiag)))
        let triangleHeight = triangleWidth / 2
        return [
            
            // Triangles
            ShapeView(frame: CGRect(x: bounds.minX, y: bounds.minY, width: smallTriangleWidth, height: smallTriangleHeight), rotation: CGFloat(45.0), shapeType: .triangle),
            ShapeView(frame: CGRect(x: bounds.maxX / 4, y: bounds.minY, width: triangleWidth, height: triangleHeight), rotation: CGFloat(180.0), shapeType: .triangle),
            ShapeView(frame: CGRect(x: bounds.maxX * 0.75, y: bounds.minY, width: smallTriangleWidth, height: smallTriangleHeight), rotation: CGFloat(315.0), shapeType: .triangle),
            ShapeView(frame: CGRect(x: bounds.minX, y: bounds.maxY / 4, width: triangleWidth, height: triangleHeight), rotation: CGFloat(270.0), shapeType: .triangle),
            ShapeView(frame: CGRect(x: bounds.maxX * 0.75, y: bounds.maxY / 4, width: triangleWidth, height: triangleHeight), rotation: CGFloat(90.0), shapeType: .triangle),
            ShapeView(frame: CGRect(x: bounds.minX, y: bounds.maxY * 0.75, width: smallTriangleWidth, height: smallTriangleHeight), rotation: CGFloat(135.0), shapeType: .triangle),
            ShapeView(frame: CGRect(x: bounds.maxX / 4, y: bounds.maxY * 0.75, width: triangleWidth, height: triangleHeight), rotation: CGFloat(0.0), shapeType: .triangle),
            ShapeView(frame: CGRect(x: bounds.maxX * 0.75, y: bounds.maxY * 0.75, width: smallTriangleWidth, height: smallTriangleHeight), rotation: CGFloat(225.0), shapeType: .triangle),
            
            // Rectangles
            ShapeView(frame: CGRect(x: bounds.minX, y: bounds.minY, width: rectDiag, height: rectDiag), rotation: CGFloat(45.0), shapeType: .rectangle),
            ShapeView(frame: CGRect(x: bounds.maxX / 2, y: bounds.minY, width: rectDiag, height: rectDiag), rotation: CGFloat(45.0), shapeType: .rectangle),
            ShapeView(frame: CGRect(x: bounds.maxX / 4, y: bounds.maxY / 4, width: rectDiag, height: rectDiag), rotation: CGFloat(45.0), shapeType: .rectangle),
            ShapeView(frame: CGRect(x: bounds.minX, y: bounds.maxY / 2, width: rectDiag, height: rectDiag), rotation: CGFloat(45.0), shapeType: .rectangle),
            ShapeView(frame: CGRect(x: bounds.maxX / 2, y: bounds.maxY / 2, width: rectDiag, height: rectDiag), rotation: CGFloat(45.0), shapeType: .rectangle)
        ]
    }
}
