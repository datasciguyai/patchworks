//
//  BlockViewController.swift
//  Patchworks
//
//  Created by Jeremy Reynolds on 12/6/17.
//  Copyright © 2017 Jeremy Reynolds. All rights reserved.
//

import UIKit
import CoreData

class BlockViewController: ShiftableViewController, NSFetchedResultsControllerDelegate, UINavigationControllerDelegate, UIImagePickerControllerDelegate, ShapeDelegate {
    
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var blockViewContainer: UIView!
    @IBOutlet weak var notesTextView: UITextView!
    
    var blockView: BlockView?
    
    var block: Block? {
        didSet {
            configureFetchedResultsController()
        }
    }
    
    private let r = UIApplication.shared.keyWindow?.rootViewController as! TabBarController
    
    private var shapeView = ShapeView()
    
    private var updatedShapeViews = [ShapeView]()
    
    private var blockThumbnailData: Data? {
        guard let blockView = blockView else { return nil }
        let blockThumbnailWidth = blockView.bounds.width
        let blockThumbnailHeight = blockView.bounds.height
        UIGraphicsBeginImageContextWithOptions(CGSize(width: blockThumbnailWidth, height: blockThumbnailHeight), false, 0.0)
        //        UIGraphicsBeginImageContext(CGSize(width: blockThumbnailWidth, height: blockThumbnailHeight))
        blockView.drawHierarchy(in: CGRect(x: 0, y: 0, width: blockThumbnailWidth, height: blockThumbnailHeight), afterScreenUpdates: true)
        guard let blockPreviewImage = UIGraphicsGetImageFromCurrentImageContext() else { return nil }
        UIGraphicsEndImageContext()
        return UIImageJPEGRepresentation(blockPreviewImage, 1.0)
    }
    
    private var fetchedResultsController: NSFetchedResultsController<Shape>!
    
    @IBAction func saveButtonTapped(_ sender: UIBarButtonItem) {
        guard let blockView = blockView, let shapeViews = blockView.shapeViews, let titleText = titleTextField.text, !titleText.isEmpty else {
            
            let alertController = UIAlertController(title: nil, message: "Please enter a title before saving.", preferredStyle: .alert)
            
            alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            
            present(alertController, animated: true, completion: nil)
            
            return
        }
        
        if let block = block {
            guard let blockThumbnailData = blockThumbnailData, let shapes = fetchedResultsController.fetchedObjects else { return }
            
            BlockController.shared.update(block: block, blockThumbnailData: blockThumbnailData, title: titleText, notes: notesTextView.text)
            
            for shapeView in updatedShapeViews {
                var imageData: Data? = nil
                if let image = shapeView.image {
                    imageData = UIImageJPEGRepresentation(image, 1.0)
                }
                
                guard let index = shapeViews.index(of: shapeView) else { continue }
                
                ShapeController.shared.update(shape: shapes[index], imageData: imageData)
                
            }
            updatedShapeViews.removeAll()
        } else {
            guard let blockThumbnailData = blockThumbnailData else { return }
            
            BlockController.shared.createBlockWith(blockThumbnailData: blockThumbnailData, title: titleText, notes: notesTextView.text)
            
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
        BlockController.shared.saveToPersistentStore()
        tabBarController?.selectedIndex = 0
        navigationController?.popViewController(animated: true)
    }
    
    private func configureFetchedResultsController() {
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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if !UIDevice.current.orientation.isPortrait {
            UIDevice.current.setValue(UIInterfaceOrientation.portrait.rawValue, forKey: "orientation")
            tabBarController?.tabBar.isHidden = true
        }
        r.autorotatable = false
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        r.autorotatable = true
    }
    
    override func keyboardWillShow(notification: Notification) {
        super.keyboardWillShow(notification: notification)
        blockView?.isUserInteractionEnabled = false
    }
    
    override func keyboardWillHide(notification: Notification) {
        super.keyboardWillHide(notification: notification)
        blockView?.isUserInteractionEnabled = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        notesTextView.delegate = self
        titleTextField.delegate = self
        if let blockView = blockView {
            blockView.blockVC = self
            blockViewContainer.addSubview(blockView)
            addConstraintsFor(blockView: blockView)
        } else {
            titleTextField.text = block?.title
            notesTextView.text = block?.notes
            blockView = setupBlockView
            guard let blockView = blockView else { return }
            blockView.blockVC = self
            blockViewContainer.addSubview(blockView)
            addConstraintsFor(blockView: blockView)
        }
    }
    
    var setupBlockView: BlockView? {
        
        var shapeViews = [ShapeView]()
        guard let shapes = fetchedResultsController.fetchedObjects else { return nil}
        for shape in shapes {
            guard let frame = shape.rect, let shapeType = shape.type, let shapeViewShape = ShapeView.ShapeType(rawValue: shapeType) else { return nil}
            
            if let imageFileName = shape.imageFileName{
                
                guard let shapeImageURL = ShapeController.shared.shapeImagesDirectoryURL else { continue }
                
                let image = UIImage(contentsOfFile: shapeImageURL.appendingPathComponent(imageFileName).path)
                
                shapeViews.append(ShapeView(frame: CGRectFromString(frame), rotation: CGFloat(shape.rotation), image: image, shapeType: shapeViewShape))
            } else {
                shapeViews.append(ShapeView(frame: CGRectFromString(frame), rotation: CGFloat(shape.rotation), shapeType: shapeViewShape))
            }
        }
        return BlockView(shapesViews: shapeViews)
    }
    
    func addConstraintsFor(blockView: BlockView) {
        blockView.translatesAutoresizingMaskIntoConstraints = false
        let blockViewLeading = NSLayoutConstraint(item: blockView, attribute: .leading, relatedBy: .equal, toItem: blockViewContainer, attribute: .leading, multiplier: 1.0, constant: 0.0)
        let blockViewTrailing = NSLayoutConstraint(item: blockView, attribute: .trailing, relatedBy: .equal, toItem: blockViewContainer, attribute: .trailing, multiplier: 1.0, constant: 0.0)
        let blockViewTop = NSLayoutConstraint(item: blockView, attribute: .top, relatedBy: .equal, toItem: blockViewContainer, attribute: .top, multiplier: 1.0, constant: 0.0)
        let blockViewBottom = NSLayoutConstraint(item: blockView, attribute: .bottom, relatedBy: .equal, toItem: blockViewContainer, attribute: .bottom, multiplier: 1.0, constant: 0.0)
        blockViewContainer.addConstraints([blockViewLeading, blockViewTrailing, blockViewTop, blockViewBottom])
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
                imagePicker.allowsEditing = true
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
                self.updatedShapeViews.append(self.shapeView)
                self.shapeView.removeImage()
            })
        }
        
        alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        present(alertController, animated: true)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        guard let pickedImage = info[UIImagePickerControllerEditedImage] as? UIImage else { return }
        let shapeWidth = shapeView.bounds.width
        let shapeHeight = shapeView.bounds.height
        UIGraphicsBeginImageContextWithOptions(CGSize(width: shapeWidth, height: shapeHeight), true, 0)
        
        let m = max(shapeWidth, shapeHeight)
        
        pickedImage.draw(in: CGRect(origin: .zero, size: CGSize(width: m, height: m)))
        
        shapeView.image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        
        updatedShapeViews.append(shapeView)
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
}
