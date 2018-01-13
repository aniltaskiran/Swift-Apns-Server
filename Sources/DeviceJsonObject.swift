//
//  Device.swift
//  CreateYourOwnApns
//
//  Created by Anıl T. on 12.01.2018.
//

import PerfectLib

class DeviceJsonObject : JSONConvertibleObject {

    static let registerName = "Device"

    var token: String = ""

    init(mToken: String) {
        self.token = mToken
    }

    override public func setJSONValues(_ values: [String : Any]) {
        self.token        = getJSONValue(named: "token", from: values, defaultValue: "")
    }
    override public func getJSONValues() -> [String : Any] {
        return [
            "token":token
        ]
    }
}

