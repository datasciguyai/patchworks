//
//  PredefinedBlockViewController.swift
//  Patchworks
//
//  Created by Jeremy Reynolds on 12/20/17.
//  Copyright © 2017 Jeremy Reynolds. All rights reserved.
//

import UIKit

class PredefinedBlockViewController: UIViewController {
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let blockVC = segue.destination as? BlockViewController else { return }
        switch segue.identifier {
        case "fromBasketWeaveButton"?:
            blockVC.blockView = BlockView(blockPattern: .basketWeave)
        case "fromChurnDashButton"?:
            blockVC.blockView = BlockView(blockPattern: .churnDash)
        case "fromDoubleCrossButton"?:
            blockVC.blockView = BlockView(blockPattern: .doubleCross)
        case "fromLogCabinButton"?:
            blockVC.blockView = BlockView(blockPattern: .logCabin)
        default:
            blockVC.blockView = BlockView(blockPattern: .basketWeave)
        }
    }
}
