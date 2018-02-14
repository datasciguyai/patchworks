//
//  BlockView+ChurnDash.swift
//  Patchworks
//
//  Created by Jeremy Reynolds on 12/8/17.
//  Copyright © 2017 Jeremy Reynolds. All rights reserved.
//

import UIKit
extension BlockView {
    var churnDash: [PieceView] {
        let triangleWidth = CGFloat(sqrt((bounds.maxX / 3 * bounds.maxX / 3) + (bounds.maxY / 3 * bounds.maxY / 3)))
        let triangleHeight = triangleWidth / 2
        return [
            
            // Triangles
            PieceView(frame: CGRect(x: bounds.minX, y: bounds.minY, width: triangleWidth, height: triangleHeight), rotationAngle: CGFloat(45.0), shape: .triangle),
            PieceView(frame: CGRect(x: bounds.minX, y: bounds.minY, width: triangleWidth, height: triangleHeight), rotationAngle: CGFloat(225.0), shape: .triangle),
            PieceView(frame: CGRect(x: bounds.maxX / 1.5, y: bounds.minY, width: triangleWidth, height: triangleHeight), rotationAngle: CGFloat(315.0), shape: .triangle),
            PieceView(frame: CGRect(x: bounds.maxX / 1.5, y: bounds.minY, width: triangleWidth, height: triangleHeight), rotationAngle: CGFloat(135.0), shape: .triangle),
            PieceView(frame: CGRect(x: bounds.minX, y: bounds.maxY / 1.5, width: triangleWidth, height: triangleHeight), rotationAngle: CGFloat(135.0), shape: .triangle),
            PieceView(frame: CGRect(x: bounds.minX, y: bounds.maxY / 1.5, width: triangleWidth, height: triangleHeight), rotationAngle: CGFloat(315.0), shape: .triangle),
            PieceView(frame: CGRect(x: bounds.maxX / 1.5, y: bounds.maxY / 1.5, width: triangleWidth, height: triangleHeight), rotationAngle: CGFloat(225.0), shape: .triangle),
            PieceView(frame: CGRect(x: bounds.maxX / 1.5, y: bounds.maxY / 1.5, width: triangleWidth, height: triangleHeight), rotationAngle: CGFloat(45.0), shape: .triangle),
            
            // Rectangles
            PieceView(frame: CGRect(x: bounds.maxX / 3, y: bounds.minY, width: bounds.maxX / 3, height: bounds.maxY / 6), rotationAngle: CGFloat(0.0), shape: .rectangle),
            PieceView(frame: CGRect(x: bounds.maxX / 3, y: bounds.maxY / 6, width: bounds.maxX / 3, height: bounds.maxY / 6), rotationAngle: CGFloat(0.0), shape: .rectangle),
            PieceView(frame: CGRect(x: bounds.minX, y: bounds.maxY / 3, width: bounds.maxX / 6, height: bounds.maxY / 3), rotationAngle: CGFloat(0.0), shape: .rectangle),
            PieceView(frame: CGRect(x: bounds.maxX / 6, y: bounds.maxY / 3, width: bounds.maxX / 6, height: bounds.maxY / 3), rotationAngle: CGFloat(0.0), shape: .rectangle),
            PieceView(frame: CGRect(x: bounds.maxX / 3, y: bounds.maxY / 3, width: bounds.maxX / 3, height: bounds.maxY / 3), rotationAngle: CGFloat(0.0), shape: .rectangle),
            PieceView(frame: CGRect(x: bounds.maxX / 1.5, y: bounds.maxY / 3, width: bounds.maxX / 6, height: bounds.maxY / 3), rotationAngle: CGFloat(0.0), shape: .rectangle),
            PieceView(frame: CGRect(x: bounds.maxX / 1.2, y: bounds.maxY / 3, width: bounds.maxX / 6, height: bounds.maxY / 3), rotationAngle: CGFloat(0.0), shape: .rectangle),
            PieceView(frame: CGRect(x: bounds.maxX / 3, y: bounds.maxY / 1.5, width: bounds.maxX / 3, height: bounds.maxY / 6), rotationAngle: CGFloat(0.0), shape: .rectangle),
            PieceView(frame: CGRect(x: bounds.maxX / 3, y: bounds.maxY / 1.2, width: bounds.maxX / 3, height: bounds.maxY / 6), rotationAngle: CGFloat(0.0), shape: .rectangle)
        ]
    }
}
