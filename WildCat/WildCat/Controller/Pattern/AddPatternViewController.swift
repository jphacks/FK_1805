//
//  AddPatternViewController.swift
//  WildCat
//
//  Created by 山浦功 on 2018/10/26.
//  Copyright © 2018 Azuma. All rights reserved.
//

import UIKit

class AddPatternViewController: TextViewViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak private var photoImageView: UIImageView!
    @IBOutlet weak private var messageTextView: UITextView!
    private let imagePicker = UIImagePickerController()
    private var imageURL: String?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.messageTextView.delegate = self
        self.setUpNotificationForTextView()
        self.imagePicker.delegate = self
    }
    
    @IBAction func selectImageAction(_ sender: Any) {
        self.imagePicker.allowsEditing = false
        self.imagePicker.sourceType = .photoLibrary
        self.present(imagePicker, animated: true, completion: nil)
    }

    @IBAction func addPatternAction(_ sender: Any) {
        guard let imagePath = self.imageURL else { return }
        let new = Pattern.init()
        new.id = Int(arc4random())
        new.message = self.messageTextView.text
        new.imagePath = imagePath
        Pattern.add(pattern: new)
        dismiss(animated: true, completion: nil)
    }
}

extension AddPatternViewController {

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let pickedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            self.photoImageView.contentMode = .scaleAspectFit
            self.photoImageView.image = pickedImage
        }
        if let photoURL = info[UIImagePickerController.InfoKey.imageURL] as? URL {
            self.imageURL = photoURL.absoluteString
        }
        dismiss(animated: true, completion: nil)
    }

    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
}
