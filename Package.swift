// swift-tools-version:4.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "SwiftServer",
    products: [
        .library(name: "SwiftServer", targets: ["SwiftServer"]),
        ],
    dependencies: [
        .package(url: "https://github.com/PerfectlySoft/Perfect-HTTPServer.git", .upToNextMinor(from: "3.0.0")),
        .package(url:"https://github.com/PerfectlySoft/Perfect-Notifications.git", .upToNextMinor(from: "3.0.0")),
        .package(url:"https://github.com/PerfectlySoft/Perfect-MySQL.git", .upToNextMinor(from: "3.0.0"))

        ],
    targets: [
        .target(
            name: "SwiftServer",
            dependencies: ["PerfectHTTPServer","PerfectNotifications","PerfectMySQL"],
            path: "Sources")
        ]
)
