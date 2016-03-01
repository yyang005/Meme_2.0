//
//  MemeEditorViewController.swift
//  MemeMe
//
//  Created by ying yang on 2/25/16.
//  Copyright © 2016 ying yang. All rights reserved.
//

import UIKit

class MemeEditorViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate, UITextFieldDelegate {
    
    @IBOutlet weak var shareButton: UIBarButtonItem!
    @IBOutlet weak var imageView: UIImageView!

    @IBOutlet weak var topTextField: UITextField!
    
    @IBOutlet weak var topBar: UIToolbar!
    @IBOutlet weak var bottomBar: UIToolbar!
    @IBOutlet weak var bottomTextField: UITextField!
    @IBOutlet weak var cameraButton: UIBarButtonItem!
    
    @IBAction func shareMemeImage(sender: AnyObject) {
        let memeImg = generateMemedImage()
        
        let avc = UIActivityViewController(activityItems: [memeImg], applicationActivities:nil)
        presentViewController(avc, animated: true, completion: nil)
        
        avc.completionWithItemsHandler = {
            (activityType, completed, returnedItems, activityError) in
            if completed {
                let memeObject = Meme(topString: self.topTextField.text!, bottomString: self.bottomTextField.text!, originalImage: self.imageView.image!, memeImage: memeImg)
                self.dismissViewControllerAnimated(true, completion: nil)
                let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
                appDelegate.meme.append(memeObject)
                self.parentViewController?.dismissViewControllerAnimated(true, completion: nil)
            }
        }
    }
    
    @IBAction func pickImageFromPhoto(sender: AnyObject) {
        pickImage(.PhotoLibrary)
    }
    
    @IBAction func backToDefaultSetting(sender: AnyObject) {
        resetUI()
    }
    
    @IBAction func pickImageFromCamera(sender: AnyObject) {
        pickImage(.Camera)
    }
    
    func pickImage(sourceType: UIImagePickerControllerSourceType){
        let imagePicker = UIImagePickerController()
        imagePicker.sourceType = sourceType
        imagePicker.delegate = self
        presentViewController(imagePicker, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        topTextField.delegate = self
        bottomTextField.delegate = self
        configTextField(topTextField)
        configTextField(bottomTextField)
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        cameraButton.enabled = UIImagePickerController.isSourceTypeAvailable(.Camera)
        if imageView.image == nil{
            shareButton.enabled = false
        }else{
            shareButton.enabled = true
        }
        shareButton.enabled = (imageView.image == nil) ? false : true
        subscribeToKeyboardNotifications()
    }
    
    override func viewWillDisappear(animated: Bool) {
        unsubscribeFromKeyboardNotifications()
    }
    
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
    
    func resetUI(){
        topTextField.text = "TOP"
        bottomTextField.text = "BOTTOM"
        imageView.image = nil
        shareButton.enabled = false
    }

    func configTextField(textField: UITextField){
        if textField == topTextField {
            textField.text = "TOP"
        }else if textField == bottomTextField {
            textField.text = "BOTTOM"
        }
        textField.contentHorizontalAlignment = .Center
        
        let memeTextAttributes = [
            NSStrokeColorAttributeName : UIColor.blackColor(),
            NSForegroundColorAttributeName : UIColor.whiteColor(),
            NSFontAttributeName : UIFont(name: "HelveticaNeue-CondensedBlack", size: 40)!,
            NSStrokeWidthAttributeName : -0.1
        ]
        topTextField.defaultTextAttributes = memeTextAttributes
        bottomTextField.defaultTextAttributes = memeTextAttributes
    }
    
    //MARK: text field delegate
    func textFieldDidBeginEditing(textField: UITextField) {
        textField.becomeFirstResponder()
        
        if imageView.image != nil {
            textField.text = ""
        }
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    //MARK: image picker controller delegate
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]){
        dismissViewControllerAnimated(true, completion: nil)
        imageView.image = info[UIImagePickerControllerOriginalImage] as? UIImage
        imageView.contentMode = UIViewContentMode.ScaleAspectFit
    }

    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    //MARK: keyboard notifications
    func subscribeToKeyboardNotifications() {
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillShow:",
            name: UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillHide:",
            name: UIKeyboardWillHideNotification, object: nil)
    }
    
    func unsubscribeFromKeyboardNotifications() {
        NSNotificationCenter.defaultCenter().removeObserver(self, name:
            UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().removeObserver(self, name:
            UIKeyboardWillHideNotification, object: nil)

    }
    
    func keyboardWillShow(notification: NSNotification){
        if bottomTextField.isFirstResponder() {
            view.frame.origin.y -= getKeyboardHeight(notification)
        }
    }
    
    func keyboardWillHide(notification: NSNotification){
        if bottomTextField.isFirstResponder() {
            view.frame.origin.y += getKeyboardHeight(notification)
        }
    }
    
    func getKeyboardHeight(notification: NSNotification) -> CGFloat{
        let userInfo = notification.userInfo
        let keyboardSize = userInfo![UIKeyboardFrameEndUserInfoKey] as! NSValue
        return keyboardSize.CGRectValue().height
    }
    
    //MARK: generate meme image
    func generateMemedImage() -> UIImage {
        
        topBar.hidden = true
        bottomBar.hidden = true
        
        // Render view to an image
        UIGraphicsBeginImageContext(view.frame.size)
        view.drawViewHierarchyInRect(view.frame, afterScreenUpdates: true)
        let memedImage : UIImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        topBar.hidden = false
        bottomBar.hidden = false
        
        return memedImage
    }
}

