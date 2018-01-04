//
//  PredefinedBlockViewController.swift
//  Patchworks
//
//  Created by Jeremy Reynolds on 12/20/17.
//  Copyright © 2017 Jeremy Reynolds. All rights reserved.
//

import UIKit

class PredefinedBlockViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let blockVC = segue.destination as? BlockViewController else { return }
        switch segue.identifier {
        case "fromBasketWeaveButton"?:
            blockVC.blockPattern = BlockView.BlockPattern.basketWeave
        case "fromChurnDashButton"?:
            blockVC.blockPattern = BlockView.BlockPattern.churnDash
        case "fromDoubleCrossButton"?:
            blockVC.blockPattern = BlockView.BlockPattern.doubleCross
        case "fromLogCabinButton"?:
            blockVC.blockPattern = BlockView.BlockPattern.logCabin
        default:
            blockVC.blockPattern = BlockView.BlockPattern.churnDash
        }
    }
}
