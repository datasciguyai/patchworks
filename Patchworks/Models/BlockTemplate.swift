//
//  BlockTemplate.swift
//  Patchworks
//
//  Created by Jeremy Reynolds on 1/24/18.
//  Copyright © 2018 Jeremy Reynolds. All rights reserved.
//

import UIKit

struct BlockTemplate {
    
    var blockTemplateImage: UIImage
    var blockTemplateTitle: String
    var blockTemplatePattern: BlockView.BlockPattern
    
    init(image: UIImage, title: String, pattern: BlockView.BlockPattern) {
        blockTemplateImage = image
        blockTemplateTitle = title
        blockTemplatePattern = pattern
    }
}
