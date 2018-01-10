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
    
    var newBlock: Bool = true
    
    let imagePicker = UIImagePickerController()
    
    var shapeView = ShapeView()
    
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
        }
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    override func unwind(for unwindSegue: UIStoryboardSegue, towardsViewController subsequentVC: UIViewController) {
        
        
        
        if let blockPreviewImageData = blockPreviewImageData {
            if newBlock {
                let block = Block(title: "test", previewImage: blockPreviewImageData)
                var shapes = [Shape]()
                for shapeView in (blockView?.shapeViews!)! {
                    let shape = Shape(rect: NSStringFromCGRect(shapeView.originalFrame), rotation: Float(shapeView.rotation), tag: Int64(shapeView.tag), image: UIImagePNGRepresentation((shapeView.image ?? nil)!), type: shapeView.shapeType.rawValue)
                    shapes.append(shape)
                }
                let s = NSOrderedSet(array: shapes)
                BlockController.shared.add(block: block, shapes: s)
                navigationController?.popViewController(animated: true)
            } else {
                
            }
        }
        
    }
    
    private var blockPreviewImageData: Data? {
        guard let blockView = blockView else { return nil }
        UIGraphicsBeginImageContext(blockView.bounds.size)
        blockView.drawHierarchy(in: blockView.bounds, afterScreenUpdates: true)
        let imageFromCurrentImageContext = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        guard let blockPreviewImage = imageFromCurrentImageContext else { return nil }
        return UIImagePNGRepresentation(blockPreviewImage)
    }
}
