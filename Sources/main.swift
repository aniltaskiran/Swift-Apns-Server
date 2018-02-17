import PerfectLib
import PerfectHTTP
import PerfectHTTPServer
import Foundation
import PerfectNotifications


// your app id. we use this as the configuration name, but they do not have to match

let notificationsAppId = SECRET_NOTIFICATIONS_APP_ID
let apnsKeyIdentifier = SECRET_APNS_KEY_IDENTIFIER
let apnsTeamIdentifier = SECRET_TEAM_IDENTIFIER
let apnsPrivateKey = SECRET_APNS_PRIVATE_KEY



NotificationPusher.addConfigurationAPNS(
    name: notificationsAppId,
    production: false, // should be false when running pre-release app in debugger, must be on device (emulator does not work)
    keyId: apnsKeyIdentifier,
    teamId: apnsTeamIdentifier,
    privateKeyPath: apnsPrivateKey)

let port = 8181

let confData = [
    "servers": [
        // Configuration data for one server which:
        //    * Serves the hello world message at <host>:<port>/
        //    * Serves static files out of the "./webroot"
        //        directory (which must be located in the current working directory).
        //    * Performs content compression on outgoing data when appropriate.
        [
            "name":"localhost",
            "port":port,
            "routes":[
                ["method":"post", "uri":"/notify", "handler":notificationHandler],
                ["method":"post", "uri":"/api/v1/repeatFunc", "handler":repeatFuncHandler],
                ["method":"post", "uri":"/api/v1/postDevice/json", "handler":registrationHandler],
                ["method":"post", "uri":"/api/v1/notifyAll", "handler":notifyAllHandler],
                ["method":"get", "uri":"/**", "handler":PerfectHTTPServer.HTTPHandler.staticFiles,
                 "documentRoot":"/home/" + SECRET_USER + "/Swift-Apns-Server/webroot",
                 "allowResponseFilters":true]
            ],
            "filters":[
                [
                    "type":"response",
                    "priority":"high",
                    "name":PerfectHTTPServer.HTTPFilter.contentCompression,
                    ]
            ]
        ],
    ]
]

do {
    // Launch the servers based on the configuration data.
    try HTTPServer.launch(configurationData: confData)
} catch {
    fatalError("\(error)") // fatal error launching one of the servers
}



