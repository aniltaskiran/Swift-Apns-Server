//
//  Handlers.swift
//  Perfect-APNS
//
//  Created by Ryan Collins on 2/9/17.
//
//

import PerfectLib
import PerfectHTTP
import PerfectHTTPServer

func notificationHandler(data: [String:Any]) throws -> RequestHandler {
    return {
        request, response in
        print("notify Handler")
        
        response.setHeader(.contentType, value: "application/json")
        response.appendBody(string: Notifier().notify(withJSONRequest: request.postBodyString ?? "Empty Body"))
        response.completed()
    }
}


func notifyAllHandler(data: [String:Any]) throws -> RequestHandler {
    return {
        request, response in
        print("Get api/v1/NotifyAll Çalıştı")
        
        readAll(completion: { (tokens) in
            print("herkese gönderiliyor")
            
            var title = "" , msg = "" , silentValue = "", isSilent = true
            
            do {
                let incoming = try request.postBodyString!.jsonDecode() as! [String: String]
                title = incoming["title"] ?? ""
                msg   = incoming["msg"] ?? ""
                silentValue = incoming["silentValue"] ?? ""
            } catch {
                print("error")
            }
            
            if silentValue == "1" {
                isSilent = false
            }
            
            Device.instance.notify(title: title, message: msg, deviceTokens: tokens, isSilent: isSilent)
            // Setting the response content type explicitly to application/json
            response.setHeader(.contentType, value: "application/json")
            // Setting the body response to the JSON list generated
            response.appendBody(string: "success")
            // Signalling that the request is completed
            response.completed()
        })
        
    }
}

func repeatFuncHandler(data: [String:Any]) throws -> RequestHandler {
    return {
        request, response in
        print("POST api/v1/postDevice/json geldi")
        writeValue(Query: "INSERT INTO Deneme(date) values(NOW())")
        print(request.postBodyString!)
        
        // Setting the response content type explicitly to application/json
        response.setHeader(.contentType, value: "application/json")
        // Adding a new "person", passing the just the request's post body as a raw string to the function.
        response.appendBody(string: "success")
        // Signalling that the request is completed
        response.completed()
    }
}

func registrationHandler(data: [String:Any]) throws -> RequestHandler {
    return {
        request, response in
        print("POST api/v1/postDevice/json geldi")
        print(request.postBodyString!)
        var responseJson: [String: Any] = ["success":"false"]
        
//        do {
//            guard let ResponseJson = try JSONSerialization.jsonObject(with: data, options: []) as? [String: AnyObject] else {
//                print("error trying to convert data to JSON")
//                return
//            }
//            print("The ResponseJson is: " + ResponseJson.description)
//
//            guard let responseSuccess = ResponseJson["success"] as? Int else {
//                print("Could not get ResponseJson from JSON")
//                return
//            }
//            print("The ResponseJson is: ")
//            print(responseSuccess)
//        } catch  {
//            print("error trying to convert data to JSON")
//            return
//        }
        
        do {
            print("json objesi dönüştürülüyor")
            guard let incoming = try request.postBodyString?.jsonDecode() as! [String: AnyObject]? else {
                print("error trying to convert data to JSON")
                return
            }
            guard let kind = incoming["kind"] as! String? else {
                print("error there is no kind")
                return
            }
                switch kind {
                case "token":
                    if let token = incoming["token"] as! String? {
                        responseJson["ID"] = "\(Device.instance.registerToken(token: token)[0])"
                        print("json objesi gönderildi.")
                    }
                    break
                case "addDevice":
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
                        return
                    }
                    writeValue(Query: "Replace INTO Devices (ID,name,model,systemName,appVersion,bundleIdentifier,vendorUUID,systemVersion,creationDate) values('\(id)','\(name)','\(model)','\(systemName)','\(appVersion)','\(bundleIdentifier)','\(vendorUUID)','\(systemVersion)',NOW())")
                    print("json objesi gönderildi.")
                    break
                default:
                    print("default switch")
                    break
                }
            } catch {
                print("error")
            }
        
        guard let jsonData = try? responseJson.jsonEncodedString() else {
            print("json data yok")
            return
        }
        
        
//        _ = Device(request.postBodyString!)
        
        // Setting the response content type explicitly to application/json
        response.setHeader(.contentType, value: "application/json")
        // Adding a new "person", passing the just the request's post body as a raw string to the function.
        response.appendBody(string: jsonData)
        // Signalling that the request is completed
        response.completed()
        
        }
}

