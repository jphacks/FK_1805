//
//  NotificationManager.swift
//  WildCat
//
//  Created by 陰山賢太 on 2018/10/25.
//  Copyright © 2018 Azuma. All rights reserved.
//

import Foundation
import UserNotifications

protocol NotificationManagerInterface:class {
    func addNotification(alarm: Alarm)
    func deletePendingNotification(alarm: Alarm)
    func deleteDeliveredNotification(alarm: Alarm)
}

class NotificationManager:NSObject, NotificationManagerInterface, UNUserNotificationCenterDelegate {

    override init() {}

    func addNotification(alarm: Alarm) {
        if let pattern = alarm.pattern {
            let content = UNMutableNotificationContent()
            content.title = "やまこーちゃんちゃんちゃん"
            content.body = pattern.message
            let id = String(pattern.id)
            /// set time
            var dateComponents = Calendar.current.dateComponents([.hour, .minute], from: alarm.date)
            dateComponents.hour = 15
            dateComponents.minute = 57
            let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: false)
            // set notification
            let request = UNNotificationRequest(identifier: id, content: content, trigger: trigger)
            let center = UNUserNotificationCenter.current()
            center.delegate = self
            center.add(request) { (error) in
                if error != nil {
                    print("通知：エラー")
                }
            }
        }
    }

    func deletePendingNotification(alarm: Alarm) {
        let id = String(alarm.id)
        let center = UNUserNotificationCenter.current()
        center.delegate = self
        center.removePendingNotificationRequests(withIdentifiers: [id])
    }

    func deleteDeliveredNotification(alarm: Alarm) {
        let id = String(alarm.id)
        let center = UNUserNotificationCenter.current()
        center.delegate = self
        center.removeDeliveredNotifications(withIdentifiers: [id])
    }
}
