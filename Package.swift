//  swift-tools-version: 5.7
//
//  Package.swift
//  ActionKit
//
//  Created by david-swift on 19.01.23.
//

import PackageDescription

/// The ActionKit package.
let package = Package(
    name: "ActionKit",
    platforms: [
        .macOS(.v13)
    ],
    products: [
        .library(
            name: "ActionKit",
            targets: ["ActionKit"]
        )
    ],
    dependencies: [
        .package(url: "https://github.com/lukepistrol/SwiftLintPlugin", from: "0.2.2"),
        .package(url: "https://github.com/david-swift/ColibriComponents-macOS", from: "0.1.0")
    ],
    targets: [
        .target(
            name: "ActionKit",
            dependencies: [
                .product(name: "ColibriComponents", package: "ColibriComponents-macOS")
            ],
            plugins: [
                .plugin(name: "SwiftLint", package: "SwiftLintPlugin")
            ]
        ),
        .testTarget(
            name: "ActionKitTests",
            dependencies: ["ActionKit"],
            plugins: [
                .plugin(name: "SwiftLint", package: "SwiftLintPlugin")
            ]
        )
    ]
)
