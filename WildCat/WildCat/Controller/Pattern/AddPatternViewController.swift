//
//  AddPatternViewController.swift
//  WildCat
//
//  Created by 山浦功 on 2018/10/26.
//  Copyright © 2018 Azuma. All rights reserved.
//

import UIKit
import Photos

class AddPatternViewController: TextViewViewController, PhotoPickerControllerDelegate {

    @IBOutlet weak private var photoImageView: UIImageView!
    @IBOutlet weak private var messageTextView: CustomTextView!
    private var localIdentifier: String?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.messageTextView.delegate = self
        self.setUpNotificationForTextView()
    }

    func didSelectPhoto(asset: PHAsset) {
        let identifier = asset.localIdentifier
        self.localIdentifier = identifier
        LocalPhoto.load(localIdentifer: identifier) { (image) in
            self.photoImageView.image = image?.cropping2square()
        }
    }
    
    @IBAction func selectImageAction(_ sender: Any) {
        let next = PhotoPickerController()
        next.delegate = self
        self.present(next, animated: true, completion: nil)
    }

    @IBAction func addPatternAction(_ sender: Any) {
        guard let localIdentifier = self.localIdentifier else {
            self.showAlert(title: "画像なし", message: "画像を選択してください。")
            return
        }
        if self.messageTextView.text.isEmpty {
            self.showAlert(title: "空のメッセージ", message: "メッセージを入力して下さい。")
            return
        }
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
}
