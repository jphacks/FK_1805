//
//  AlarmManager.swift
//  WildCat
//
//  Created by 陰山賢太 on 2018/10/25.
//  Copyright © 2018 Azuma. All rights reserved.
//

import Foundation
import UserNotifications

protocol NotificationManagerInterface: class {
    func addNotification(Alarm: Alarm)
    func deleteNotification(Alarm: Alarm)
}

class NotificationManager: NotificationManagerInterface {


    func addNotification(Alarm: Alarm) {
//        let center = UNUserNotificationCenter
    }

    func deleteNotification(Alarm: Alarm) {
    }
}



import UIKit

class SelectPatternTableViewController: PatternTableViewController, PatternTableViewControllerDelegate {
    func didFinishChoosePattern(pattern: Pattern) {

    }


}

class AlarmManager {
    class func allowNotification() -> Void {
        let center = UNUserNotificationCenter.current()
        center.requestAuthorization(options: [.alert, .sound, .badge]) { (granted, error) in
            if error != nil {
                return
            }

            if granted {
                print("通知許可")
            } else {
                print("通知拒否")
            }
        }
    }

    class func setAlarm(alarm: Alarm) -> Void {
        // 通知する時間をセット
        var notificationTime = DateComponents()
        notificationTime.hour = 12
        notificationTime.minute = 0
        let trigger = UNCalendarNotificationTrigger(dateMatching: notificationTime, repeats: false)

        // 通知する内容をセット
        let content = UNMutableNotificationContent()
        content.title = "Title"
        content.body = (alarm.pattern?.message)!
        content.sound = UNNotificationSound.default
        content.attachments = [try! UNNotificationAttachment(identifier: "id", url: URL(fileReferenceLiteralResourceName: (alarm.pattern?.imagePath)!), options: nil)]

        // 通知リクエストを作成
        let request = UNNotificationRequest(identifier: "id", content: content, trigger: trigger)

        // 通知セット
        UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
    }
}
