//
//  ViewController.swift
//  DetectFood
//
//  Created by Javier Calderon on 12/15/17.
//  Copyright © 2017 Javier Calderon. All rights reserved.
//

import UIKit
import CoreML
import Vision

class ViewController: UIViewController, UIImagePickerControllerDelegate,UINavigationControllerDelegate {

    @IBOutlet weak var imageViewPhoto: UIImageView!
    
    let imagePicker = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imagePicker.delegate = self
        imagePicker.sourceType = .photoLibrary
        imagePicker.allowsEditing = false
    }
    
    @IBAction func buttonCameraPresed(_ sender: UIBarButtonItem) {
        present(imagePicker, animated: true, completion: nil)
    }
    
    // Picker Delegate
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let userPickedimage = info[UIImagePickerControllerOriginalImage] as? UIImage {
            imageViewPhoto.image = userPickedimage
        }
        imagePicker.dismiss(animated: true, completion: nil)
    }
}

