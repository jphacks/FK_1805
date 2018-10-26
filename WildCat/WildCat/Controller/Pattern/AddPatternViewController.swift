//
//  AddPatternViewController.swift
//  WildCat
//
//  Created by 山浦功 on 2018/10/26.
//  Copyright © 2018 Azuma. All rights reserved.
//

import UIKit

class AddPatternViewController: TextViewViewController {

    @IBOutlet weak private var photoImageView: UIImageView!
    @IBOutlet weak private var messageTextView: UITextView!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.messageTextView.delegate = self
        self.setUpNotificationForTextView()
    }
    
    @IBAction func selectImageAction(_ sender: Any) {
    }

    @IBAction func addPatternAction(_ sender: Any) {
        let new = Pattern.init()
        new.id = Int(arc4random())
        new.message = self.messageTextView.text
        new.imagePath = String()
        Pattern.add(pattern: new)
    }
}
