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

func getBitcoinValues(data: [String:Any]) throws -> RequestHandler {
    return {
        request, response in
        print("bitcoin Handler")
//        getJsonData().getData()
        response.setHeader(.contentType, value: "application/json")
        response.appendBody(string:"Bitcoin")
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
            response.setHeader(.contentType, value: "application/json")
            response.appendBody(string: "success")
            response.completed()
        })
        
    }
}

func repeatFuncHandler(data: [String:Any]) throws -> RequestHandler {
    return {
        request, response in
        print("POST api/v1/postDevice/json geldi")
        print(request.postBodyString!)
        
        writeValue(Query: "INSERT INTO Deneme(date) values(NOW())")
        response.setHeader(.contentType, value: "application/json")
        response.appendBody(string: DeviceJson().checkKind(withJSONRequest: request.postBodyString!))
        response.completed()
    }
}

func registrationHandler(data: [String:Any]) throws -> RequestHandler {
    return {
        request, response in
        print("POST api/v1/postDevice/json geldi")
        print(request.postBodyString!)

        
        response.setHeader(.contentType, value: "application/json")
        response.appendBody(string: DeviceJson().checkKind(withJSONRequest: request.postBodyString!))
        response.completed()
        
        }
}

