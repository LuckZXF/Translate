// swift-tools-version: 5.10
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Translate",
    products: [
        .library(name: "Translate", targets: ["TranslateCore"])
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
            name: "TranslateCore"
        )
    ]
)
