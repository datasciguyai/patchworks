//
//  BlockView+BasketWeave.swift
//  Patchworks
//
//  Created by Jeremy Reynolds on 12/13/17.
//  Copyright © 2017 Jeremy Reynolds. All rights reserved.
//

import UIKit
extension BlockView {
    var basketWeave: [ShapeView] {
        return [
            
            // Rectangles
            ShapeView(frame: CGRect(x: bounds.minX, y: bounds.minY, width: bounds.midX, height: bounds.midY / 3), rotation: CGFloat(0.0), color: shapeColor, shapeType: .rectangle), ShapeView(frame: CGRect(x: bounds.minX, y: bounds.midY / 3, width: bounds.midX, height: bounds.midY / 3), rotation: CGFloat(0.0), color: shapeColor, shapeType: .rectangle),
            ShapeView(frame: CGRect(x: bounds.minX, y: bounds.midY / 1.5, width: bounds.midX, height: bounds.midY / 3), rotation: CGFloat(0.0), color: shapeColor, shapeType: .rectangle),
            ShapeView(frame: CGRect(x: bounds.minX, y: bounds.midY, width: bounds.midX / 3, height: bounds.midY), rotation: CGFloat(0.0), color: shapeColor, shapeType: .rectangle),
            ShapeView(frame: CGRect(x: bounds.midX / 3, y: bounds.midY, width: bounds.midX / 3, height: bounds.midY), rotation: CGFloat(0.0), color: shapeColor, shapeType: .rectangle),
            ShapeView(frame: CGRect(x: bounds.midX / 1.5, y: bounds.midY, width: bounds.midX / 3, height: bounds.midY), rotation: CGFloat(0.0), color: shapeColor, shapeType: .rectangle),
            ShapeView(frame: CGRect(x: bounds.midX, y: bounds.minY, width: bounds.midX / 3, height: bounds.midY), rotation: CGFloat(0.0), color: shapeColor, shapeType: .rectangle),
            ShapeView(frame: CGRect(x: bounds.midX / 0.75, y: bounds.minY, width: bounds.midX / 3, height: bounds.midY), rotation: CGFloat(0.0), color: shapeColor, shapeType: .rectangle),
            ShapeView(frame: CGRect(x: bounds.midX / 0.6, y: bounds.minY, width: bounds.midX / 3, height: bounds.midY), rotation: CGFloat(0.0), color: shapeColor, shapeType: .rectangle),
            ShapeView(frame: CGRect(x: bounds.midX, y: bounds.midY, width: bounds.midX, height: bounds.midY / 3), rotation: CGFloat(0.0), color: shapeColor, shapeType: .rectangle),
            ShapeView(frame: CGRect(x: bounds.midX, y: bounds.midY / 0.75, width: bounds.midX, height: bounds.midY / 3), rotation: CGFloat(0.0), color: shapeColor, shapeType: .rectangle),
            ShapeView(frame: CGRect(x: bounds.midX, y: bounds.midY / 0.6, width: bounds.midX, height: bounds.midY / 3), rotation: CGFloat(0.0), color: shapeColor, shapeType: .rectangle)
        ]
    }
}
