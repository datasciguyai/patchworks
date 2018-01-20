//
//  BlockViewController.swift
//  Patchworks
//
//  Created by Jeremy Reynolds on 12/6/17.
//  Copyright © 2017 Jeremy Reynolds. All rights reserved.
//

import UIKit
import CoreData

class BlockViewController: UIViewController, NSFetchedResultsControllerDelegate, UINavigationControllerDelegate, UIImagePickerControllerDelegate, ShapeDelegate {
    
    var blockView: BlockView?
    
    @IBOutlet weak var notesTextView: UITextView!
    
    var blockPreviewImagesURL = BlockController.shared.blockThumbnailsDirectoryURL
    var fabricLibraryDirectoryURL = ShapeController.shared.shapeImagesDirectoryURL
    
    var block: Block? {
        didSet {
            configureFetchedResultsController()
        }
    }
    
    private var shapeView = ShapeView()
    
    private var updatedShapeViews: [ShapeView]?
    
    private var blockThumbnailData: Data? {
        guard let blockView = blockView else { return nil }
        UIGraphicsBeginImageContext(CGSize(width: blockView.bounds.width / 2, height: blockView.bounds.height / 2))
        blockView.drawHierarchy(in: CGRect(x: 0, y: 0, width: blockView.bounds.width / 2, height: blockView.bounds.height / 2), afterScreenUpdates: true)
        guard let blockPreviewImage = UIGraphicsGetImageFromCurrentImageContext() else { return nil }
        UIGraphicsEndImageContext()
        return UIImageJPEGRepresentation(blockPreviewImage, 1.0)
    }
    
    var fetchedResultsController: NSFetchedResultsController<Shape>!
    
    func configureFetchedResultsController() {
        guard let block = block else { return }
        if fetchedResultsController == nil {
            let fetchRequest: NSFetchRequest<Shape> = Shape.fetchRequest()
            fetchRequest.sortDescriptors = [NSSortDescriptor(key: "imageFileName", ascending: true)]
            fetchedResultsController = NSFetchedResultsController<Shape>(fetchRequest: fetchRequest, managedObjectContext: CoreDataStack.context, sectionNameKeyPath: nil, cacheName: nil)
            fetchedResultsController.delegate = self
        }
        fetchedResultsController.fetchRequest.predicate = NSPredicate(format: "block == %@", block)
        do {
            try fetchedResultsController.performFetch()
        } catch {
            NSLog("Error starting fetched results controller  \(error)")
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let blockView = blockView {
            blockView.blockVC = self
            blockView.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview(blockView)
            let height = NSLayoutConstraint(item: blockView, attribute: .height, relatedBy: .equal, toItem: blockView, attribute: .width, multiplier: 1.0, constant: 0.0)
            let width = NSLayoutConstraint(item: blockView, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .width, multiplier: 1.0, constant: UIScreen.main.bounds.maxX - 16)
            blockView.addConstraints([height, width])
            let x = NSLayoutConstraint(item: blockView, attribute: .centerX, relatedBy: .equal, toItem: view, attribute: .centerX, multiplier: 1.0, constant: 0.0)
            let y = NSLayoutConstraint(item: blockView, attribute: .topMargin, relatedBy: .equal, toItem: view, attribute: .topMargin, multiplier: 1.0, constant: 20.0)
            view.addConstraints([x, y])
            
        } else {
            var shapeViews = [ShapeView]()
            guard let shapes = fetchedResultsController.fetchedObjects else { return }
            for shape in shapes {
                guard let frame = shape.rect, let shapeType = shape.type, let shapeViewShape = ShapeView.ShapeType(rawValue: shapeType) else { return }
                
                if let imageFileName = shape.imageFileName{
                    
                    guard let shapeImageURL = ShapeController.shared.shapeImagesDirectoryURL else { continue }
                    
                    let image = UIImage(contentsOfFile: shapeImageURL.appendingPathComponent(imageFileName).path)
                    
                    shapeViews.append(ShapeView(frame: CGRectFromString(frame), rotation: CGFloat(shape.rotation), image: image, shapeType: shapeViewShape))
                } else {
                    shapeViews.append(ShapeView(frame: CGRectFromString(frame), rotation: CGFloat(shape.rotation), shapeType: shapeViewShape))
                }
            }
            
            blockView = BlockView(shapesViews: shapeViews)
            guard let blockView = blockView else { return }
            blockView.blockVC = self
            blockView.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview(blockView)
            let height = NSLayoutConstraint(item: blockView, attribute: .height, relatedBy: .equal, toItem: blockView, attribute: .width, multiplier: 1.0, constant: 0.0)
            let width = NSLayoutConstraint(item: blockView, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .width, multiplier: 1.0, constant: UIScreen.main.bounds.maxX - 16)
            blockView.addConstraints([height, width])
            let x = NSLayoutConstraint(item: blockView, attribute: .centerX, relatedBy: .equal, toItem: view, attribute: .centerX, multiplier: 1.0, constant: 0.0)
            let y = NSLayoutConstraint(item: blockView, attribute: .topMargin, relatedBy: .equal, toItem: view, attribute: .topMargin, multiplier: 1.0, constant: 20.0)
            view.addConstraints([x, y])
        }
    }
    
    func shapeClicked(_ sender: ShapeView) {
        shapeView = sender
        alertController()
    }
    
    func alertController() {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        
        let alertController = UIAlertController(title: "Photo Picker", message: nil, preferredStyle: .actionSheet)
        
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
            alertController.addAction(UIAlertAction(title: "Photo Library", style: .default) { _ in
                imagePicker.sourceType = .photoLibrary
                self.present(imagePicker, animated: true)
            })
        }
        
//        if UIImagePickerController.isSourceTypeAvailable(.camera) {
//            alertController.addAction(UIAlertAction(title: "Camera", style: .default) { _ in
//                imagePicker.sourceType = .camera
//                self.present(imagePicker, animated: true)
//            })
//        }
        
        if shapeView.image != nil {
            alertController.addAction(UIAlertAction(title: "Delete Image", style: .destructive) { _ in
                if self.updatedShapeViews == nil {
                    self.updatedShapeViews = [ShapeView]()
                }
                self.updatedShapeViews?.append(self.shapeView)
                self.shapeView.removeImage()
            })
        }
        
        alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        present(alertController, animated: true)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        guard let pickedImage = info[UIImagePickerControllerOriginalImage] as? UIImage else { return }
        shapeView.image = pickedImage
        if updatedShapeViews == nil {
            updatedShapeViews = [ShapeView]()
        }
        updatedShapeViews?.append(shapeView)
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    override func unwind(for unwindSegue: UIStoryboardSegue, towardsViewController subsequentVC: UIViewController) {
        if unwindSegue.identifier == "fromBlockVCSave" {
            
            guard let blockView = blockView, let shapeViews = blockView.shapeViews else { return }
            
            if let block = block {
                guard let blockThumbnailData = blockThumbnailData, let shapes = fetchedResultsController.fetchedObjects, let updatedShapeViews = updatedShapeViews else { return }
                
                BlockController.shared.update(block: block, blockThumbnailData: blockThumbnailData, title: "test", notes: nil)
                
                for shapeView in updatedShapeViews {
                    var imageData: Data? = nil
                    if let image = shapeView.image {
                        imageData = UIImageJPEGRepresentation(image, 1.0)
                    }
                    
                    guard let index = shapeViews.index(of: shapeView) else { continue }
                    
                    ShapeController.shared.update(shape: shapes[index], imageData: imageData)

                }
                self.updatedShapeViews?.removeAll()
            } else {
                guard let blockThumbnailData = blockThumbnailData else { return }
                
                BlockController.shared.createBlockWith(blockThumbnailData: blockThumbnailData, title: "test", notes: nil)
                
                guard let block = BlockController.shared.block else { return }
                
                for shapeView in shapeViews {
                    if let image = shapeView.image {
                        guard let imageData = UIImageJPEGRepresentation(image, 1.0) else { continue }
                        ShapeController.shared.createShapeWith(shapeImageData: imageData,rect: NSStringFromCGRect(shapeView.originalFrame), rotation: Float(shapeView.rotation), type: shapeView.shapeType.rawValue, block: block)
                    } else {
                        ShapeController.shared.createShapeWith(rect: NSStringFromCGRect(shapeView.originalFrame), rotation: Float(shapeView.rotation), type: shapeView.shapeType.rawValue, block: block)
                    }
                }
            }
        }
    }
}
