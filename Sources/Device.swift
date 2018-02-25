//
//  Device.swift
//  CreateYourOwnApns
//
//  Created by Anıl T. on 12.01.2018.
//
import PerfectHTTP
import PerfectNotifications



public class Device {

    static let instance = Device()

    func notify(title: String, message: String, deviceTokens: [String], isSilent: Bool) {
        let data = ["attachment-url":"https://github.com/Sweefties/WatchOS2-NewUI-Movie-Example/raw/master/WatchOS2-NewUI-Movie-Example%20WatchKit%20App/MoviePath/burningmanbyair.m4v"]
        
        var notItems: [APNSNotificationItem] = [.alertTitle(title), .alertBody(message), .sound("default"), .mutableContent, .category("videoIdentifier"), .customPayload("data", data)]
        
        if isSilent {
            print("silent gönderildi.")
            notItems.removeAll()
            notItems = [.alertTitle(title), .contentAvailable, .mutableContent, .category("videoIdentifier"), .customPayload("data", data)]
        }
        let n = NotificationPusher(apnsTopic: notificationsAppId)
        n.pushAPNS(
            configurationName: notificationsAppId,
            deviceTokens: deviceTokens,
            notificationItems: notItems) {
                responses in
                print("not response is: \(responses)")
        }
    }

}


