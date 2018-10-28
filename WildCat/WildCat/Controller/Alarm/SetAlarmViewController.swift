//
//  SetAlarmViewController.swift
//  WildCat
//
//  Created by 陰山賢太 on 2018/10/27.
//  Copyright © 2018 Azuma. All rights reserved.
//

import UIKit

class SetAlarmViewController: UIViewController, PatternTableViewControllerDelegate {
    
    @IBOutlet weak var timePicker: UIDatePicker!
    @IBOutlet weak var patternImageView: UIImageView!
    @IBOutlet weak var patternLabel: UILabel!

    var new: Pattern?

    override func viewDidLoad() {
        super.viewDidLoad()

        timePicker.setValue(UIColor.white, forKey: "textColor")
    }

    func didFinishChoosePattern(pattern: Pattern) {
        self.new = pattern
        self.patternLabel.text = self.new?.message
        LocalPhoto.load(localIdentifer: (self.new?.imagePath)!) { (image) in
            self.patternImageView.image = image
        }
    }

    @IBAction func selectPatternAction(_ sender: Any) {
        let next = storyboard?.instantiateViewController(withIdentifier: "selectPatternViewController") as! SelectPatternTableViewController
        next.delegate = self
        self.navigationController?.pushViewController(next, animated: true)
    }

    // MARK: - Actions of Buttons

    @IBAction func saveButtonTapped(_ sender: Any) {
        if self.new != nil {
            let alarm = Alarm()
            alarm.id = Int(arc4random())
            alarm.date = timePicker.date
            alarm.pattern = self.new
            Alarm.add(alarm: alarm)
            self.navigationController?.popViewController(animated: true)
        }
    }
}
