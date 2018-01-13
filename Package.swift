import PackageDescription

let package = Package(
	name: "CreateYourOwnApns",
	dependencies: [
        .Package(url: "https://github.com/PerfectlySoft/Perfect-HTTPServer.git", majorVersion: 2),
        .Package(url:"https://github.com/PerfectlySoft/Perfect-MySQL.git", majorVersion: 2),
            .Package(url:"https://github.com/PerfectlySoft/Perfect-Notifications.git", majorVersion: 2, minor: 1),
            .Package(url:"https://github.com/PerfectlySoft/Perfect-Repeater.git", majorVersion: 1)

    ]
)
	
