//
//  BlockListTableViewController.swift
//  Patchworks
//
//  Created by Jeremy Reynolds on 1/22/18.
//  Copyright © 2018 Jeremy Reynolds. All rights reserved.
//

import UIKit
import CoreData

class BlockListTableViewController: UITableViewController, NSFetchedResultsControllerDelegate {
    
    var fetchedResultsController: NSFetchedResultsController<Block>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureFetchedResultsController()
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    func configureFetchedResultsController() {
        if fetchedResultsController == nil {
            let fetchRequest: NSFetchRequest<Block> = Block.fetchRequest()
            fetchRequest.sortDescriptors = [NSSortDescriptor(key: "previewImageFileName", ascending: false)]
            fetchedResultsController = NSFetchedResultsController<Block>(fetchRequest: fetchRequest, managedObjectContext: CoreDataStack.context, sectionNameKeyPath: nil, cacheName: nil)
            fetchedResultsController.delegate = self
        }
        do {
            try fetchedResultsController.performFetch()
        } catch {
            NSLog("Error starting fetched results controller: \(error)")
        }
    }

    // MARK: - Table view data source

//    override func numberOfSections(in tableView: UITableView) -> Int {
//        // #warning Incomplete implementation, return the number of sections
//        return 0
//    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let blocks = fetchedResultsController.fetchedObjects else { return 0 }
        return blocks.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "blockListTableViewCell", for: indexPath) as? BlockTableViewCell else { return UITableViewCell()}

        guard let blocks = fetchedResultsController.fetchedObjects, let previewImageFileName = blocks[indexPath.row].previewImageFileName, let blockImagePath = BlockController.shared.blockThumbnailsDirectoryURL?.appendingPathComponent(previewImageFileName).path else { return cell }
        
        cell.blockThumbnailImageView.image = UIImage(contentsOfFile: blockImagePath)

        return cell
    }
 

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            guard let blocks = fetchedResultsController.fetchedObjects else { return }
            BlockController.shared.delete(block: blocks[indexPath.row])
//            tableView.deleteRows(at: [indexPath], with: .fade)
            
        } /*else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }*/
    }
    

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let blockViewController = segue.destination as? BlockViewController, let blocks = fetchedResultsController.fetchedObjects, let indexPath = tableView.indexPathForSelectedRow else { return }
        if segue.identifier == "toBlockViewController" {
            blockViewController.hidesBottomBarWhenPushed = true
            blockViewController.block = blocks[indexPath.row]
        }
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
            tableView.insertRows(at: [newIndexPath], with: .automatic)
        case .delete:
            guard let indexPath = indexPath else { return }
            tableView.deleteRows(at: [indexPath], with: .automatic)
        case .move:
            tableView.reloadData()
        case .update:
            guard let indexPath = indexPath else { return }
            tableView.reloadRows(at: [indexPath], with: .automatic)
        }
    }
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>,
                    didChange sectionInfo: NSFetchedResultsSectionInfo,
                    atSectionIndex sectionIndex: Int,
                    for type: NSFetchedResultsChangeType) {
        switch type {
        case .delete:
            tableView.deleteSections(IndexSet(integer: sectionIndex), with: .automatic)
        case .insert:
            tableView.insertSections(IndexSet(integer: sectionIndex), with: .automatic)
        default:
            break
        }
    }
}
