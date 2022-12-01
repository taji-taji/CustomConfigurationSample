// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let configuration: Configuration = {
    guard let environmentVariable = Context.environment["BUILD_CONFIGURATION"] else {
        fatalError("BUILD_CONFIGURATION is required.")
    }
    guard let configuration = Configuration(rawValue: environmentVariable) else {
        fatalError("invalid BUIlD_CONFIGURATION: \(environmentVariable)")
    }
    return configuration
}()

let package = Package(
    name: "Packages",
    platforms: [
        .iOS(.v14),
    ],
    products: [
        .library(
            name: "AppFeature",
            targets: ["AppFeature"]),
    ],
    dependencies: [
    ],
    targets: [
        .target(
            name: "AppFeature",
            dependencies: [],
            swiftSettings: [
                configuration.swiftSetting
            ]),
    ]
)

enum Configuration: String {
    case debug = "DEBUG"
    case release = "RELEASE"
    case adhoc = "AD_HOC"
    
    var swiftSetting: SwiftSetting {
        .define(self.rawValue)
    }
}
