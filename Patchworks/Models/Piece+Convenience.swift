//
//  Piece+Convenience.swift
//  Patchworks
//
//  Created by Jeremy Reynolds on 1/3/18.
//  Copyright © 2018 Jeremiah Reynolds. All rights reserved.
//

import CoreData

extension Piece {
    @discardableResult convenience init(rawRect: String, rotationAngle: Float, imageFileName: String? = nil, shape: Int16, block: Block, context: NSManagedObjectContext = CoreDataStack.context) {
        self.init(context: context)
        self.rawRect = rawRect
        self.rotationAngle = rotationAngle
        self.imageFileName = imageFileName
        self.shape = shape
        self.block = block
    }
}
