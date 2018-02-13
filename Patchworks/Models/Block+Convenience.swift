//
//  Block+Convenience.swift
//  Patchworks
//
//  Created by Jeremy Reynolds on 12/20/17.
//  Copyright © 2017 Jeremy Reynolds. All rights reserved.
//

import CoreData

extension Block {
    @discardableResult convenience init(title: String, notes: String? = nil, thumbnailFileName: String, isFavorite: Bool = false, position: Int16 = 0, context: NSManagedObjectContext = CoreDataStack.context) {
        self.init(context: context)
        self.title = title
        self.notes = notes
        self.isFavorite = isFavorite
        self.position = position
        self.thumbnailFileName = thumbnailFileName
    }
}
