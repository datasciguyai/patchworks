//
//  BlockController.swift
//  Patchworks
//
//  Created by Jeremy Reynolds on 12/15/17.
//  Copyright © 2017 Jeremy Reynolds. All rights reserved.
//

import UIKit
import CoreData

class BlockController {
    
    static let shared = BlockController()
    
    var blocks = [Block]()
    
    //    init() {
    //        blocks = fetchBlocks()
    //    }
    
    // MARK: - C.R.U.D.
    
    // MARK: - Add
    
    func add() {
        //        guard let notes = notes, let due = due else { return }
        //        tasks.append(Task(name: name, notes: notes, due: due))
        saveToPersistentStore()
        blocks = fetchBlocks()
    }
    
    // MARK: - Retrieve
    
    func fetchBlocks() -> [Block] {
        let request: NSFetchRequest<Block> = Block.fetchRequest()
        do {
            return try CoreDataStack.context.fetch(request)
        } catch let error {
            print("error \(error)")
        }
        return []
    }
    
    // MARK: - Update
    
    func update(block: Block, previewImage: UIImage) {
//        guard let blockIndex = blocks.index(of: block) else { return }
//        blocks[blockIndex].previewImage = previewImage
        saveToPersistentStore()
        blocks = fetchBlocks()
    }
    
    // MARK: - Delete
    
    func remove(block: Block) {
        guard let blockIndex = blocks.index(of: block) else { return }
        blocks.remove(at: blockIndex)
        saveToPersistentStore()
        blocks = fetchBlocks()
    }
    
    // MARK: - Save
    
    func saveToPersistentStore() {
        do {
            try CoreDataStack.context.save()
        } catch let error {
            print("There was a problem saving to the peristent store: \(error)")
        }
    }
    
}
