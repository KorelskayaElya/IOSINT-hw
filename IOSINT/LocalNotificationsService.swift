//
//  LocalNotificationsService.swift
//  IOSINT
//
//  Created by Эля Корельская on 25.06.2023.
//

import UserNotifications

class LocalNotificationsService {
    func registerForLatestUpdatesIfPossible() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { (granted, error) in
            if granted {
                self.scheduleDailyNotification()
            } else {
                print("Уведомления не разрешены.")
            }
        }
    }
    
    private func scheduleDailyNotification() {
        let content = UNMutableNotificationContent()
        content.title = ""
        content.body = "Посмотрите последние обновления"
        content.sound = UNNotificationSound.default
        content.badge = 1
        
        var dateComponents = DateComponents()
        dateComponents.hour = 19
        dateComponents.minute = 0
        
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
        
        let request = UNNotificationRequest(identifier: "dailyNotification", content: content, trigger: trigger)
        
        UNUserNotificationCenter.current().add(request) { (error) in
            if let error = error {
                print("Ошибка при добавлении уведомления: \(error.localizedDescription)")
            } else {
                print("Уведомление успешно добавлено.")
            }
        }
    }
}

