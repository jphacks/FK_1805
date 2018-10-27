//
//  AddPatternViewController.swift
//  WildCat
//
//  Created by 山浦功 on 2018/10/26.
//  Copyright © 2018 Azuma. All rights reserved.
//

import UIKit
import Photos

class AddPatternViewController: TextViewViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, PhotoPickerControllerDelegate {

    @IBOutlet weak private var photoImageView: UIImageView!
    @IBOutlet weak private var messageTextView: CustomTextView!
    private let imagePicker = UIImagePickerController()
    private var localIdentifier: String?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.messageTextView.delegate = self
        self.setUpNotificationForTextView()
        self.imagePicker.delegate = self
    }

    func didSelectPhoto(asset: PHAsset) {
        let identifier = asset.localIdentifier
        self.localIdentifier = identifier
        LocalPhoto.load(localIdentifer: identifier) { (image) in
            self.photoImageView.image = image
        }
    }
    
    @IBAction func selectImageAction(_ sender: Any) {
//        self.imagePicker.allowsEditing = false
//        self.imagePicker.sourceType = .photoLibrary
//        self.present(imagePicker, animated: true, completion: nil)
        let next = PhotoPickerController()
        next.delegate = self
        self.present(next, animated: true, completion: nil)
    }

    @IBAction func addPatternAction(_ sender: Any) {
        guard let localIdentifier = self.localIdentifier else { return }
        let new = Pattern.init()
        new.id = Int(arc4random())
        new.message = self.messageTextView.text
        new.imagePath = localIdentifier
        Pattern.add(pattern: new)
        dismiss(animated: true, completion: nil)
    }

    @IBAction func dismissAction(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
}

extension AddPatternViewController {

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let pickedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            self.photoImageView.contentMode = .scaleAspectFit
            self.photoImageView.image = pickedImage
        }
        if let asset = info[UIImagePickerController.InfoKey.phAsset] as? PHAsset {
            self.localIdentifier = asset.localIdentifier
        }
        dismiss(animated: true, completion: nil)
    }

    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
}
