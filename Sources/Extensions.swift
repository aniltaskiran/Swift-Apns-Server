//
//  Extensions.swift
//  CreateYourOwnApnsPackageDescription
//
//  Created by Anıl T. on 13.01.2018.
//

import Foundation
extension String {
func utf8DecodedString()-> String {
    let data = self.data(using: .utf8)
    if let message = String(data: data!, encoding: .nonLossyASCII){
        return message
    }
    return ""
}

func utf8EncodedString()-> String {
    let messageData = self.data(using: .nonLossyASCII)
    let text = String(data: messageData!, encoding: .utf8)
    return text!
}
}
