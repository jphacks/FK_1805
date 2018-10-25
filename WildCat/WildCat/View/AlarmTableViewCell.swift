//
//  AlarmTableViewCell.swift
//  WildCat
//
//  Created by 陰山賢太 on 2018/10/25.
//  Copyright © 2018 Azuma. All rights reserved.
//

import UIKit

class AlarmTableViewCell: UITableViewCell {

    // MARK: - Propaties

    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var photoImage: UIImageView!
    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var alarmSwitch: UISwitch!

    // MARK: - Method

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    func update(target alarm:Alarm) {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        self.timeLabel.text = formatter.string(from: alarm.date)
        self.messageLabel.text = alarm.pattern?.message
        let url = URL(string: (alarm.pattern?.imagePath)!)
        self.photoImage.kf.setImage(with: url)
    }
}
