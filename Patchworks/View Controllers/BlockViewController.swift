//
//  BlockViewController.swift
//  Patchworks
//
//  Created by Jeremy Reynolds on 12/6/17.
//  Copyright © 2017 Jeremy Reynolds. All rights reserved.
//

import UIKit

class BlockViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, ShapeDelegate {
    
    var block: BlockView?
    var blockPattern: BlockView.BlockPattern?
    
    let imagePicker = UIImagePickerController()
    var shape = ShapeView()
    
    @IBAction func saveButtonTapped(_ sender: UIBarButtonItem) {
        // Make image smaller
        
        if block == nil {
        UIGraphicsBeginImageContext((block?.bounds.size)!)
        block?.drawHierarchy(in: (block?.bounds)!, afterScreenUpdates: true)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
//        let b = Block(blockView: block!, previewImage: image!)
//        BlockController.blocks.append(b)
        }
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
        block = BlockView(blockPattern: blockPattern!)
//        block?.blockStyle = .churnDash
        block?.blockVC = self
        block?.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(block!)
        let height = NSLayoutConstraint(item: block, attribute: .height, relatedBy: .equal, toItem: block, attribute: .width, multiplier: 1.0, constant: 0.0)
        let width = NSLayoutConstraint(item: block, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .width, multiplier: 1.0, constant: UIScreen.main.bounds.maxX - 16)
        block?.addConstraints([height, width])
        let x = NSLayoutConstraint(item: block, attribute: .centerX, relatedBy: .equal, toItem: view, attribute: .centerX, multiplier: 1.0, constant: 0.0)
        let y = NSLayoutConstraint(item: block, attribute: .topMargin, relatedBy: .equal, toItem: view, attribute: .topMargin, multiplier: 1.0, constant: 0.0)
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
