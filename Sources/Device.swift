//
//  Device.swift
//  CreateYourOwnApns
//
//  Created by Anıl T. on 12.01.2018.
//
import PerfectHTTP
import PerfectNotifications


public class Device {

//    var jsonObjects : [DeviceJsonObject] = []

static let instance = Device()
    
    
    var name:                 String = ""
    var model:                String = ""
    var systemName:           String = ""
    var appVersion:           String = ""
    var identifierForVendor:  String = ""
    var token:                String = ""
    var localizedModel:       String = ""
    var vendorUUID:           String = ""
    var bundleIdentifier:     String = ""
    var systemVersion:        String = ""
    var uniqueKey:            String = ""

    
    func registerToken(token: String){
        writeValue(Query: "INSERT INTO Tokens (token, date) VALUES ('newToken', NOW())");
    }
    
    init() {
    }
    
    init(_ json: String) {
        do {
            print("json objesi dönüştürülüyor")
            let incoming = try json.jsonDecode() as! [String: String]
            //json gelen değerimizi kullanabilmek için gerekli bu fonksiyon, bu sayede database'e yazacağız.
            
            name = incoming["name"]!
            model = incoming["model"]!
            systemName = incoming["systemName"]!
            appVersion = incoming["appVersion"]!
            identifierForVendor = incoming["identifierForVendor"]!
            token = incoming["token"]!
            localizedModel = incoming["localizedModel"]!
            vendorUUID = incoming["vendorUUID"]!
            bundleIdentifier = incoming["bundleIdentifier"]!
            systemVersion = incoming["systemVersion"]!
            uniqueKey = incoming["uniqueKey"]!

            
        } catch {
            print("error")

        }
        print("json dönüştü")
        writeValue(Query: "INSERT INTO Devices(name,model,systemName,appVersion,identifierForVendor,token,localizedModel,vendorUUID,bundleIdentifier,systemVersion,uniqueKey,creationDate)  values('\(name.utf8DecodedString())','\(model)','\(systemName)','\(appVersion)','\(identifierForVendor)','\(token)','\(localizedModel)','\(vendorUUID)','\(bundleIdentifier)','\(systemVersion)','\(uniqueKey)',NOW())")
        writeValue(Query: "INSERT INTO Tokens(token,uniqueKey,creationDate) values ('\(token)','\(uniqueKey)',NOW())")
    }
    
    
//        // Ordinarily in an API list directive, cursor commands would be included.
//    public func list() -> String {
//        return toString()
//    }
    //
//
//    // Convenient encoding method that returns a string from JSON objects.
//    //Json objesini string olarak döndürüyor
//    private func toString() -> String {
//        var out = [String]()
//
//        for m in jsonObjects {
//            do {
//                out.append(try m.jsonEncodedString())
//            } catch {
//                print(error)
//            }
//        }
//        return "[\(out.joined(separator: ","))]"
//    }
    
    
    
    func notify(title: String, message: String, deviceTokens: [String], isSilent: Bool) {
        var notItems: [APNSNotificationItem] = [.alertTitle(title), .alertBody(message), .sound("default")]
        if isSilent {
            print("silent gönderildi.")
            notItems.removeAll()
            notItems = [.contentAvailable]
        }
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
