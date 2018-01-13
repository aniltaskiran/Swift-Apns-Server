//
//  people.swift
//  CreateYourOwnApns
//
//  Created by Anıl T. on 12.01.2018.
//
import PerfectHTTP
import PerfectNotifications

var data : [DeviceJsonObject] = []

public class Device {
    
static let instance = Device()
    
    // Populating with a mock data object
    
    // A simple JSON encoding function for listing data members.
    // Ordinarily in an API list directive, cursor commands would be included.
    public func list() -> String {
        return toString()
    }
    
    // Accepts raw JSON string, to be converted to JSON and consumed.
    public func add(_ json: String) -> String {
        do {
            let incoming = try json.jsonDecode() as! [String: String]
            let new = DeviceJsonObject(mToken: incoming["token"] ?? "")

            data.append(new)
        } catch {
            return "ERROR"
        }
        return toString()
    }
    
    
    // Convenient encoding method that returns a string from JSON objects.
    private func toString() -> String {
        var out = [String]()
        
        for m in data {
            do {
                out.append(try m.jsonEncodedString())
            } catch {
                print(error)
            }
        }
        return "[\(out.joined(separator: ","))]"
    }
    
    
    
    func notify(title: String, message: String, deviceTokens: [String], isSilent: Bool) {
       var silentValue = "1"
        var notItems: [APNSNotificationItem] = [.alertTitle(title), .alertBody(message), .sound("default"), .threadId(silentValue)]
        if isSilent {
            silentValue = "0"
             notItems = [.contentAvailable]
        }
        print("silent value gönderildi.: " + silentValue)
        let n = NotificationPusher(apnsTopic: notificationsAppId)
        
        n.pushAPNS(
            configurationName: notificationsAppId,
            deviceTokens: deviceTokens,
            notificationItems: notItems) {
                responses in
                print("\(responses)")
        }
    }
    
}
