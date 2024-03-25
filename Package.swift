// swift-tools-version: 5.10
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "TranslateCore",
    products: [
        .library(name: "TranslateCore", targets: ["TranslateCore"])
    ],
    
    targets: [
        .target(
            name: "TranslateCore",
            dependencies: [],
            path: "Sources/TranslateCore"
        )
    ]
)
