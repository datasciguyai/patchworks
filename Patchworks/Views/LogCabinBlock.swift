//
//  LogCabinBlock.swift
//  Patchworks
//
//  Created by Jeremy Reynolds on 12/7/17.
//  Copyright © 2017 Jeremy Reynolds. All rights reserved.
//

import UIKit

//@IBDesignable

// Log Cabin
class LogCabinBlock: UIView {
    
    var r1 = Shape()
    var r2 = Shape()
    var r3 = Shape()
    var r4 = Shape()
    var r5 = Shape()
    var r6 = Shape()
    var r7 = Shape()
    var r8 = Shape()
    var r9 = Shape()
    var r10 = Shape()
    var r11 = Shape()
    var r12 = Shape()
    var r13 = Shape()
    
    weak var blockVC: BlockViewController? {
        didSet {
            r1.delegate = blockVC
            r2.delegate = blockVC
            r3.delegate = blockVC
            r4.delegate = blockVC
            r5.delegate = blockVC
            r6.delegate = blockVC
            r7.delegate = blockVC
            r8.delegate = blockVC
            r9.delegate = blockVC
            r10.delegate = blockVC
            r11.delegate = blockVC
            r12.delegate = blockVC
            r13.delegate = blockVC
        }
    }
    
    override func draw(_ rect: CGRect) {
//        addSubview(r1)
        addSubview(r2)
        addSubview(r3)
        addSubview(r4)
        addSubview(r5)
        addSubview(r6)
        addSubview(r7)
        addSubview(r8)
        addSubview(r9)
        addSubview(r10)
        addSubview(r11)
        addSubview(r12)
        addSubview(r13)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    override func layoutSubviews() {
        setup()
        r1.delegate = blockVC
    }
    
    let color = UIColor(red: 0.889, green: 0.000, blue: 1.000, alpha: 1.000)
    
    func setup() {
        r1 = Shape(frame: CGRect(x: bounds.maxX * 0.875, y: bounds.minY, width: bounds.maxX * 0.125, height: bounds.maxY), rotation: CGFloat(0.0), color: color, shapeType: .rectangle)
        addSubview(r1)
        r2 = Shape(frame: CGRect(x: bounds.minX, y: bounds.maxY * 0.875, width: bounds.maxX * 0.875, height: bounds.maxY * 0.125), rotation: CGFloat(0.0), color: color, shapeType: .rectangle)
        r3 = Shape(frame: CGRect(x: bounds.minX, y: bounds.minY, width: bounds.maxX * 0.125, height: bounds.maxY * 0.875), rotation: CGFloat(0.0), color: color, shapeType: .rectangle)
        r4 = Shape(frame: CGRect(x: bounds.maxX * 0.125, y: bounds.minY, width: bounds.maxX * 0.75, height: bounds.maxY * 0.125), rotation: CGFloat(0.0), color: color, shapeType: .rectangle)
        r5 = Shape(frame: CGRect(x: bounds.maxX * 0.75, y: bounds.maxY * 0.125, width: bounds.maxX * 0.125, height: bounds.maxY * 0.75), rotation: CGFloat(0.0), color: color, shapeType: .rectangle)
        r6 = Shape(frame: CGRect(x: bounds.maxX * 0.125, y: bounds.maxY * 0.75, width: bounds.maxX * 0.625, height: bounds.maxY * 0.125), rotation: CGFloat(0.0), color: color, shapeType: .rectangle)
        r7 = Shape(frame: CGRect(x: bounds.maxX * 0.125, y: bounds.maxY * 0.125, width: bounds.maxX * 0.125, height: bounds.maxY * 0.625), rotation: CGFloat(0.0), color: color, shapeType: .rectangle)
        r8 = Shape(frame: CGRect(x: bounds.maxX * 0.25, y: bounds.maxY * 0.125, width: bounds.maxX * 0.50, height: bounds.maxY * 0.125), rotation: CGFloat(0.0), color: color, shapeType: .rectangle)
        r9 = Shape(frame: CGRect(x: bounds.maxX * 0.625, y: bounds.maxY * 0.25, width: bounds.maxX * 0.125, height: bounds.maxY * 0.50), rotation: CGFloat(0.0), color: color, shapeType: .rectangle)
        r10 = Shape(frame: CGRect(x: bounds.maxX * 0.25, y: bounds.maxY * 0.625, width: bounds.maxX * 0.375, height: bounds.maxY * 0.125), rotation: CGFloat(0.0), color: color, shapeType: .rectangle)
        r11 = Shape(frame: CGRect(x: bounds.maxX * 0.25, y: bounds.maxY * 0.25, width: bounds.maxX * 0.125, height: bounds.maxY * 0.375), rotation: CGFloat(0.0), color: color, shapeType: .rectangle)
        r12 = Shape(frame: CGRect(x: bounds.maxX * 0.375, y: bounds.maxY * 0.25, width: bounds.maxX * 0.25, height: bounds.maxY * 0.125), rotation: CGFloat(0.0), color: color, shapeType: .rectangle)
        r13 = Shape(frame: CGRect(x: bounds.maxX * 0.375, y: bounds.maxY * 0.375, width: bounds.maxX * 0.25, height: bounds.maxY * 0.25), rotation: CGFloat(0.0), color: color, shapeType: .rectangle)
    }
}
