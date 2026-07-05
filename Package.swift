// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "ScreenRadarKit",
    platforms: [
        .iOS(.v13)
    ],
    products: [
        .library(
            name: "ScreenRadarKit",
            targets: ["ScreenRadarKit"]
        ),
    ],
    targets: [
        .target(
            name: "ScreenRadarKit",
            dependencies: [],
            path: "Sources/ScreenRadarKit"
        ),
        .testTarget(
            name: "ScreenRadarKitTests",
            dependencies: ["ScreenRadarKit"],
            path: "Tests/ScreenRadarKitTests"
        ),
    ]
)
