//
//  RectangleShape.swift
//  Patchworks
//
//  Created by Jeremy Reynolds on 12/5/17.
//  Copyright © 2017 Jeremy Reynolds. All rights reserved.
//

import UIKit

class RectangleShape: UIView {
    
    var shapeReference = UIBezierPath()
    var image = UIImage()
    var color = UIColor() {
        didSet {
            setNeedsDisplay()
        }
    }
    var b = CGRect()
    var rotation = CGFloat()
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    convenience init(frame: CGRect, color: UIColor) {
        self.init(frame: frame)
        self.color = color
        setup()
    }
    
    override func draw(_ rect: CGRect) {
        let _ = d()
    }
    
    //    func setup() {
    //
    //        let shapeLayer = CAShapeLayer()
    //
    //        shapeLayer.path = createTriangle().cgPath
    //
    //        shapeLayer.strokeColor = UIColor.blue.cgColor
    //        shapeLayer.fillColor = UIColor.white.cgColor
    //        shapeLayer.lineWidth = 1.0
    //
    //        shapeLayer.position = CGPoint(x: 10, y: 10)
    //        layer.addSublayer(shapeLayer)
    //        self.frame = shapeLayer.bounds
    //
    //    }
    
    func d() -> UIBezierPath {
        guard let context = UIGraphicsGetCurrentContext() else {
            return UIBezierPath()
        }
        context.saveGState()
        color.set()
        shapeReference.fill()
        context.restoreGState()
        return shapeReference
    }
    
    func setup() {
        //backgroundColor = UIColor.clear
        shapeReference = createRectangle()
    }
    
    func createRectangle() -> UIBezierPath {
        return UIBezierPath(rect: bounds)
    }
    
    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        guard shapeReference.contains(point) else {
            return nil
        }
        return self
    }
    
}
