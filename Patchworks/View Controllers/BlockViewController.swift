//
//  BlockViewController.swift
//  Patchworks
//
//  Created by Jeremy Reynolds on 12/6/17.
//  Copyright © 2017 Jeremy Reynolds. All rights reserved.
//

import UIKit
import CoreData

class BlockViewController: ShiftableViewController, NSFetchedResultsControllerDelegate, UINavigationControllerDelegate, UIImagePickerControllerDelegate, PatchDelegate {
    
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var blockViewContainer: UIView!
    @IBOutlet weak var notesTextView: UITextView!
    
    var blockView: BlockView?
    
    var block: Block? {
        didSet {
            configureFetchedResultsController()
        }
    }
    
    private let tbController = UIApplication.shared.keyWindow?.rootViewController as! TabBarController
    
    private var patchView = PatchView()
    
    private var updatedPatchViews = [PatchView]()
    
    private var blockThumbnailData: Data? {
        guard let blockView = blockView else { return nil }
        let blockThumbnailWidth = 128
        let blockThumbnailHeight = 128
        UIGraphicsBeginImageContextWithOptions(CGSize(width: blockThumbnailWidth, height: blockThumbnailHeight), false, 0.0)
        blockView.drawHierarchy(in: CGRect(x: 0, y: 0, width: blockThumbnailWidth, height: blockThumbnailHeight), afterScreenUpdates: true)
        guard let blockPreviewImage = UIGraphicsGetImageFromCurrentImageContext() else { return nil }
        UIGraphicsEndImageContext()
        return UIImageJPEGRepresentation(blockPreviewImage, 1.0)
    }
    
    private var fetchedResultsController: NSFetchedResultsController<Patch>!
    
    @IBAction func saveButtonTapped(_ sender: UIBarButtonItem) {
        guard let blockView = blockView, let patchViews = blockView.patchViews, let titleText = titleTextField.text, !titleText.isEmpty else {
            
            let alertController = UIAlertController(title: nil, message: "Please enter a title before saving.", preferredStyle: .alert)
            
            alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            
            present(alertController, animated: true, completion: nil)
            
            return
        }
        
        if let block = block {
            guard let blockThumbnailData = blockThumbnailData, let patches = fetchedResultsController.fetchedObjects else { return }
            
            BlockController.shared.update(block: block, blockThumbnailData: blockThumbnailData, title: titleText, notes: notesTextView.text)
            
            for patchView in updatedPatchViews {
                var imageData: Data? = nil
                if let image = patchView.image {
                    imageData = UIImageJPEGRepresentation(image, 1.0)
                }
                
                guard let index = patchViews.index(of: patchView) else { continue }
                
                PatchController.shared.update(patch: patches[index], imageData: imageData)
                
            }
            updatedPatchViews.removeAll()
        } else {
            guard let blockThumbnailData = blockThumbnailData else { return }
            
            BlockController.shared.createBlockWith(blockThumbnailData: blockThumbnailData, title: titleText, notes: notesTextView.text)
            
            guard let block = BlockController.shared.block else { return }
            
            for patchView in patchViews {
                if let image = patchView.image {
                    guard let imageData = UIImageJPEGRepresentation(image, 1.0) else { continue }
                    PatchController.shared.createPatchWith(patchImageData: imageData,rawRect: NSStringFromCGRect(patchView.originalFrame), rotationAngle: Float(patchView.rotationAngle), type: patchView.shape.rawValue, block: block)
                } else {
                    PatchController.shared.createPatchWith(rawRect: NSStringFromCGRect(patchView.originalFrame), rotationAngle: Float(patchView.rotationAngle), type: patchView.shape.rawValue, block: block)
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
            let fetchRequest: NSFetchRequest<Patch> = Patch.fetchRequest()
            fetchRequest.sortDescriptors = [NSSortDescriptor(key: "imageFileName", ascending: true)]
            fetchedResultsController = NSFetchedResultsController<Patch>(fetchRequest: fetchRequest, managedObjectContext: CoreDataStack.context, sectionNameKeyPath: nil, cacheName: nil)
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
        tbController.autorotatable = false
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        tbController.autorotatable = true
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
        
        var patchViews = [PatchView]()
        guard let patches = fetchedResultsController.fetchedObjects else { return nil}
        for patch in patches {
            guard let rawRect = patch.rawRect, let shape = patch.shape, let patchViewShape = PatchView.Shape(rawValue: shape) else { return nil}
            
            if let imageFileName = patch.imageFileName{
                
                guard let patchImageURL = PatchController.shared.patchImagesDirectoryURL else { continue }
                
                let image = UIImage(contentsOfFile: patchImageURL.appendingPathComponent(imageFileName).path)
                
                patchViews.append(PatchView(frame: CGRectFromString(rawRect), rotationAngle: CGFloat(patch.rotationAngle), image: image, shape: patchViewShape))
            } else {
                patchViews.append(PatchView(frame: CGRectFromString(rawRect), rotationAngle: CGFloat(patch.rotationAngle), shape: patchViewShape))
            }
        }
        return BlockView(patchViews: patchViews)
    }
    
    func addConstraintsFor(blockView: BlockView) {
        blockView.translatesAutoresizingMaskIntoConstraints = false
        let blockViewLeading = NSLayoutConstraint(item: blockView, attribute: .leading, relatedBy: .equal, toItem: blockViewContainer, attribute: .leading, multiplier: 1.0, constant: 0.0)
        let blockViewTrailing = NSLayoutConstraint(item: blockView, attribute: .trailing, relatedBy: .equal, toItem: blockViewContainer, attribute: .trailing, multiplier: 1.0, constant: 0.0)
        let blockViewTop = NSLayoutConstraint(item: blockView, attribute: .top, relatedBy: .equal, toItem: blockViewContainer, attribute: .top, multiplier: 1.0, constant: 0.0)
        let blockViewBottom = NSLayoutConstraint(item: blockView, attribute: .bottom, relatedBy: .equal, toItem: blockViewContainer, attribute: .bottom, multiplier: 1.0, constant: 0.0)
        blockViewContainer.addConstraints([blockViewLeading, blockViewTrailing, blockViewTop, blockViewBottom])
    }
    
    func patchClicked(_ sender: PatchView) {
        patchView = sender
        alertController()
    }
    
    func alertController() {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        
        let alertController = UIAlertController(title: "Fabric Picker", message: nil, preferredStyle: .actionSheet)
        
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
        
        if patchView.image != nil {
            alertController.addAction(UIAlertAction(title: "Delete Image", style: .destructive) { _ in
                self.updatedPatchViews.append(self.patchView)
                self.patchView.removeImage()
            })
        }
        
        alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        present(alertController, animated: true)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        guard let pickedImage = info[UIImagePickerControllerEditedImage] as? UIImage else { return }
        let patchWidth = patchView.bounds.width
        let patchHeight = patchView.bounds.height
        UIGraphicsBeginImageContextWithOptions(CGSize(width: patchWidth, height: patchHeight), true, 0)
        
        let m = max(patchWidth, patchHeight)
        
        pickedImage.draw(in: CGRect(origin: .zero, size: CGSize(width: m, height: m)))
        
        patchView.image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        
        updatedPatchViews.append(patchView)
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
}
