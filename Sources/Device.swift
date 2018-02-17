////
////  Device.swift
////  CreateYourOwnApns
////
////  Created by Anıl T. on 12.01.2018.
////
//import PerfectHTTP
//import PerfectNotifications
//
//
//public class Device {
//
//static let instance = Device()
//    
//    func notify(title: String, message: String, deviceTokens: [String], isSilent: Bool) {
//        var notItems: [APNSNotificationItem] = [.alertTitle(title), .alertBody(message), .sound("default")]
//        if isSilent {
//            print("silent gönderildi.")
//            notItems.removeAll()
//            notItems = [.contentAvailable]
//        }
//        let n = NotificationPusher(apnsTopic: notificationsAppId)
//        
//        n.pushAPNS(
//            configurationName: notificationsAppId,
//            deviceTokens: deviceTokens,
//            notificationItems: notItems) {
//                responses in
//                print("\(responses)")
//        }
//    }
//    
//}

