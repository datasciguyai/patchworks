//
//  PatchController.swift
//  Patchworks
//
//  Created by Jeremy Reynolds on 1/3/18.
//  Copyright © 2018 Jeremy Reynolds. All rights reserved.
//

import CoreData

class PatchController {
    
    static let shared = PatchController()
    
    // MARK: - C.R.U.D.
    
    // MARK: - Create
    
    func createPatchWith(patchImageData: Data? = nil, rawRect: String, rotationAngle: Float, type: String, block: Block) {
        
        guard let patchImagesDirectoryURL = patchImagesDirectoryURL else { return }
        
        let imageFileName = "\(UUID().uuidString).jpeg"
        
        try? patchImageData?.write(to: patchImagesDirectoryURL.appendingPathComponent(imageFileName))
        
        Patch(rawRect: rawRect, rotationAngle: rotationAngle, imageFileName: imageFileName, shape: type, block: block)
        
    }
    
    // MARK: - Retrieve
    
    // MARK: - Update
    
    func update(patch: Patch, imageData: Data?) {
        guard let imageData = imageData else {
            if let fileName = patch.imageFileName {
                deletePatchImage(fileName: fileName)
                patch.imageFileName = nil
            }
            return
        }
        
        guard let patchImagesDirectoryURL = patchImagesDirectoryURL else { return }
        
        if patch.imageFileName == nil {
            patch.imageFileName = "\(UUID().uuidString).jpeg"
        }
        
        guard let fileName = patch.imageFileName else { return }
        
            try? imageData.write(to: patchImagesDirectoryURL.appendingPathComponent(fileName))
    }
    
    func deletePatchImage(fileName: String) {
        guard let patchImagesDirectoryURL = patchImagesDirectoryURL else { return }
        try? FileManager.default.removeItem(at: patchImagesDirectoryURL.appendingPathComponent(fileName))
    }
    
    // MARK: - Delete
    
    //    func deletePatch() {
    //        Future use
    //    }
    
    var patchImagesDirectoryURL: URL? {
        guard let documentsDirectoryURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else { return nil }
        
        let patchImagesDirectoryURL = documentsDirectoryURL.appendingPathComponent("PatchImages", isDirectory: true)
        
        var objcBool: ObjCBool = true
        let directoryExists = FileManager.default.fileExists(atPath: patchImagesDirectoryURL.path, isDirectory: &objcBool)
        if !directoryExists {
            do {
                try FileManager.default.createDirectory(atPath: patchImagesDirectoryURL.path, withIntermediateDirectories: false, attributes: nil)
            } catch {
                print(error)
            }
        }
        return patchImagesDirectoryURL
    }
}
