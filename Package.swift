// swift-tools-version: 5.10
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "TranslateCore",
    products: [
        .library(name: "TranslateCore", targets: ["TranslateCore"])
    ],
    dependencies: [
        .package(
            url: "https://github.com/IngmarStein/CommandLineKit",
            from: "2.3.0"
        )
    ],
    targets: [
        .target(
            name: "Translate",
            dependencies: ["TranslateCore","CommandLineKit"]
        ),
        .target(
            name: "TranslateCore",
            dependencies: [],
            path: "Sources/TranslateCore"
        )
    ]
)
