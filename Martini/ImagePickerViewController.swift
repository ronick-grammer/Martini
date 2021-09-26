//
//  ImagePickerViewController.swift
//  Martini
//
//  Created by RONICK on 2021/09/17.
//

import UIKit
import MobileCoreServices

protocol CustomImagePickerViewDelegate {
    func didSelectImage(image: UIImage)
}

class CustomImagePickerView: UIImagePickerController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    var image: UIImage?
    
    var customImagePickerViewDelegate: CustomImagePickerViewDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()

        setupImagePicker()
    }
    
    func setupImagePicker() {

        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
            self.delegate = self
            self.sourceType = .photoLibrary
            self.mediaTypes = [kUTTypeImage as String]
            self.allowsEditing = true
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        let mediaType = info[UIImagePickerController.InfoKey.mediaType] as! NSString
        
        if mediaType.isEqual(to: kUTTypeImage as NSString as String) {
            image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage
        }
        
        customImagePickerViewDelegate?.didSelectImage(image: image ?? UIImage())
        
        self.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        self.dismiss(animated: true, completion: nil)
    }
    

}
