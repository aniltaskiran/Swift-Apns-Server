//
//  Notifier.swift
//  Perfect-APNS
//
//  Created by Ryan Collins on 2/10/17.
//
//

import PerfectLib
import PerfectHTTP
import PerfectHTTPServer

// IT WORKS FOR WEB SIDE
struct Notifier {
    func notify(withJSONRequest json: String) -> String {
        var response = "{\"Error\": \"Failed to invoke notification\"}"
        var isSilent = false
        do {
            let dict = try json.jsonDecode() as! [String: String]

            if let title = dict["title"], let message = dict["message"], let silentValue = dict["silentValue"] {
                print("silent value: " + silentValue)
                if silentValue == "0" {
                    isSilent = true
                }
                readAll(completion: { (tokens) in
                    Device.instance.notify(title: title, message: message,deviceTokens: tokens,isSilent: isSilent)
                })
                
         response = "{\"success\": true}"
            }
        } catch {
            print("Failed to decode JSON")
        }
        
        return response
    }
    
    func notifyAll(title: String = "", message: String = "", isSilent: Bool = true)-> [String: String] {
        let responseJson: [String: String] = ["success":"true"]
        readAll(completion: { (tokens) in
            Device.instance.notify(title: title, message: message,deviceTokens: tokens, isSilent: isSilent)
        })
        return responseJson
    }
}

struct DeviceJson {

    func checkKind(withJSONRequest: String) -> String{
        var responseJson: [String: Any] = ["success":"false"]

        let response = "{\"Error\": \"Failed to decode json\"}"
        print(response)
        
        do {
            print("json objesi dönüştürülüyor")
            
            guard let incoming = try withJSONRequest.jsonDecode() as? [String:Any] else {
                print("error trying to convert data to JSON")
                return response
            }
            guard let secretKey = incoming["secretKey"] as! String? else{
                return response
            }
            
            guard secretKey == SECRET_KEY else {
                return response
            }
            
            guard let kind = incoming["kind"] as! String? else {
                print("error there is no kind")
                return response
            }
            switch kind {
            case "token":
                responseJson = registerDevice(incoming: incoming)
                break
            case "addDevice":
                responseJson = addDevice(incoming: incoming)
                break
            case "notifySilent":
                responseJson = Notifier().notifyAll()
            default:
                responseJson["success"] = "false"
                break
            }
        } catch {
            print("error")
        }
        
        
        guard let jsonData = try? responseJson.jsonEncodedString() else {
            print("json data yok")
            return response
        }
        
        return jsonData
    }
    
   private func registerDevice(incoming: [String:Any]) -> [String: Any] {
        var responseJson: [String: String] = ["success":"false"]
        if let token = incoming["token"] as! String? {
            responseJson["ID"] = "\(registerToken(token: token)[0])"
            print("json token objesi gönderildi.")
            responseJson["success"] = "true"
        }
        return responseJson
    }
    func registerToken(token: String) -> [String]{
        print("register token'a girildi. yazılıyor.")
        writeValue(Query: "REPLACE INTO Tokens (token, date) VALUES ('\(token)', NOW())")
        return returnID(token: token)
    }
    
    
    private func addDevice(incoming: [String:Any]) -> [String: Any] {
    var responseJson: [String: String] = ["success":"false"]
    //github
    //                    Database'de kullanılan değişkenler
    //                    var id: Int
    //                    var name: String ,model: String ,systemName: String ,appVersion: String ,vendorUUID: String ,bundleIdentifier: String, systemVersion: String
    
    guard let id = incoming["id"] as! String?,
    let name = incoming["name"] as! String?,
    let model = incoming["model"] as! String?,
    let systemName = incoming["systemName"] as! String?,
    let appVersion = incoming["appVersion"] as! String?,
    let vendorUUID = incoming["vendorUUID"] as! String?,
    let bundleIdentifier = incoming["bundleIdentifier"] as! String?,
    let systemVersion = incoming["systemVersion"] as! String?
    else {
    print("add device tokenı yanlış")
    return responseJson
    }
    
    responseJson["success"] = "true"
    
    writeValue(Query: "Replace INTO Devices (ID,name,model,systemName,appVersion,bundleIdentifier,vendorUUID,systemVersion,creationDate) values('\(id)','\(name)','\(model)','\(systemName)','\(appVersion)','\(bundleIdentifier)','\(vendorUUID)','\(systemVersion)',NOW())")
    print("json objesi gönderildi.")
    
    return responseJson

}
}

