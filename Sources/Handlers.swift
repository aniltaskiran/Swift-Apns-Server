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
        print("notify")
        
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
            Device.instance.notify(title: "HERKESE", message: "TOKEN", deviceTokens: tokens, isSilent: false)
            // Setting the response content type explicitly to application/json
            response.setHeader(.contentType, value: "application/json")
            // Setting the body response to the JSON list generated
            response.appendBody(string: "[\(tokens.joined(separator: ","))]")
            // Signalling that the request is completed
            response.completed()
        })
        
    }
}

func registrationHandler(data: [String:Any]) throws -> RequestHandler {
    return {
        request, response in
        
        print("POST api/v1/postDevice/json geldi")
        print(request.postBodyString!)
        let newDevice = DeviceJsonObject(mToken: "")
        
        do {
            let incoming = try request.postBodyString!.jsonDecode() as! [String: String]
            newDevice.token = incoming["token"] ?? ""
        } catch {
            print("error")
        }
        
        writeValue(token: newDevice.token)
        
        
        // Setting the response content type explicitly to application/json
        response.setHeader(.contentType, value: "application/json")
        // Adding a new "person", passing the just the request's post body as a raw string to the function.
        response.appendBody(string: "1")
        // Signalling that the request is completed
        response.completed()
        
    }
}

