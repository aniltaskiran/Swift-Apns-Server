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

// IT WORKS WITH WEB SIDE 
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
}


