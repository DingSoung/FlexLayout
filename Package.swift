// swift-tools-version:5.4

import PackageDescription

let package = Package(
    name: "FlexLayout",
    platforms: [
       	.macOS(.v10_10),
        .iOS(.v9),
        .tvOS(.v9),
        .watchOS(.v2)
    ],
    products: [
        .library(
            name: "FlexLayout",
            targets: ["FlexLayout"]
        )
    ],
    dependencies: [
        .package(url: "https://github.com/DingSoung/Extension", .branch("master")),
        .package(url: "https://github.com/DingSoung/YogaKit", .branch("master"))
    ],
    targets: [
        .target(
            name: "FlexLayout",
            dependencies: [
                "Extension",
                "YogaKit"
            ],
            path: "Sources"
        )
    ],
    swiftLanguageVersions: [
        .version("5")
    ],
    cLanguageStandard: .gnu11,
    cxxLanguageStandard: .gnucxx14
)
