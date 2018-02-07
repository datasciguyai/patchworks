//
//  ShiftableViewController.swift
//  Patchworks
//
//  Created by Jeremy Reynolds on 2/5/18.
//  Copyright © 2018 Jeremy Reynolds. All rights reserved.
//

import UIKit

class ShiftableViewController: UIViewController, UIGestureRecognizerDelegate, UITextFieldDelegate, UITextViewDelegate {
    
    private var textViewBeingEdited: UITextView?
    private var textFieldBeingEdited: UITextField?
    private var currentShiftForKeyboard: CGFloat = 0
    private var tapGestureRecognizer: UITapGestureRecognizer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(stopTextInput))
        tapGestureRecognizer?.delegate = self
        view.addGestureRecognizer(tapGestureRecognizer!)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    
    @objc func stopTextInput() {
        if textViewBeingEdited != nil {
            if textViewBeingEdited?.text == "" {
                textViewBeingEdited?.text = "Enter some notes..."
            }
            textViewBeingEdited?.resignFirstResponder()
        } else {
            textFieldBeingEdited?.resignFirstResponder()
        }
    }
    
    func textViewShouldBeginEditing(_ textView: UITextView) -> Bool {
        textViewBeingEdited = textView
        if textView.text == "Enter some notes..." {
            textView.text = ""
        }
        if view.frame.origin.y != 0 {
            view.frame.origin.y += currentShiftForKeyboard
        }
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        stopTextInput()
        return true
    }
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        textFieldBeingEdited = textField
        return true
    }
    
    @objc func keyboardWillShow(notification: Notification) {
        guard let textViewBeingEdited = textViewBeingEdited else { return }
        
        var keyboardSize: CGRect = .zero
        if let keyboardRect = notification.userInfo?[UIKeyboardFrameEndUserInfoKey] as? CGRect,
            keyboardRect.height != 0 {
            keyboardSize = keyboardRect
        } else if let keyboardRect = notification.userInfo?["UIKeyboardBoundsUserInfoKey"] as? CGRect {
            keyboardSize = keyboardRect
        }
        if view.frame.origin.y == 0 {
            let yShift = yShiftWhenKeyboardAppearsFor(textInput: textViewBeingEdited, keyboardSize: keyboardSize, nextY: keyboardSize.height)
            currentShiftForKeyboard = yShift
            view.frame.origin.y -= yShift
        }
    }
    
    @objc func keyboardWillHide(notification: Notification) {
        if view.frame.origin.y != 0 {
            view.frame.origin.y += currentShiftForKeyboard
        }
        textViewBeingEdited = nil
        textFieldBeingEdited = nil
    }
    
    func yShiftWhenKeyboardAppearsFor(textInput: UIView, keyboardSize: CGRect, nextY: CGFloat) -> CGFloat {
        let textFieldOrigin = view.convert(textInput.frame, from: textInput.superview!).origin.y
        let textFieldBottomY = textFieldOrigin + textInput.frame.size.height
        let maximumY = view.frame.height - (keyboardSize.height + view.safeAreaInsets.bottom)
        if textFieldBottomY > maximumY {
            return textFieldBottomY - maximumY + 5
        } else {
            return 0
        }
    }
}
