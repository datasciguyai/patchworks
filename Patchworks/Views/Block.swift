//
//  Block.swift
//  Patchworks
//
//  Created by Jeremy Reynolds on 12/6/17.
//  Copyright © 2017 Jeremy Reynolds. All rights reserved.
//

import UIKit

@IBDesignable
class Block: UIView {
    
    var t = TriangleShape(frame: CGRect(x: 0, y: 0, width: 300, height: 100), rotation: CGFloat(0.0), color: UIColor.blue)
    
    weak var blockVC: BlockViewController? {
        didSet {
            t.delegate = blockVC
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    override func draw(_ rect: CGRect) {
        addSubview(t)
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            if let t = hitTest(touch.location(in: self), with: event) {
                if t != self {
                    print("Success")
                }
            }
        }
    }
}

