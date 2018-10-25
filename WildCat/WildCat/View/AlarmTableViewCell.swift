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

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
