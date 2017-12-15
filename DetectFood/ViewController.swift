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
    
    func detect(ciimage: CIImage)
    {
        guard let model = try? VNCoreMLModel(for: Inceptionv3().model) else {
            fatalError("Loadinfg CoreML Model Failed")
        }
        
        let request = VNCoreMLRequest(model: model) { (request, error) in
            guard let results = request.results as? [VNClassificationObservation] else {
                fatalError("Model failed to process image")
            }
            
            //print(results)
            if let firstResult = results.first {
                if firstResult.identifier.contains("hotdog")
                {
                    self.navigationItem.title = "Is a Hot Dog!"
                }else{
                    self.navigationItem.title = firstResult.identifier
                }
                print(String(firstResult.identifier) + " - " + String(firstResult.confidence))
            }
            
        }
        
        let handler = VNImageRequestHandler(ciImage: ciimage)
        
        do {
            try handler.perform([request])
        }catch{
            print(error)
        }
    }
    
    // Picker Delegate
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let userPickedimage = info[UIImagePickerControllerOriginalImage] as? UIImage {
            imageViewPhoto.image = userPickedimage
            guard let ciimage = CIImage(image:userPickedimage) else {
                fatalError("Could not convert UIImage inti UIImage")
            }
            
            detect(ciimage: ciimage)
        }
        imagePicker.dismiss(animated: true, completion: nil)
    }
    
}

