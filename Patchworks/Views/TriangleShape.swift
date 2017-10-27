//
//  RectShape.swift
//  Patchworks
//
//  Created by Jeremy Reynolds on 10/26/17.
//  Copyright © 2017 Jeremy Reynolds. All rights reserved.
//

import UIKit

class TriangleShape: UIView {
    
    var shapeReference = UIBezierPath()
    var image = UIImage()
    var color = UIColor(cgColor: UIColor.red.cgColor)
    
    var triangle: UIBezierPath {
        guard let context = UIGraphicsGetCurrentContext() else {
            return UIBezierPath()
        }
        context.saveGState()
        let trianglePath = UIBezierPath()
        
        
        
        trianglePath.move(to: CGPoint(x: 60.54, y: 36))
        trianglePath.addLine(to: CGPoint(x: -4.46, y: -36))
        trianglePath.addLine(to: CGPoint(x: -60.54, y: 35.68))
        trianglePath.addLine(to: CGPoint(x: 60.54, y: 36))
        
        
        
        
        trianglePath.close()
        color.setFill()
        trianglePath.fill()
        let pathTransform = CGAffineTransform(rotationAngle: 10 * CGFloat.pi/180)
        trianglePath.apply(pathTransform.concatenating(CGAffineTransform(translationX: 67, y: 41)))
        
//        trianglePath.addClip()
//        context.scaleBy(x: 1, y: -1)
//        if let cgImage = image.cgImage {
//            context.draw(cgImage, in: CGRect(x: -50, y: 50, width: image.size.width, height: image.size.height), byTiling: true)
//        }
        context.restoreGState()
        return trianglePath
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    override func draw(_ rect: CGRect) {
        shapeReference = triangle
    }
    
    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        guard shapeReference.contains(point) else {
            return nil
        }
        return self
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first,  let image = UIImage(named: "testImage2") else {
            return
        }
        let point = touch.location(in: self)
        if shapeReference.contains(point) {
            //self.image = image
            color = UIColor.blue
            setNeedsDisplay()
        }
    }
}
