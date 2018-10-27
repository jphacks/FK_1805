//
//  UIViewController+Extension.swift
//  WildCat
//
//  Created by Azuma on 2018/10/27.
//  Copyright © 2018 Azuma. All rights reserved.
//

import UIKit

extension UIViewController {
    func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        self.present(alert, animated: true) {
            DispatchQueue.main.asyncAfter(deadline: .now()+0.5, execute: {
                alert.dismiss(animated: true, completion: nil)
            })
        }
    }
}
