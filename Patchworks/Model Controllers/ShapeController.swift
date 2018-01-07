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
    
//    var shapes = [Shape]()
    
    // MARK: - C.R.U.D.
    
    // MARK: - Create
    
    func add(shape: Shape, block: Block) {
        block.addToRawShapes(shape)
        saveToPersistentStore()
    }
    
    // MARK: - Retrieve
    
    func fetchShapes() -> [Shape] {
        let request: NSFetchRequest<Shape> = Shape.fetchRequest()
        do {
            return try CoreDataStack.context.fetch(request)
        } catch let error {
            print("error \(error)")
        }
        return []
    }
    
    func update(shape: Shape) {
        
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
