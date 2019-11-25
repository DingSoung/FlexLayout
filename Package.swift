// swift-tools-version:5.0.0

import PackageDescription

let package = Package(
    name: "FlexLayout",
    platforms: [
        .iOS(.v8)
    ],
    products: [
        .library(name: "FlexLayout", targets: ["FlexLayout"])
    ],
    dependencies: [
        .package(url: "https://github.com/DingSoung/Extension", from: "0.9.2")
    ],
    targets: [
        .target(name: "FlexLayout", 
            dependencies: ["Extension"],
            path: "Sources", 
            publicHeadersPath: "../Sources")
    ],
    swiftLanguageVersions: [
        .version("5")
    ]
)
