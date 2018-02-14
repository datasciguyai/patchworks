//
//  UIColor+PieceColor.swift
//  Patchworks
//
//  Created by Jeremy Reynolds on 1/3/18.
//  Copyright © 2018 Jeremiah Reynolds. All rights reserved.
//

import UIKit

extension UIColor {
    static let pieceStrokeColor = UIColor(named: "pieceColor")
    static let pieceFillColor = pieceStrokeColor?.withAlphaComponent(0.3)
}
