//
//  BlockViewController.swift
//  Patchworks
//
//  Created by Jeremy Reynolds on 12/6/17.
//  Copyright © 2017 Jeremy Reynolds. All rights reserved.
//

import UIKit

class BlockViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, ShapeDelegate {
    
    var blockView: BlockView?
    
    var block: Block?
    
    var shapes: [Shape]?
    
    var new: Bool = false
    
    let imagePicker = UIImagePickerController()
    
    var shapeView = ShapeView()
    
    @IBAction func saveButtonTapped(_ sender: UIBarButtonItem) {
        // Make image smaller
        guard let blockView = blockView else { return }
        UIGraphicsBeginImageContext(blockView.bounds.size)
        blockView.drawHierarchy(in: blockView.bounds, afterScreenUpdates: true)
        let previewImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        if let previewImage = previewImage {
            if new {
                let block = Block(title: "test", previewImage: UIImagePNGRepresentation(previewImage)!)
                BlockController.shared.add(block: block)
                for shapeView in blockView.shapeViews! {
                    let shape = Shape(rect: NSStringFromCGRect(shapeView.originalFrame), rotation: Float(shapeView.rotation), tag: Int64(shapeView.tag), image: UIImagePNGRepresentation(shapeView.image ?? UIImage()), type: shapeView.shapeType.rawValue)
                    ShapeController.shared.add(shape: shape, block: block)
                }
            } else {
                
            }
        }
    }
    
    func shapeClicked(_ sender: ShapeView) {
        shapeView = sender
        //        imagePicker.allowsEditing = false
        imagePicker.sourceType = .photoLibrary
        present(imagePicker, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imagePicker.delegate = self
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
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let pickedImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
            shapeView.image = pickedImage
            let i = blockView?.shapeViews?.index(of: shapeView)
            shapes![i!].image = UIImagePNGRepresentation(shapeView.image!)
            ShapeController.shared.saveToPersistentStore()
        }
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
}
