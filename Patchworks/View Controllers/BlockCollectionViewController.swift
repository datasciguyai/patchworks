//
//  BlockCollectionViewController.swift
//  Patchworks
//
//  Created by Jeremy Reynolds on 12/20/17.
//  Copyright © 2017 Jeremy Reynolds. All rights reserved.
//

import UIKit
import CoreData

private let reuseIdentifier = "blockCell"

class BlockCollectionViewController: UICollectionViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Register cell classes
        //        self.collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
    }
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let blockVC = segue.destination as? BlockViewController else { return }
        
        if segue.identifier == "fromBlock" {
            var shapeViews = [ShapeView]()
            var shapes = BlockController.shared.blocks[(collectionView?.indexPath(for: sender as! BlockCollectionViewCell)?.row)!].shapes!
            for shape in shapes {
                if let imageData = shape.image {
                    shapeViews.append(ShapeView(frame: CGRectFromString(shape.rect!), rotation: CGFloat(shape.rotation), image: UIImage(data: imageData), shapeType: ShapeView.shape(rawValue: shape.type!)!))
                } else {
                    shapeViews.append(ShapeView(frame: CGRectFromString(shape.rect!), rotation: CGFloat(shape.rotation), shapeType: ShapeView.shape(rawValue: shape.type!)!))
                }
            }
            blockVC.blockView = BlockView(shapesViews: shapeViews)
            blockVC.block = BlockController.shared.blocks[(collectionView?.indexPath(for: sender as! BlockCollectionViewCell)?.row)!]
            blockVC.shapes = shapes
        }
    }
    
    // MARK: UICollectionViewDataSource
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return BlockController.shared.blocks.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as? BlockCollectionViewCell, let previewImageData = BlockController.shared.blocks[indexPath.row].previewImage else {
            return UICollectionViewCell()
        }
        
        cell.blockImageView.image = UIImage(data: previewImageData)
        
        return cell
    }
    
    // MARK: UICollectionViewDelegate
    
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
