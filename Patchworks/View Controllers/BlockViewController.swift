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
    var blockPattern: BlockView.BlockPattern?
    
    let imagePicker = UIImagePickerController()
    var shape = ShapeView()
    
    @IBAction func saveButtonTapped(_ sender: UIBarButtonItem) {
        // Make image smaller
        
        UIGraphicsBeginImageContext((blockView?.bounds.size)!)
        blockView?.drawHierarchy(in: (blockView?.bounds)!, afterScreenUpdates: true)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        BlockController.shared.add(block: Block(pattern: (blockPattern?.rawValue)!, title: "test", previewImage: UIImagePNGRepresentation(image!)!))
    }
    
    func shapeClicked(_ sender: ShapeView) {
        shape = sender
        //        imagePicker.allowsEditing = false
        imagePicker.sourceType = .photoLibrary
        present(imagePicker, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imagePicker.delegate = self
        blockView = BlockView(blockPattern: blockPattern!)
        //        block?.blockStyle = .churnDash
        blockView?.blockVC = self
        blockView?.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(blockView!)
        let height = NSLayoutConstraint(item: blockView, attribute: .height, relatedBy: .equal, toItem: blockView, attribute: .width, multiplier: 1.0, constant: 0.0)
        let width = NSLayoutConstraint(item: blockView, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .width, multiplier: 1.0, constant: UIScreen.main.bounds.maxX - 16)
        blockView?.addConstraints([height, width])
        let x = NSLayoutConstraint(item: blockView, attribute: .centerX, relatedBy: .equal, toItem: view, attribute: .centerX, multiplier: 1.0, constant: 0.0)
        let y = NSLayoutConstraint(item: blockView, attribute: .topMargin, relatedBy: .equal, toItem: view, attribute: .topMargin, multiplier: 1.0, constant: 0.0)
        view.addConstraints([x, y])
    }
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let pickedImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
            shape.image = pickedImage
        }
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
}
