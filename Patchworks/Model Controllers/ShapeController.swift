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
    
    var shapes = [Shape]()
    
    // MARK: - C.R.U.D.
    
    // MARK: - Create
    
    func createShapeWith(rect: String, rotation: Float, imageFileName: String? = nil, type: String, block: Block) {
        Shape(rect: rect, rotation: rotation, imageFileName: imageFileName, type: type, block: block)
    }
    
    // MARK: - Retrieve
    
    // MARK: - Update
    
    func update() {
        
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
