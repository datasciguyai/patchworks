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
    @discardableResult convenience init(context: NSManagedObjectContext = CoreDataStack.context, tag: Int16, image: Data) {
        self.init(context: context)
        self.tag = tag
        self.image = image
    }
}
