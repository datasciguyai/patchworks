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
    var rotation = CGFloat()
    var image: UIImage? {
        didSet {
            setNeedsDisplay()
        }
    }
    
    weak var delegate: TriangleShapeDelegate?
    
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
        if let image = image {
            if let context = UIGraphicsGetCurrentContext()  {
                context.saveGState()
                shapeReference.addClip()
                context.scaleBy(x: 1, y: -1)
                context.draw(image.cgImage!, in: CGRect(x: bounds.minX, y: bounds.minY, width: image.size.width, height: image.size.height), byTiling: true)
                context.restoreGState()
            }
        } else {
            shapeReference.lineWidth = 5.0
            color.set()
            UIColor.red.setStroke()
            shapeReference.fill()
            shapeReference.stroke()
        }
        return shapeReference
    }
    
    func setup() {
        backgroundColor = UIColor.clear
        shapeReference = createTriangle()
        frame = CGRect(x: frame.minX, y: frame.minY, width: shapeReference.bounds.width, height: shapeReference.bounds.height)
        shapeReference.apply(CGAffineTransform(translationX: -shapeReference.bounds.minX, y: -shapeReference.bounds.minY))
//        tag = 1
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
        //color = UIColor.yellow
        delegate?.onShapeClicked(self)
        setNeedsDisplay()
        return self
    }
}

protocol TriangleShapeDelegate: class {
    func onShapeClicked(_ sender: TriangleShape)
}
