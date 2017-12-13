//
//  DoubleCrossBlock.swift
//  Patchworks
//
//  Created by Jeremy Reynolds on 12/13/17.
//  Copyright © 2017 Jeremy Reynolds. All rights reserved.
//

import UIKit

class DoubleCrossBlock: UIView {
    
    //Double Cross
    
    var t1 = Shape()
    var t2 = Shape()
    var t3 = Shape()
    var t4 = Shape()
    var t5 = Shape()
    var t6 = Shape()
    var t7 = Shape()
    var t8 = Shape()
    var r1 = Shape()
    var r2 = Shape()
    var r3 = Shape()
    var r4 = Shape()
    var r5 = Shape()
    
    weak var blockVC: BlockViewController? {
        didSet {
            //            r1.delegate = blockVC
            //            r2.delegate = blockVC
            //            r3.delegate = blockVC
            //            r4.delegate = blockVC
            //            r5.delegate = blockVC
            //            r6.delegate = blockVC
            //            r7.delegate = blockVC
            //            r8.delegate = blockVC
            //            r9.delegate = blockVC
            //            r10.delegate = blockVC
            //            r11.delegate = blockVC
            //            r12.delegate = blockVC
            //            r13.delegate = blockVC
        }
    }
    
    override func draw(_ rect: CGRect) {
        addSubview(t1)
        addSubview(t2)
        addSubview(t3)
        addSubview(t4)
        addSubview(t5)
        addSubview(t6)
        addSubview(t7)
        addSubview(t8)
        addSubview(r1)
        addSubview(r2)
        addSubview(r3)
        addSubview(r4)
        addSubview(r5)
    }
    
    override func layoutSubviews() {
        setup()
    }
    
    let color = UIColor(red: 0.889, green: 0.000, blue: 1.000, alpha: 1.000)
    
    func setup() {
        
        let smallTriangleWidth = CGFloat(sqrt((bounds.maxX / 4 * bounds.maxX / 4) + (bounds.maxY / 4 * bounds.maxY / 4)))
        let smallTriangleHeight = smallTriangleWidth / 2
        
        let rectDiag = CGFloat(sqrt((bounds.maxX * bounds.maxX) + (bounds.maxY * bounds.maxY))) / 4
        
        let triangleWidth = CGFloat(sqrt((rectDiag * rectDiag) + (rectDiag * rectDiag)))
        let triangleHeight = triangleWidth / 2
        
        t1 = Shape(frame: CGRect(x: bounds.minX, y: bounds.minY, width: smallTriangleWidth, height: smallTriangleHeight), rotation: CGFloat(45.0), color: color, shapeType: .triangle)
        t2 = Shape(frame: CGRect(x: bounds.maxX / 4, y: bounds.minY, width: triangleWidth, height: triangleHeight), rotation: CGFloat(180.0), color: color, shapeType: .triangle)
        t3 = Shape(frame: CGRect(x: bounds.maxX * 0.75, y: bounds.minY, width: smallTriangleWidth, height: smallTriangleHeight), rotation: CGFloat(315.0), color: color, shapeType: .triangle)
        t4 = Shape(frame: CGRect(x: bounds.minX, y: bounds.maxY / 4, width: triangleWidth, height: triangleHeight), rotation: CGFloat(270.0), color: color, shapeType: .triangle)
        t5 = Shape(frame: CGRect(x: bounds.maxX * 0.75, y: bounds.maxY / 4, width: triangleWidth, height: triangleHeight), rotation: CGFloat(90.0), color: color, shapeType: .triangle)
        t6 = Shape(frame: CGRect(x: bounds.minX, y: bounds.maxY * 0.75, width: smallTriangleWidth, height: smallTriangleHeight), rotation: CGFloat(135.0), color: color, shapeType: .triangle)
        t7 = Shape(frame: CGRect(x: bounds.maxX / 4, y: bounds.maxY * 0.75, width: triangleWidth, height: triangleHeight), rotation: CGFloat(0.0), color: color, shapeType: .triangle)
        t8 = Shape(frame: CGRect(x: bounds.maxX * 0.75, y: bounds.maxY * 0.75, width: smallTriangleWidth, height: smallTriangleHeight), rotation: CGFloat(225.0), color: color, shapeType: .triangle)
        
        r1 = Shape(frame: CGRect(x: bounds.minX, y: bounds.minY, width: rectDiag, height: rectDiag), rotation: CGFloat(45.0), color: color, shapeType: .rectangle)
        r2 = Shape(frame: CGRect(x: bounds.maxX / 2, y: bounds.minY, width: rectDiag, height: rectDiag), rotation: CGFloat(45.0), color: color, shapeType: .rectangle)
        r3 = Shape(frame: CGRect(x: bounds.maxX / 4, y: bounds.maxY / 4, width: rectDiag, height: rectDiag), rotation: CGFloat(45.0), color: color, shapeType: .rectangle)
        r4 = Shape(frame: CGRect(x: bounds.minX, y: bounds.maxY / 2, width: rectDiag, height: rectDiag), rotation: CGFloat(45.0), color: color, shapeType: .rectangle)
        r5 = Shape(frame: CGRect(x: bounds.maxX / 2, y: bounds.maxY / 2, width: rectDiag, height: rectDiag), rotation: CGFloat(45.0), color: color, shapeType: .rectangle)
        
    }
    
    
    
}
