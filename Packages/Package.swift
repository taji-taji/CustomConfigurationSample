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

var swiftSettings: [SwiftSetting] = []

switch configuration {
case .debug:
    swiftSettings.append(.define("DEBUG"))
case .adhoc:
    swiftSettings.append(.define("AD_HOC"))
case .release:
    swiftSettings.append(.define("RELEASE"))
}

let package = Package(
    name: "Packages",
    platforms: [
        .iOS(.v14),
    ],
    products: [
        // Products define the executables and libraries a package produces, and make them visible to other packages.
        .library(
            name: "AppFeature",
            targets: ["AppFeature"]),
    ],
    dependencies: [
        // Dependencies declare other packages that this package depends on.
        // .package(url: /* package url */, from: "1.0.0"),
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages this package depends on.
        .target(
            name: "AppFeature",
            dependencies: [],
            swiftSettings: swiftSettings),
    ]
)

enum Configuration: String {
    case debug = "DEBUG"
    case release = "RELEASE"
    case adhoc = "AD_HOC"
}
