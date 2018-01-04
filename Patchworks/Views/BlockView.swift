//
//  BlockView.swift
//  Patchworks
//
//  Created by Jeremy Reynolds on 12/6/17.
//  Copyright © 2017 Jeremy Reynolds. All rights reserved.
//

import UIKit

class BlockView: UIView {

    enum BlockPattern: String {
        case basketWeave = "basketWeave"
        case churnDash = "churnDash"
        case doubleCross = "doubleCross"
        case logCabin = "logCabin"
    }
    
    weak var blockVC: BlockViewController?
    
    var blockPattern: BlockView.BlockPattern?
    
    lazy var shapes: [ShapeView]? = {
        guard let blockP = blockPattern else {
            return nil
        }
        switch blockP {
        case .basketWeave:
            return basketWeave
        case .churnDash:
            return churnDash
        case .doubleCross:
            return doubleCross
        case .logCabin:
            return logCabin
        }
    }()
    
    convenience init(blockPattern: BlockView.BlockPattern) {
        self.init()
        self.blockPattern = blockPattern
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        guard let shapes = shapes else {
            return
        }
        for shape in shapes {
            addSubview(shape)
            shape.delegate = blockVC
        }
    }
}
