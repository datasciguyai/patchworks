//
//  Block+Convenience.swift
//  Patchworks
//
//  Created by Jeremy Reynolds on 12/20/17.
//  Copyright © 2017 Jeremy Reynolds. All rights reserved.
//

import UIKit
import CoreData

extension Block {
    @discardableResult convenience init(context: NSManagedObjectContext = CoreDataStack.context, pattern: String, title: String, previewImage: Data, notes: String? = nil) {
        self.init(context: context)
        self.pattern = pattern
        self.title = title
        self.previewImage = previewImage
        self.notes = notes
    }
}
