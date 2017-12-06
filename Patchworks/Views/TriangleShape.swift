//
//  TriangleShape.swift
//  Patchworks
//
//  Created by Jeremy Reynolds on 10/26/17.
//  Copyright © 2017 Jeremy Reynolds. All rights reserved.
//

import UIKit

class TriangleShape: UIView {
    
    var shapeReference = UIBezierPath()
    var color = UIColor()
    //        {
    //            didSet {
    //                setNeedsDisplay()
    //            }
    //        }
    var rotation = CGFloat()
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    convenience init(frame: CGRect, rotation: CGFloat, color: UIColor) {
        self.init(frame: frame)
        self.rotation = rotation
        self.color = color
        setup()
    }
    
    override func draw(_ rect: CGRect) {
        let _ = drawTriangle()
    }
    
    func drawTriangle() -> UIBezierPath {
        //        guard let context = UIGraphicsGetCurrentContext() else {
        //            return UIBezierPath()
        //        }
        //        context.saveGState()
        //        shapeReference.apply(CGAffineTransform(translationX: -shapeReference.bounds.minX, y: -shapeReference.bounds.minY))
        color.set()
        shapeReference.fill()
        //        context.restoreGState()
        return shapeReference
    }
    
    func setup() {
        shapeReference = createTriangle()
        frame = CGRect(x: frame.minX, y: frame.minY, width: shapeReference.bounds.width, height: shapeReference.bounds.height)
        shapeReference.apply(CGAffineTransform(translationX: -shapeReference.bounds.minX, y: -shapeReference.bounds.minY))
    }
    
    func createTriangle() -> UIBezierPath {
        let trianglePath = UIBezierPath()
        trianglePath.move(to: CGPoint(x: bounds.midX, y: bounds.minY))
        trianglePath.addLine(to: CGPoint(x: bounds.maxX, y: bounds.maxY))
        trianglePath.addLine(to: CGPoint(x: bounds.minX, y: bounds.maxY))
        let pathTransform = CGAffineTransform(rotationAngle: -rotation * CGFloat.pi / 180)
        trianglePath.apply(pathTransform.concatenating(CGAffineTransform(translationX: bounds.midX, y: bounds.midY)))
        return trianglePath
    }
    
    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        guard shapeReference.contains(point) else {
            return nil
        }
        color = UIColor.yellow
        setNeedsDisplay()
        return self
    }
}
