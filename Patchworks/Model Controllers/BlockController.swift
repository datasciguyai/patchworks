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
    
    // MARK: - Create
    
    func createBlockWith(blockThumbnailData: Data, title: String, notes: String? = nil) {
        
        guard let blockThumbnailsDirectoryURL = blockThumbnailsDirectoryURL else { return }
        
        let blockThumbnailFileName: String = "\(Date.timeIntervalSinceReferenceDate).jpeg"
        
        try? blockThumbnailData.write(to: blockThumbnailsDirectoryURL.appendingPathComponent(blockThumbnailFileName))
        
        block = Block(title: title, notes: notes, thumbnailFileName: blockThumbnailFileName)
    }
    
    // MARK: - Retrieve
    
    //    private var blocks: [Block] {
    //        let request: NSFetchRequest<Block> = Block.fetchRequest()
    //        do {
    //            return try CoreDataStack.context.fetch(request)
    //        } catch let error {
    //            print("There was a problem fetching objects: \(error)")
    //        }
    //        return []
    //    }
    
    // MARK: - Update
    
    func update(block: Block, blockThumbnailData: Data, title: String, notes: String? = nil) {
        guard let blockThumbnailsDirectoryURL = blockThumbnailsDirectoryURL, let previewImageFileName = block.thumbnailFileName else { return }
        
        try? blockThumbnailData.write(to: blockThumbnailsDirectoryURL.appendingPathComponent(previewImageFileName))
        
        block.title = title
        block.notes = notes
    }
    
    // MARK: - Delete
    
    func delete(block: Block) {
        guard let managedObjectContext = block.managedObjectContext, let patchesURL = PatchController.shared.patchImagesDirectoryURL, let patches = block.patches?.array as? [Patch] else { return }
        for patch in patches {
            if let imageFileName = patch.imageFileName {
                try? FileManager.default.removeItem(at: patchesURL.appendingPathComponent(imageFileName))
            }
        }
        guard let blockURL = blockThumbnailsDirectoryURL, let blockImageFileName = block.thumbnailFileName else { return }
        
        try? FileManager.default.removeItem(at: blockURL.appendingPathComponent(blockImageFileName))
        
        managedObjectContext.delete(block)
        saveToPersistentStore()
    }
    
    // MARK: - Save
    
    func saveToPersistentStore() {
        do {
            try CoreDataStack.context.save()
        } catch let error {
            print("There was a problem saving to the persistent store: \(error)")
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
