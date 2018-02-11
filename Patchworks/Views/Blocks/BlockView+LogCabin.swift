//
//  BlockView+LogCabin.swift
//  Patchworks
//
//  Created by Jeremy Reynolds on 12/7/17.
//  Copyright © 2017 Jeremy Reynolds. All rights reserved.
//

import UIKit
extension BlockView {
    var logCabin: [ShapeView] {
        return [
            
            // Rectangles
            ShapeView(frame: CGRect(x: bounds.maxX * 0.875, y: bounds.minY, width: bounds.maxX * 0.125, height: bounds.maxY), rotation: CGFloat(0.0), shapeType: .rectangle),
            ShapeView(frame: CGRect(x: bounds.minX, y: bounds.maxY * 0.875, width: bounds.maxX * 0.875, height: bounds.maxY * 0.125), rotation: CGFloat(0.0), shapeType: .rectangle),
            ShapeView(frame: CGRect(x: bounds.minX, y: bounds.minY, width: bounds.maxX * 0.125, height: bounds.maxY * 0.875), rotation: CGFloat(0.0), shapeType: .rectangle),
            ShapeView(frame: CGRect(x: bounds.maxX * 0.125, y: bounds.minY, width: bounds.maxX * 0.75, height: bounds.maxY * 0.125), rotation: CGFloat(0.0), shapeType: .rectangle),
            ShapeView(frame: CGRect(x: bounds.maxX * 0.75, y: bounds.maxY * 0.125, width: bounds.maxX * 0.125, height: bounds.maxY * 0.75), rotation: CGFloat(0.0), shapeType: .rectangle),
            ShapeView(frame: CGRect(x: bounds.maxX * 0.125, y: bounds.maxY * 0.75, width: bounds.maxX * 0.625, height: bounds.maxY * 0.125), rotation: CGFloat(0.0), shapeType: .rectangle),
            ShapeView(frame: CGRect(x: bounds.maxX * 0.125, y: bounds.maxY * 0.125, width: bounds.maxX * 0.125, height: bounds.maxY * 0.625), rotation: CGFloat(0.0), shapeType: .rectangle),
            ShapeView(frame: CGRect(x: bounds.maxX * 0.25, y: bounds.maxY * 0.125, width: bounds.maxX * 0.50, height: bounds.maxY * 0.125), rotation: CGFloat(0.0), shapeType: .rectangle),
            ShapeView(frame: CGRect(x: bounds.maxX * 0.625, y: bounds.maxY * 0.25, width: bounds.maxX * 0.125, height: bounds.maxY * 0.50), rotation: CGFloat(0.0), shapeType: .rectangle),
            ShapeView(frame: CGRect(x: bounds.maxX * 0.25, y: bounds.maxY * 0.625, width: bounds.maxX * 0.375, height: bounds.maxY * 0.125), rotation: CGFloat(0.0), shapeType: .rectangle),
            ShapeView(frame: CGRect(x: bounds.maxX * 0.25, y: bounds.maxY * 0.25, width: bounds.maxX * 0.125, height: bounds.maxY * 0.375), rotation: CGFloat(0.0), shapeType: .rectangle),
            ShapeView(frame: CGRect(x: bounds.maxX * 0.375, y: bounds.maxY * 0.25, width: bounds.maxX * 0.25, height: bounds.maxY * 0.125), rotation: CGFloat(0.0), shapeType: .rectangle),
            ShapeView(frame: CGRect(x: bounds.maxX * 0.375, y: bounds.maxY * 0.375, width: bounds.maxX * 0.25, height: bounds.maxY * 0.25), rotation: CGFloat(0.0), shapeType: .rectangle)
        ]
    }
}
