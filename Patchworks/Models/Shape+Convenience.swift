//
//  Shape+Convenience.swift
//  Patchworks
//
//  Created by Jeremy Reynolds on 1/3/18.
//  Copyright © 2018 Jeremy Reynolds. All rights reserved.
//

import UIKit
import CoreData

extension Shape {
    @discardableResult convenience init(rect: String, rotation: Float, tag: Int64, image: Data?, type: String, context: NSManagedObjectContext = CoreDataStack.context) {
        self.init(context: context)
        self.rect = rect
        self.rotation = rotation
        self.tag = tag
        self.image = image
        self.type = type
    }
}
