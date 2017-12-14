//
//  ShapeView.swift
//  Patchworks
//
//  Created by Jeremy Reynolds on 12/6/17.
//  Copyright © 2017 Jeremy Reynolds. All rights reserved.
//

import UIKit

class ShapeView: UIView {
    
    enum shape {
        case rectangle
        case triangle
    }
    
    var shapePath = UIBezierPath()
    var strokeColor = UIColor()
    var fillColor = UIColor()
    var rotation = CGFloat()
    var image: UIImage? {
        didSet {
            setNeedsDisplay()
        }
    }
    
    weak var delegate: ShapeDelegate?
    
    convenience init(frame: CGRect, rotation: CGFloat, color: UIColor, shapeType: shape) {
        self.init(frame: frame)
        self.rotation = rotation
        self.strokeColor = color
        self.fillColor = strokeColor.withAlphaComponent(0.3)
        setup(shape: shapeType)
    }
    
    override func draw(_ rect: CGRect) {
        let _ = drawShape()
    }
    
    func drawShape() -> UIBezierPath {
        if let image = image?.cgImage {
            if let context = UIGraphicsGetCurrentContext()  {
                context.saveGState()
                shapePath.addClip()
                context.scaleBy(x: 1, y: -1)
                context.draw(image, in: CGRect(x: bounds.minX, y: bounds.minY, width: CGFloat(200), height: CGFloat(200)), byTiling: true)
                context.restoreGState()
//                UIColor.black.setStroke()
//                shapePath.lineJoinStyle = .round
//                shapePath.stroke()
            }
        } else {
            shapePath.lineWidth = 5.0
            fillColor.setFill()
            shapePath.fill()
            strokeColor.setStroke()
            shapePath.stroke()
        }
        return shapePath
    }
    
    func setup(shape: shape = .rectangle) {
        backgroundColor = UIColor.clear
        if shape == .triangle {
            shapePath = createTriangle()
        } else {
            shapePath = createRectangle()
        }
        frame = CGRect(x: frame.minX, y: frame.minY, width: shapePath.bounds.width, height: shapePath.bounds.height)
        shapePath.apply(CGAffineTransform(translationX: -shapePath.bounds.minX, y: -shapePath.bounds.minY))
    }
    
    func createTriangle() -> UIBezierPath {
        let trianglePath = UIBezierPath()
        trianglePath.move(to: CGPoint(x: bounds.midX, y: bounds.minY))
        trianglePath.addLine(to: CGPoint(x: bounds.maxX, y: bounds.maxY))
        trianglePath.addLine(to: CGPoint(x: bounds.minX, y: bounds.maxY))
        trianglePath.close()
        let pathTransform = CGAffineTransform(rotationAngle: -rotation * CGFloat.pi / 180)
        trianglePath.apply(pathTransform.concatenating(CGAffineTransform(translationX: bounds.midX, y: bounds.midY)))
        return trianglePath
    }
    
    func createRectangle() -> UIBezierPath {
        let rectanglePath = UIBezierPath(rect: bounds)
        let pathTransform = CGAffineTransform(rotationAngle: -rotation * CGFloat.pi / 180)
        rectanglePath.apply(pathTransform.concatenating(CGAffineTransform(translationX: bounds.midX, y: bounds.midY)))
        return rectanglePath
    }
    
    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        guard shapePath.contains(point) else {
            return nil
        }
        delegate?.shapeClicked(self)
        setNeedsDisplay()
        return self
    }
}

protocol ShapeDelegate: class {
    func shapeClicked(_ sender: ShapeView)
}
