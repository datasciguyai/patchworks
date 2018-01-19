//
//  Shape+Convenience.swift
//  Patchworks
//
//  Created by Jeremy Reynolds on 1/3/18.
//  Copyright © 2018 Jeremy Reynolds. All rights reserved.
//

import CoreData

extension Shape {
    @discardableResult convenience init(rect: String, rotation: Float, imageFileName: String? = nil, type: String, block: Block, context: NSManagedObjectContext = CoreDataStack.context) {
        self.init(context: context)
        self.rect = rect
        self.rotation = rotation
        self.imageFileName = imageFileName
        self.type = type
        self.block = block
    }
}
