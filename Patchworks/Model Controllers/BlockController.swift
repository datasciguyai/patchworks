//
//  BlockController.swift
//  Patchworks
//
//  Created by Jeremy Reynolds on 12/15/17.
//  Copyright © 2017 Jeremy Reynolds. All rights reserved.
//

import CoreData

class BlockController {
    
    static let shared = BlockController()
    
    var block: Block?
    
    // MARK: - Retrieve
    
    var blocks: [Block] {
        let request: NSFetchRequest<Block> = Block.fetchRequest()
        do {
            return try CoreDataStack.context.fetch(request)
        } catch let error {
            print("There was a problem fetching objects: \(error)")
        }
        return []
    }
    
    // MARK: - Create
    
    func createBlockWith(blockThumbnailData: Data, title: String, notes: String? = nil) {
        
        guard let blockThumbnailsDirectoryURL = blockThumbnailsDirectoryURL else { return }
        
        let previewImageFileName: String = "\(Date.timeIntervalSinceReferenceDate).jpeg"
        
        try? blockThumbnailData.write(to: blockThumbnailsDirectoryURL.appendingPathComponent(previewImageFileName))
        
        block = Block(title: title, notes: nil, previewImageFileName: previewImageFileName)
    }
    
    // MARK: - Update
    
    func update(block: Block, blockThumbnailData: Data, title: String, notes: String? = nil) {
            guard let blockThumbnailsDirectoryURL = blockThumbnailsDirectoryURL, let previewImageFileName = block.previewImageFileName else { return }
        
        try? blockThumbnailData.write(to: blockThumbnailsDirectoryURL.appendingPathComponent(previewImageFileName))
        
        block.title = title
        block.notes = notes
        
        }
    
    // MARK: - Delete
    
    func delete(block: Block) {
        guard let managedObjectContext = block.managedObjectContext, let shapesURL = ShapeController.shared.shapeImagesDirectoryURL, let shapes = block.rawShapes?.array as? [Shape] else { return }
        for shape in shapes {
            if let imageFileName = shape.imageFileName {
            try? FileManager.default.removeItem(at: shapesURL.appendingPathComponent(imageFileName))
            }
        }
        guard let blockURL = blockThumbnailsDirectoryURL, let blockImageFileName = block.previewImageFileName else { return }
        
        try? FileManager.default.removeItem(at: blockURL.appendingPathComponent(blockImageFileName))
        
        managedObjectContext.delete(block)
        saveToPersistentStore()
    }
    
    // MARK: - Save
    
    func saveToPersistentStore() {
        do {
            try CoreDataStack.context.save()
        } catch let error {
            print("There was a problem saving to the peristent store: \(error)")
        }
    }
    
    var blockThumbnailsDirectoryURL: URL? {
        guard let documentsDirectoryURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else { return nil }
        
        let blockThumbnailsDirectoryURL = documentsDirectoryURL.appendingPathComponent("BlockThumbnails", isDirectory: true)
        
        var objcBool: ObjCBool = true
        let directoryExists = FileManager.default.fileExists(atPath: blockThumbnailsDirectoryURL.path, isDirectory: &objcBool)
        if !directoryExists {
            do {
                try FileManager.default.createDirectory(atPath: blockThumbnailsDirectoryURL.path, withIntermediateDirectories: false, attributes: nil)
            } catch {
                print(error)
            }
        }
        return blockThumbnailsDirectoryURL
    }
}
