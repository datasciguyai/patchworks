//
//  BlockView+DoubleCross.swift
//  Patchworks
//
//  Created by Jeremy Reynolds on 12/13/17.
//  Copyright © 2017 Jeremiah Reynolds. All rights reserved.
//

import UIKit
extension BlockView {
    var doubleCross: [PieceView] {
        let smallTriangleWidth = CGFloat(sqrt((bounds.maxX / 4 * bounds.maxX / 4) + (bounds.maxY / 4 * bounds.maxY / 4)))
        let smallTriangleHeight = smallTriangleWidth / 2
        let rectDiag = CGFloat(sqrt((bounds.maxX * bounds.maxX) + (bounds.maxY * bounds.maxY))) / 4
        let triangleWidth = CGFloat(sqrt((rectDiag * rectDiag) + (rectDiag * rectDiag)))
        let triangleHeight = triangleWidth / 2
        return [
            
            // Triangles
            PieceView(frame: CGRect(x: bounds.minX, y: bounds.minY, width: smallTriangleWidth, height: smallTriangleHeight), rotationAngle: CGFloat(45.0), shape: .triangle),
            PieceView(frame: CGRect(x: bounds.maxX / 4, y: bounds.minY, width: triangleWidth, height: triangleHeight), rotationAngle: CGFloat(180.0), shape: .triangle),
            PieceView(frame: CGRect(x: bounds.maxX * 0.75, y: bounds.minY, width: smallTriangleWidth, height: smallTriangleHeight), rotationAngle: CGFloat(315.0), shape: .triangle),
            PieceView(frame: CGRect(x: bounds.minX, y: bounds.maxY / 4, width: triangleWidth, height: triangleHeight), rotationAngle: CGFloat(270.0), shape: .triangle),
            PieceView(frame: CGRect(x: bounds.maxX * 0.75, y: bounds.maxY / 4, width: triangleWidth, height: triangleHeight), rotationAngle: CGFloat(90.0), shape: .triangle),
            PieceView(frame: CGRect(x: bounds.minX, y: bounds.maxY * 0.75, width: smallTriangleWidth, height: smallTriangleHeight), rotationAngle: CGFloat(135.0), shape: .triangle),
            PieceView(frame: CGRect(x: bounds.maxX / 4, y: bounds.maxY * 0.75, width: triangleWidth, height: triangleHeight), rotationAngle: CGFloat(0.0), shape: .triangle),
            PieceView(frame: CGRect(x: bounds.maxX * 0.75, y: bounds.maxY * 0.75, width: smallTriangleWidth, height: smallTriangleHeight), rotationAngle: CGFloat(225.0), shape: .triangle),
            
            // Rectangles
            PieceView(frame: CGRect(x: bounds.minX, y: bounds.minY, width: rectDiag, height: rectDiag), rotationAngle: CGFloat(45.0), shape: .rectangle),
            PieceView(frame: CGRect(x: bounds.maxX / 2, y: bounds.minY, width: rectDiag, height: rectDiag), rotationAngle: CGFloat(45.0), shape: .rectangle),
            PieceView(frame: CGRect(x: bounds.maxX / 4, y: bounds.maxY / 4, width: rectDiag, height: rectDiag), rotationAngle: CGFloat(45.0), shape: .rectangle),
            PieceView(frame: CGRect(x: bounds.minX, y: bounds.maxY / 2, width: rectDiag, height: rectDiag), rotationAngle: CGFloat(45.0), shape: .rectangle),
            PieceView(frame: CGRect(x: bounds.maxX / 2, y: bounds.maxY / 2, width: rectDiag, height: rectDiag), rotationAngle: CGFloat(45.0), shape: .rectangle)
        ]
    }
}
