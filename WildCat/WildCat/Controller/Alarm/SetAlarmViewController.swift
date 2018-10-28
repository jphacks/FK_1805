//
//  SetAlarmViewController.swift
//  WildCat
//
//  Created by 陰山賢太 on 2018/10/27.
//  Copyright © 2018 Azuma. All rights reserved.
//

import UIKit

class SetAlarmViewController: UIViewController, PatternTableViewControllerDelegate {



    // MARK: - Propaties
    
    @IBOutlet weak var timePicker: UIDatePicker!
    @IBOutlet weak var saveButton: UIButton!

    var new: Pattern?

    // MARK: - View Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()

        timePicker.setValue(UIColor.white, forKey: "textColor")
    }

    func didFinishChoosePattern(pattern: Pattern) {
        self.new = pattern
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
