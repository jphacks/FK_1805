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
            let id = String(pattern.id)
            let remotePath = RemotePath.filter(localPath: pattern.imagePath)
            let content = UNMutableNotificationContent()
            content.title = "まいちゃん"
            content.body = pattern.message
            if remotePath.first != nil {
//                let url = URL(string: remote.remotePath)!
                let url = Bundle.main.url(forResource: "she", withExtension: "png")
                print(url!.description ?? "error")
                do {
                    let attempt = try UNNotificationAttachment(identifier: "image", url: url!, options: nil)
                    content.attachments = [attempt]
                } catch {
                    print(error)
                }
            }
            /// set time
            let dateComponents = Calendar.current.dateComponents([.hour, .minute], from: alarm.date)
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
