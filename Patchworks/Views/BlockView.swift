//
//  BlockView.swift
//  Patchworks
//
//  Created by Jeremy Reynolds on 12/6/17.
//  Copyright © 2017 Jeremy Reynolds. All rights reserved.
//

import UIKit

class BlockView: UIView {

    enum BlockPattern {
        case basketWeave
        case churnDash
        case doubleCross
        case logCabin
    }
    
    weak var blockVC: BlockViewController?
    
    var blockPattern: BlockView.BlockPattern?
    
    lazy var shapeViews: [ShapeView]? = {
        guard let blockPattern = blockPattern else {
            return nil
        }
        switch blockPattern {
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
    
    convenience init(shapesViews: [ShapeView]) {
        self.init()
        self.shapeViews = shapesViews
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        guard let shapeViews = shapeViews else {
            return
        }
        for shapeView in shapeViews {
            addSubview(shapeView)
            shapeView.delegate = blockVC
        }
    }
}
