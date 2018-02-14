//
//  PieceView.swift
//  Patchworks
//
//  Created by Jeremy Reynolds on 12/6/17.
//  Copyright © 2017 Jeremy Reynolds. All rights reserved.
//

import UIKit

class PieceView: UIView {
    
    enum Shape: Int16 {
        case rectangle = 0
        case triangle = 1
    }
    
    var shapePath = UIBezierPath()
    var originalFrame = CGRect()
    var shape = Shape.rectangle
    var strokeColor = UIColor.pieceStrokeColor
    var fillColor = UIColor.pieceFillColor
    var rotationAngle = CGFloat()
    var image: UIImage? {
        didSet {
            setNeedsDisplay()
        }
    }
    
    weak var delegate: PieceDelegate?
    
    convenience init(frame: CGRect, rotationAngle: CGFloat, image: UIImage? = nil, shape: Shape) {
        self.init(frame: frame)
        self.originalFrame = frame
        self.rotationAngle = rotationAngle
        self.image = image
        self.shape = shape
        setup(shape: shape)
    }
    
    override func draw(_ rect: CGRect) {
        drawShape()
    }
    
    @discardableResult func drawShape() -> UIBezierPath {
        if let image = image?.cgImage {
            if let context = UIGraphicsGetCurrentContext()  {
                context.saveGState()
                shapePath.addClip()
                context.scaleBy(x: 1, y: -1)
                context.draw(image, in: CGRect(x: bounds.minX, y: bounds.minY, width: CGFloat(shapePath.bounds.width), height: CGFloat(shapePath.bounds.height)), byTiling: true)
                context.restoreGState()
//                UIColor.black.setStroke()
//                shapePath.lineJoinStyle = .round
//                shapePath.stroke()
            }
        } else {
            shapePath.lineWidth = 5.0
            fillColor?.setFill()
            shapePath.fill()
            strokeColor?.setStroke()
            shapePath.stroke()
        }
        return shapePath
    }
    
    func removeImage() {
        if image != nil {
            image = nil
        }
    }
    
    func setup(shape: Shape = .rectangle) {
        backgroundColor = UIColor.clear
        if shape == .triangle {
            shapePath = triangle
        } else {
            shapePath = rectangle
        }
        frame = CGRect(x: frame.minX, y: frame.minY, width: shapePath.bounds.width, height: shapePath.bounds.height)
        shapePath.apply(CGAffineTransform(translationX: -shapePath.bounds.minX, y: -shapePath.bounds.minY))
    }
    
    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        guard shapePath.contains(point) else {
            return nil
        }
        delegate?.pieceClicked(self)
        return self
    }
}

protocol PieceDelegate: class {
    func pieceClicked(_ sender: PieceView)
}
