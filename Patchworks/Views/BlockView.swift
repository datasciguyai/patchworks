//
//  BlockView.swift
//  Patchworks
//
//  Created by Jeremy Reynolds on 12/6/17.
//  Copyright © 2017 Jeremy Reynolds. All rights reserved.
//

import UIKit

class BlockView: UIView {

    enum block {
        case basketWeave
        case churnDash
        case doubleCross
        case logCabin
    }
    
    weak var blockVC: BlockViewController?
    
    let shapeColor = UIColor(red: 0.889, green: 0.000, blue: 1.000, alpha: 1.000)
    
    var blockStyle: BlockView.block?
    
    lazy var shapes: [ShapeView]? = {
        guard let blockStyle = blockStyle else {
            return nil
        }
        switch blockStyle {
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
    
//    convenience init(blockStyle: block) {
//        self.init()
//        self.blockStyle = blockStyle
//    }
    
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
