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
                    shapeViews.append(ShapeView(frame: CGRectFromString(frame), rotation: CGFloat(shape.rotation), image: nil, shapeType: shapeViewShape))
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
        
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            alertController.addAction(UIAlertAction(title: "Camera", style: .default) { _ in
                imagePicker.sourceType = .camera
                self.present(imagePicker, animated: true)
            })
        }
        
        alertController.addAction(UIAlertAction(title: "Delete Image", style: .destructive) { _ in
            self.shapeView.removeImage()
        })
        
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
            if block != nil {
                
                
                
                
                
                
                
                let shapes = fetchedResultsController.fetchedObjects
                guard let updatedShapeViews = updatedShapeViews,
                    
                    let shapeImagesURL = ShapeController.shared.shapeImagesDirectoryURL,
                    let index = shapeViews.index(of: shapeView),
                    let fileName = shapes![index].imageFileName,
                    let blockThumbnailData = blockThumbnailData,
                    let blockThumbnailFileName = block?.previewImageFileName,
                    let blockThumbnailURL =
                    blockPreviewImagesURL?.appendingPathComponent(blockThumbnailFileName) else {
                        return
                }
                try? blockThumbnailData.write(to: blockThumbnailURL)
                for shapeView in updatedShapeViews {
                    if let image = shapeView.image {
                        let imageData = UIImageJPEGRepresentation(image, 1.0)
                        try? imageData?.write(to: shapeImagesURL.appendingPathComponent(fileName))
                    }
                }
            } else {
                let blockThumbnailFileName = "\(UUID().uuidString).jpeg"
                
                guard let blockThumbnailData = self.blockThumbnailData, let blockThumbnailURL =
                    blockPreviewImagesURL?.appendingPathComponent(blockThumbnailFileName) else { return }
                
                try? blockThumbnailData.write(to: blockThumbnailURL)
                
                BlockController.shared.createBlockWith(title: "test", notes: nil, previewImageFileName: blockThumbnailFileName)
                
                for shapeView in shapeViews {
                    if let image = shapeView.image  {
                        guard let imageData = UIImageJPEGRepresentation(image, 1.0), let shapeImageURL = ShapeController.shared.shapeImagesDirectoryURL else { continue }
                        
                        let shapeImageFileName = "\(UUID().uuidString).jpeg"
                        
                        try? imageData.write(to: shapeImageURL.appendingPathComponent(shapeImageFileName))
                        
                        ShapeController.shared.createShapeWith(rect: NSStringFromCGRect(shapeView.originalFrame), rotation: Float(shapeView.rotation), imageFileName: shapeImageFileName, type: shapeView.shapeType.rawValue, block: BlockController.shared.block)
                    } else {
                        ShapeController.shared.createShapeWith(rect: NSStringFromCGRect(shapeView.originalFrame), rotation: Float(shapeView.rotation), imageFileName: nil, type: shapeView.shapeType.rawValue, block: BlockController.shared.block)
                    }
                }
                BlockController.shared.saveToPersistentStore()
            }
        }
    }
}
