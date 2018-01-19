//
//  Block+Convenience.swift
//  Patchworks
//
//  Created by Jeremy Reynolds on 12/20/17.
//  Copyright © 2017 Jeremy Reynolds. All rights reserved.
//

import CoreData

extension Block {
    @discardableResult convenience init(title: String, notes: String? = nil, previewImageFileName: String, context: NSManagedObjectContext = CoreDataStack.context) {
        self.init(context: context)
        self.title = title
        self.notes = notes
        self.previewImageFileName = previewImageFileName
    }
}
