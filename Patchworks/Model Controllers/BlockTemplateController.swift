//
//  BlockTemplateController.swift
//  Patchworks
//
//  Created by Jeremy Reynolds on 1/24/18.
//  Copyright © 2018 Jeremy Reynolds. All rights reserved.
//

import Foundation

struct BlockTemplateController {
    
    static let blockTemplates = [
        BlockTemplate(image: #imageLiteral(resourceName: "basketWeave"), title: "Basket Weave", pattern: BlockView.BlockPattern.basketWeave),
        BlockTemplate(image: #imageLiteral(resourceName: "churnDash"), title: "Churn Dash", pattern: BlockView.BlockPattern.churnDash),
        BlockTemplate(image: #imageLiteral(resourceName: "doubleCross"), title: "Double Cross", pattern: BlockView.BlockPattern.doubleCross),
        BlockTemplate(image: #imageLiteral(resourceName: "logCabin"), title: "Log Cabin", pattern: BlockView.BlockPattern.logCabin)
    ]
}
