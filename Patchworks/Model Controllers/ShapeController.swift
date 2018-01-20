//
//  ShapeController.swift
//  Patchworks
//
//  Created by Jeremy Reynolds on 1/3/18.
//  Copyright © 2018 Jeremy Reynolds. All rights reserved.
//

import CoreData

class ShapeController {
    
    static let shared = ShapeController()
    
    // MARK: - C.R.U.D.
    
    // MARK: - Create
    
    func createShapeWith(shapeImageData: Data? = nil, rect: String, rotation: Float, type: String, block: Block) {
        
        guard let shapeImagesDirectoryURL = shapeImagesDirectoryURL else { return }
        
        let imageFileName = "\(UUID().uuidString).jpeg"
        
        try? shapeImageData?.write(to: shapeImagesDirectoryURL.appendingPathComponent(imageFileName))
        
        Shape(rect: rect, rotation: rotation, imageFileName: imageFileName, type: type, block: block)
        
    }
    
    // MARK: - Retrieve
    
    // MARK: - Update
    
    func update(shape: Shape, imageData: Data?) {
        guard let imageData = imageData else {
            if let fileName = shape.imageFileName {
                deleteShapeImage(fileName: fileName)
                shape.imageFileName = nil
            }
            return
        }
        
        guard let shapeImagesDirectoryURL = shapeImagesDirectoryURL else { return }
        
        if shape.imageFileName == nil {
            shape.imageFileName = "\(UUID().uuidString).jpeg"
        }
        
        guard let fileName = shape.imageFileName else { return }
        
            try? imageData.write(to: shapeImagesDirectoryURL.appendingPathComponent(fileName))
    }
    
    func deleteShapeImage(fileName: String) {
        guard let shapeImagesDirectoryURL = shapeImagesDirectoryURL else { return }
        try? FileManager.default.removeItem(at: shapeImagesDirectoryURL.appendingPathComponent(fileName))
    }
    
    // MARK: - Delete
    
    //    func deleteShape() {
    //        Future use
    //    }
    
    var shapeImagesDirectoryURL: URL? {
        guard let documentsDirectoryURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else { return nil }
        
        let shapeImagesDirectoryURL = documentsDirectoryURL.appendingPathComponent("ShapeImages", isDirectory: true)
        
        var objcBool: ObjCBool = true
        let directoryExists = FileManager.default.fileExists(atPath: shapeImagesDirectoryURL.path, isDirectory: &objcBool)
        if !directoryExists {
            do {
                try FileManager.default.createDirectory(atPath: shapeImagesDirectoryURL.path, withIntermediateDirectories: false, attributes: nil)
            } catch {
                print(error)
            }
        }
        return shapeImagesDirectoryURL
    }
}
