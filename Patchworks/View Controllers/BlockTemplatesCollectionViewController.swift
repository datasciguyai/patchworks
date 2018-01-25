//
//  BlockTemplatesCollectionViewController.swift
//  Patchworks
//
//  Created by Jeremy Reynolds on 12/20/17.
//  Copyright © 2017 Jeremy Reynolds. All rights reserved.
//

import UIKit

class BlockTemplatesCollectionViewController: UICollectionViewController {
    
    let blockStrings = BlockTemplateController.blockTemplates
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let blockViewController = segue.destination as? BlockViewController, let indexPath = collectionView?.indexPathsForSelectedItems?.first else { return }
        if segue.identifier == "toBlockViewController" {
            blockViewController.hidesBottomBarWhenPushed = true
            blockViewController.blockView = BlockView(blockPattern: BlockTemplateController.blockTemplates[indexPath.row].blockTemplatePattern)
        }
    }
    
    // MARK: - UICollectionViewDataSource
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return blockStrings.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "blockCollectionViewCell", for: indexPath) as? BlockTemplateCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        cell.blockTemplateLabel.text = blockStrings[indexPath.row].blockTemplateTitle
        cell.blockTemplateImageView.image = blockStrings[indexPath.row].blockTemplateImage
        
        return cell
    }
    
    // MARK: - UICollectionViewDelegate
    
    /*
     // Uncomment this method to specify if the specified item should be highlighted during tracking
     override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
     return true
     }
     */
    
    /*
     // Uncomment this method to specify if the specified item should be selected
     override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
     return true
     }
     */
    
    /*
     // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
     override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
     return false
     }
     
     override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
     return false
     }
     
     override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
     
     }
     */
}
