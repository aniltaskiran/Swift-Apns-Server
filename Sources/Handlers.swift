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
        
        do {
            print("json objesi dönüştürülüyor")
            let incoming = try request.postBodyString?.jsonDecode() as! [String: Any]
            let kind = incoming["kind"] as! String
            switch kind {
            case "token":
                let token = incoming["token"] as! String
                Device.instance.registerToken(token: token)
                print("json objesi gönderildi.")
                break
            default:
                break
            }
        } catch {
            print("error")
        }
//        _ = Device(request.postBodyString!)
        
        // Setting the response content type explicitly to application/json
        response.setHeader(.contentType, value: "application/json")
        // Adding a new "person", passing the just the request's post body as a raw string to the function.
        response.appendBody(string: "success")
        // Signalling that the request is completed
        response.completed()
        
    }
}

