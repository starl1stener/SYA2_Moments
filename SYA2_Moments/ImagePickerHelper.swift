//
//  ImagePickerHelper.swift
//  SYA2_Moments
//
//  Created by Anton Novoselov on 08/11/2016.
//  Copyright © 2016 Anton Novoselov. All rights reserved.
//

import UIKit
import MobileCoreServices

typealias ImagePickerHelperCompletion = ((UIImage?) -> Void)?

class ImagePickerHelper: NSObject {
    
    // actionsheet, imagePickerController ==> viewController
    
    weak var viewController: UIViewController!
    
    var completion: ImagePickerHelperCompletion
    
    
    init(viewController: UIViewController, completion: ImagePickerHelperCompletion) {
        self.viewController = viewController
        self.completion = completion
        
        super.init()
        
        self.showPhotoSourceSelection()
    }
    
    func showPhotoSourceSelection() {
        let actionSheet = UIAlertController(title: "Pick New Photo", message: "Would you like to open photos library or camer", preferredStyle: .actionSheet)
        
        let cameraAction = UIAlertAction(title: "Camera", style: .default, handler: {
            action in
            
            self.showImagePicker(sourceType: .camera)

            
        })
        
        let photosLibraryAction = UIAlertAction(title: "Photo Library", style: .default, handler: {
            action in
            
            self.showImagePicker(sourceType: .photoLibrary)
            
        })
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        actionSheet.addAction(cameraAction)
        actionSheet.addAction(photosLibraryAction)
        actionSheet.addAction(cancelAction)
        
        viewController.present(actionSheet, animated: true, completion: nil)
        
        
    }
    
    func showImagePicker(sourceType: UIImagePickerController.SourceType) {
        
        let imagePicker = UIImagePickerController()
        
        imagePicker.allowsEditing = true
        imagePicker.sourceType = sourceType
        
        imagePicker.mediaTypes = [kUTTypeImage as String]
        
        imagePicker.delegate = self
        
        viewController.present(imagePicker, animated: true, completion: nil)
    }
    
    
}



extension ImagePickerHelper: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        viewController.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let image = info[UIImagePickerController.InfoKey.editedImage.rawValue] as! UIImage
        
        viewController.dismiss(animated: true, completion: nil)
        
        completion!(image)
        
    }
    
    
    
}


























