//
//  PhotoHelper.swift
//  ACBook
//
//  Created by Lorenzo on 04/09/22.
//

import Foundation
import UIKit

class PhotoHelper: UIViewController,
                   UIImagePickerControllerDelegate,
                   UINavigationControllerDelegate {
    
    func openCameraButton(sender: AnyObject) {
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.sourceType = .camera;
            imagePicker.allowsEditing = true
            present(imagePicker, animated: true)
        }
    }
    
    func openPhotoLibraryButton(sender: AnyObject) {
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.sourceType = .photoLibrary;
            imagePicker.allowsEditing = true
            self.present(imagePicker, animated: true)
        }
    }
}
