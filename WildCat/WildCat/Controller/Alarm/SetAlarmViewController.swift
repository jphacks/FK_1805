//
//  SetAlarmViewController.swift
//  WildCat
//
//  Created by 陰山賢太 on 2018/10/27.
//  Copyright © 2018 Azuma. All rights reserved.
//

import UIKit

class SetAlarmViewController: UIViewController {

    // MARK: - Propaties
    
    @IBOutlet weak var timePicker: UIDatePicker!
    @IBOutlet weak var saveButton: UIButton!

    // MARK: - View Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()

        
    }

    // MARK: - Actions of Buttons

    @IBAction func saveButtonTapped(_ sender: Any) {
        let alarm = Alarm()
        alarm.date = timePicker.date

        // test
        alarm.pattern = Pattern.read()[0]

        Alarm.add(alarm: alarm)
    }
}
