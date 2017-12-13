//
//  Block.swift
//  Patchworks
//
//  Created by Jeremy Reynolds on 12/6/17.
//  Copyright © 2017 Jeremy Reynolds. All rights reserved.
//

import UIKit

@IBDesignable


//Basket Weave

class Block: UIView {
    
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
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    override func draw(_ rect: CGRect) {
        addSubview(r1)
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
    }
    
    override func layoutSubviews() {
        setup()
    }
    
    func setup() {
        r1 = Shape(frame: CGRect(x: bounds.minX, y: bounds.minY, width: bounds.midX, height: bounds.midY / 3), rotation: CGFloat(0.0), color: UIColor.red, shapeType: .rectangle)
        r2 = Shape(frame: CGRect(x: bounds.minX, y: bounds.midY / 3, width: bounds.midX, height: bounds.midY / 3), rotation: CGFloat(0.0), color: UIColor.red, shapeType: .rectangle)
        r3 = Shape(frame: CGRect(x: bounds.minX, y: bounds.midY / 1.5, width: bounds.midX, height: bounds.midY / 3), rotation: CGFloat(0.0), color: UIColor.red, shapeType: .rectangle)
        r4 = Shape(frame: CGRect(x: bounds.minX, y: bounds.midY, width: bounds.midX / 3, height: bounds.midY), rotation: CGFloat(0.0), color: UIColor.red, shapeType: .rectangle)
        r5 = Shape(frame: CGRect(x: bounds.midX / 3, y: bounds.midY, width: bounds.midX / 3, height: bounds.midY), rotation: CGFloat(0.0), color: UIColor.red, shapeType: .rectangle)
        r6 = Shape(frame: CGRect(x: bounds.midX / 1.5, y: bounds.midY, width: bounds.midX / 3, height: bounds.midY), rotation: CGFloat(0.0), color: UIColor.red, shapeType: .rectangle)
        r7 = Shape(frame: CGRect(x: bounds.midX, y: bounds.minY, width: bounds.midX / 3, height: bounds.midY), rotation: CGFloat(0.0), color: UIColor.red, shapeType: .rectangle)
        r8 = Shape(frame: CGRect(x: bounds.midX / 0.75, y: bounds.minY, width: bounds.midX / 3, height: bounds.midY), rotation: CGFloat(0.0), color: UIColor.red, shapeType: .rectangle)
        r9 = Shape(frame: CGRect(x: bounds.midX / 0.6, y: bounds.minY, width: bounds.midX / 3, height: bounds.midY), rotation: CGFloat(0.0), color: UIColor.red, shapeType: .rectangle)
        r10 = Shape(frame: CGRect(x: bounds.midX, y: bounds.midY, width: bounds.midX, height: bounds.midY / 3), rotation: CGFloat(0.0), color: UIColor.red, shapeType: .rectangle)
        r11 = Shape(frame: CGRect(x: bounds.midX, y: bounds.midY / 0.75, width: bounds.midX, height: bounds.midY / 3), rotation: CGFloat(0.0), color: UIColor.red, shapeType: .rectangle)
        r12 = Shape(frame: CGRect(x: bounds.midX, y: bounds.midY / 0.6, width: bounds.midX, height: bounds.midY / 3), rotation: CGFloat(0.0), color: UIColor.red, shapeType: .rectangle)
    }
    
    //    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
    //        if let touch = touches.first {
    //            if let t = hitTest(touch.location(in: self), with: event) {
    //                if t != self {
    //                    print("Success")
    //                }
    //            }
    //        }
    //    }
}
