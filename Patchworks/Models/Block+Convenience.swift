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
    @discardableResult convenience init(blockView: BlockView, previewImage: UIImage, context: NSManagedObjectContext = CoreDataStack.context) {
        self.init(context: context)
        self.blockView = blockView
        self.previewImage = previewImage
    }
}
