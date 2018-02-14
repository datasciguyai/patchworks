//
//  BlockViewController.swift
//  Patchworks
//
//  Created by Jeremy Reynolds on 12/6/17.
//  Copyright © 2017 Jeremy Reynolds. All rights reserved.
//

import UIKit
import CoreData

class BlockViewController: ShiftableViewController, NSFetchedResultsControllerDelegate, UINavigationControllerDelegate, UIImagePickerControllerDelegate, PieceDelegate {
    
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
    
    private var pieceView = PieceView()
    
    private var updatedPieceViews = [PieceView]()
    
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
    
    private var fetchedResultsController: NSFetchedResultsController<Piece>!
    
    @IBAction func saveButtonTapped(_ sender: UIBarButtonItem) {
        guard let blockView = blockView, let pieceViews = blockView.pieceViews, let titleText = titleTextField.text, !titleText.isEmpty else {
            
            let alertController = UIAlertController(title: nil, message: "Please enter a title before saving.", preferredStyle: .alert)
            
            alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            
            present(alertController, animated: true, completion: nil)
            
            return
        }
        
        if let block = block {
            guard let blockThumbnailData = blockThumbnailData, let pieces = fetchedResultsController.fetchedObjects else { return }
            
            BlockController.shared.update(block: block, blockThumbnailData: blockThumbnailData, title: titleText, notes: notesTextView.text)
            
            for pieceView in updatedPieceViews {
                var imageData: Data? = nil
                if let image = pieceView.image {
                    imageData = UIImageJPEGRepresentation(image, 1.0)
                }
                
                guard let index = pieceViews.index(of: pieceView) else { continue }
                
                PieceController.shared.update(piece: pieces[index], imageData: imageData)
                
            }
            updatedPieceViews.removeAll()
        } else {
            guard let blockThumbnailData = blockThumbnailData else { return }
            
            BlockController.shared.createBlockWith(blockThumbnailData: blockThumbnailData, title: titleText, notes: notesTextView.text)
            
            guard let block = BlockController.shared.block else { return }
            
            for pieceView in pieceViews {
                if let image = pieceView.image {
                    guard let imageData = UIImageJPEGRepresentation(image, 1.0) else { continue }
                    PieceController.shared.createPieceWith(pieceImageData: imageData,rawRect: NSStringFromCGRect(pieceView.originalFrame), rotationAngle: Float(pieceView.rotationAngle), shape: pieceView.shape.rawValue, block: block)
                } else {
                    PieceController.shared.createPieceWith(rawRect: NSStringFromCGRect(pieceView.originalFrame), rotationAngle: Float(pieceView.rotationAngle), shape: pieceView.shape.rawValue, block: block)
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
            let fetchRequest: NSFetchRequest<Piece> = Piece.fetchRequest()
            fetchRequest.sortDescriptors = [NSSortDescriptor(key: "imageFileName", ascending: true)]
            fetchedResultsController = NSFetchedResultsController<Piece>(fetchRequest: fetchRequest, managedObjectContext: CoreDataStack.context, sectionNameKeyPath: nil, cacheName: nil)
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
        
        var pieceViews = [PieceView]()
        guard let pieces = fetchedResultsController.fetchedObjects else { return nil}
        for piece in pieces {
            guard let rawRect = piece.rawRect, let pieceViewShape = PieceView.Shape(rawValue: piece.shape) else { return nil}
            
            if let imageFileName = piece.imageFileName{
                
                guard let pieceImageURL = PieceController.shared.pieceImagesDirectoryURL else { continue }
                
                let image = UIImage(contentsOfFile: pieceImageURL.appendingPathComponent(imageFileName).path)
                
                pieceViews.append(PieceView(frame: CGRectFromString(rawRect), rotationAngle: CGFloat(piece.rotationAngle), image: image, shape: pieceViewShape))
            } else {
                pieceViews.append(PieceView(frame: CGRectFromString(rawRect), rotationAngle: CGFloat(piece.rotationAngle), shape: pieceViewShape))
            }
        }
        return BlockView(pieceViews: pieceViews)
    }
    
    func addConstraintsFor(blockView: BlockView) {
        blockView.translatesAutoresizingMaskIntoConstraints = false
        let blockViewLeading = NSLayoutConstraint(item: blockView, attribute: .leading, relatedBy: .equal, toItem: blockViewContainer, attribute: .leading, multiplier: 1.0, constant: 0.0)
        let blockViewTrailing = NSLayoutConstraint(item: blockView, attribute: .trailing, relatedBy: .equal, toItem: blockViewContainer, attribute: .trailing, multiplier: 1.0, constant: 0.0)
        let blockViewTop = NSLayoutConstraint(item: blockView, attribute: .top, relatedBy: .equal, toItem: blockViewContainer, attribute: .top, multiplier: 1.0, constant: 0.0)
        let blockViewBottom = NSLayoutConstraint(item: blockView, attribute: .bottom, relatedBy: .equal, toItem: blockViewContainer, attribute: .bottom, multiplier: 1.0, constant: 0.0)
        blockViewContainer.addConstraints([blockViewLeading, blockViewTrailing, blockViewTop, blockViewBottom])
    }
    
    func pieceClicked(_ sender: PieceView) {
        pieceView = sender
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
        
        if pieceView.image != nil {
            alertController.addAction(UIAlertAction(title: "Delete Image", style: .destructive) { _ in
                self.updatedPieceViews.append(self.pieceView)
                self.pieceView.removeImage()
            })
        }
        
        alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        present(alertController, animated: true)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        guard let pickedImage = info[UIImagePickerControllerEditedImage] as? UIImage else { return }
        let pieceWidth = pieceView.bounds.width
        let pieceHeight = pieceView.bounds.height
        UIGraphicsBeginImageContextWithOptions(CGSize(width: pieceWidth, height: pieceHeight), true, 0)
        
        let maxOfWidthHeight = max(pieceWidth, pieceHeight)
        
        pickedImage.draw(in: CGRect(origin: .zero, size: CGSize(width: maxOfWidthHeight, height: maxOfWidthHeight)))
        
        pieceView.image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        
        updatedPieceViews.append(pieceView)
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
}
