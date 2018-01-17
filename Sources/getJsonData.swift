//
//  getJsonData.swift
//  CreateYourOwnApnsPackageDescription
//
//  Created by Anıl T. on 17.01.2018.
//

import Foundation


import PerfectLib
import PerfectCURL
import cURL

struct getJsonData {
    
    func getData(){

        
        
        // Container variables
var header = [UInt8]()
var body = [UInt8]()

       

// This will return JSON
let curlObject2 = CURL(url: "http://ip.jsontest.com/")

print("Test URL: \(curlObject2.url)")

// Informing remote server that JSON data is expected
curlObject2.setOption(CURLOPT_HTTPHEADER, s: "application/json")
curlObject2.setOption(CURLOPT_USERAGENT, s: "PerfectAPI2.0")


var perf = curlObject2.perform()

while perf.0 {
    if let h = perf.2 {
        header.append(contentsOf: h)
    }
    if let b = perf.3 {
        body.append(contentsOf: b)
    }
    perf = curlObject2.perform()
}
if let h = perf.2 {
    header.append(contentsOf: h)
}
if let b = perf.3 {
    body.append(contentsOf: b)
}
let _ = perf.1

curlObject2.close()

// Decoding the result.
let hstr2 = UTF8Encoding.encode(bytes: header)

print("Header:")
print(hstr2)

// The following decodes the body array to a string, but then converts it as JSON to a [String:Any] object
print("Body:")
do {
    let str = UTF8Encoding.encode(bytes: body)
    let decoded = try str.jsonDecode() as? [String:Any]
    guard let sell = decoded!["sell"] as! String?,
        let high = decoded!["high"] as! String?,
        let buy = decoded!["buy"] as! String?/*
        let systemName = incoming["systemName"] as! String?,
        let appVersion = incoming["appVersion"] as! String?,
        let vendorUUID = incoming["vendorUUID"] as! String?,
        let bundleIdentifier = incoming["bundleIdentifier"] as! String?,
        let systemVersion = incoming["systemVersion"] as! String?*/
        else {
            print("bitcoin json yanlış")
            return
    }
    print("sell \(sell)")
    print("buy \(buy)")
    print("high\(high)")
    writeValue(Query:  "INSERT INTO Bitcoin (sell,high,buy,date) values('\(sell)','\(high)','\(buy)',NOW())")
    
} catch {
    print("Decode error: \(error)")
}
}

}

