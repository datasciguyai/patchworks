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
    var color = UIColor()
    var rotation = CGFloat()
    var image: UIImage? {
        didSet {
            setNeedsDisplay()
        }
    }
    
    weak var delegate: RectangleShapeDelegate?
    
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
        let _ = drawRectangle()
    }
    
    func drawRectangle() -> UIBezierPath {
        if let image = image {
            if let context = UIGraphicsGetCurrentContext()  {
                context.saveGState()
                shapeReference.addClip()
                context.scaleBy(x: 1, y: -1)
                context.draw(image.cgImage!, in: CGRect(x: bounds.minX, y: bounds.minY, width: CGFloat(200), height: CGFloat(200)), byTiling: true)
                context.restoreGState()
                UIColor.black.setStroke()
                shapeReference.lineCapStyle = .round
                shapeReference.lineJoinStyle = .round
                shapeReference.stroke()
            }
        } else {
            shapeReference.lineWidth = 5.0
            color.set()
            UIColor.black.setStroke()
            shapeReference.fill()
            shapeReference.stroke()
        }
        return shapeReference
    }
    
//    func scaleImage(image: UIImage) -> UIImage {
//        if let cgImage = image.cgImage {
//
//            let width = cgImage.width / 8
//            let height = cgImage.height / 8
//            let bitsPerComponent = cgImage.bitsPerComponent
//            let bytesPerRow = cgImage.bytesPerRow
//            let colorSpace = cgImage.colorSpace
//            let bitmapInfo = cgImage.bitmapInfo
//
//            if let colorSpace = colorSpace {
//                let context = CGContext(data: nil, width: width, height: height, bitsPerComponent: bitsPerComponent, bytesPerRow: bytesPerRow, space: colorSpace, bitmapInfo: bitmapInfo.rawValue)
//
//                context?.interpolationQuality = .high
//
//                context?.draw(cgImage, in: CGRect(x: bounds.minX, y: bounds.minY, width: CGFloat(width), height: CGFloat(height)))
//                
//                //        CGContextDrawImage(context, CGRect(origin: CGPointZero, size: CGSize(width: CGFloat(width), height: CGFloat(height))), cgImage)
//
//                let i = context!.makeImage().flatMap { UIImage(cgImage: $0) }!
//                return i
//            }
//
//        }
//        return UIImage()
//    }
    
    func setup() {
        backgroundColor = UIColor.clear
        shapeReference = createRectangle()
        frame = CGRect(x: frame.minX, y: frame.minY, width: shapeReference.bounds.width, height: shapeReference.bounds.height)
        shapeReference.apply(CGAffineTransform(translationX: -shapeReference.bounds.minX, y: -shapeReference.bounds.minY))
    }
    
    func createRectangle() -> UIBezierPath {
        let rectanglePath = UIBezierPath(rect: bounds)
        let pathTransform = CGAffineTransform(rotationAngle: -rotation * CGFloat.pi / 180)
        rectanglePath.apply(pathTransform.concatenating(CGAffineTransform(translationX: bounds.midX, y: bounds.midY)))
        return rectanglePath
    }
    
    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        guard shapeReference.contains(point) else {
            return nil
        }
        delegate?.onRectShapeClicked(self)
        setNeedsDisplay()
        return self
    }
}

protocol RectangleShapeDelegate: class {
    func onRectShapeClicked(_ sender: RectangleShape)
}
