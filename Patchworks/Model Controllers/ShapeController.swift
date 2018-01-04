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
}
