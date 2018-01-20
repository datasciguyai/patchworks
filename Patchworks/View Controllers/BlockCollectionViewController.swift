//
//  BlockCollectionViewController.swift
//  Patchworks
//
//  Created by Jeremy Reynolds on 12/20/17.
//  Copyright © 2017 Jeremy Reynolds. All rights reserved.
//

import UIKit
import CoreData

class BlockCollectionViewController: UICollectionViewController, NSFetchedResultsControllerDelegate {
    
    var fetchedResultsController: NSFetchedResultsController<Block>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureFetchedResultsController()
    }
    
    func configureFetchedResultsController() {
        if fetchedResultsController == nil {
            let fetchRequest: NSFetchRequest<Block> = Block.fetchRequest()
            fetchRequest.sortDescriptors = [NSSortDescriptor(key: "title", ascending: true)]
            fetchedResultsController = NSFetchedResultsController<Block>(fetchRequest: fetchRequest, managedObjectContext: CoreDataStack.context, sectionNameKeyPath: nil, cacheName: nil)
            fetchedResultsController.delegate = self
        }
        do {
            try fetchedResultsController.performFetch()
        } catch {
            NSLog("Error starting fetched results controller: \(error)")
        }
    }
    
    @IBAction func cancelUnwindSegue(_ sender: UIStoryboardSegue) {}
    
    @IBAction func saveUnwindSegue(_ sender: UIStoryboardSegue) {
        BlockController.shared.saveToPersistentStore()
    }
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let blockViewController = segue.destination as? BlockViewController, let blocks = fetchedResultsController.fetchedObjects, let indexPath = collectionView?.indexPathsForSelectedItems?.first else { return }
        if segue.identifier == "toBlockViewController" {
            blockViewController.block = blocks[indexPath.row]
        }
    }
    
    // MARK: - UICollectionViewDataSource
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let blocks = fetchedResultsController.fetchedObjects else { return 0 }
        return blocks.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "blockCollectionViewCell", for: indexPath) as? BlockCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        guard let blocks = fetchedResultsController.fetchedObjects, let previewImageFileName = blocks[indexPath.row].previewImageFileName, let blockImagePath = BlockController.shared.blockThumbnailsDirectoryURL?.appendingPathComponent(previewImageFileName).path else { return cell }
        
        cell.blockImageView.image = UIImage(contentsOfFile: blockImagePath)
        
        return cell
    }
    
    // MARK: - NSFetchedResultsControllerDelegate
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>,
                    didChange anObject: Any,
                    at indexPath: IndexPath?,
                    for type: NSFetchedResultsChangeType,
                    newIndexPath: IndexPath?) {
        switch type {
        case .insert:
            guard let newIndexPath = newIndexPath else { return }
            collectionView?.insertItems(at: [newIndexPath])
        case .delete:
            guard let indexPath = indexPath else { return }
            collectionView?.deleteItems(at: [indexPath])
        case .move:
            collectionView?.reloadData()
        case .update:
            guard let indexPath = indexPath else { return }
            collectionView?.reloadItems(at: [indexPath])
        }
    }
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>,
                    didChange sectionInfo: NSFetchedResultsSectionInfo,
                    atSectionIndex sectionIndex: Int,
                    for type: NSFetchedResultsChangeType) {
        switch type {
        case .delete:
            collectionView?.deleteSections(IndexSet(integer: sectionIndex))
        case .insert:
            collectionView?.insertSections(IndexSet(integer: sectionIndex))
        default:
            break
        }
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
