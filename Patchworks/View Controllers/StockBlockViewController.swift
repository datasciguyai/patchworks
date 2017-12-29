//
//  StockBlockViewController.swift
//  Patchworks
//
//  Created by Jeremy Reynolds on 12/20/17.
//  Copyright © 2017 Jeremy Reynolds. All rights reserved.
//

import UIKit

class StockBlockViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        guard let blockVC = segue.destination as? BlockViewController else { return }
        switch segue.identifier {
        case "fromBasketWeaveButton"?:
            blockVC.blockStyle = BlockView.block.basketWeave
        case "fromChurnDashButton"?:
            blockVC.blockStyle = BlockView.block.churnDash
        case "fromDoubleCrossButton"?:
            blockVC.blockStyle = BlockView.block.doubleCross
        case "fromLogCabinButton"?:
            blockVC.blockStyle = BlockView.block.logCabin
        default:
            blockVC.blockStyle = BlockView.block.churnDash
        }
    }
}
