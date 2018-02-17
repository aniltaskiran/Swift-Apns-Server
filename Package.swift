//import PackageDescription
//
//let package = Package(
//    name: "CreateYourOwnApns",
//    dependencies: [
//        .Package(url: "https://github.com/PerfectlySoft/Perfect-HTTPServer.git", majorVersion: 2),
//        .Package(url:"https://github.com/PerfectlySoft/Perfect-MySQL.git", majorVersion: 2),
//        .Package(url:"https://github.com/PerfectlySoft/Perfect-Notifications.git", majorVersion: 2, minor: 1),
//            .Package(url: "https://github.com/PerfectlySoft/PerfectLib.git", majorVersion: 2, minor: 0),
//        .Package(url: "https://github.com/PerfectlySoft/Perfect-CURL.git", majorVersion: 2, minor: 0),
//        .Package(url: "https://github.com/PerfectlySoft/Perfect-libcurl.git", majorVersion: 2, minor: 0)
//    ]
//)

import PackageDescription

let package = Package(
    name: "CreateYourOwnApns",
    dependencies: [
        .Package(url: "https://github.com/PerfectlySoft/Perfect-HTTPServer.git", majorVersion: 2),
//        .Package(url:"https://github.com/PerfectlySoft/Perfect-Notifications.git", majorVersion: 2, minor: 1)
    ]
)
