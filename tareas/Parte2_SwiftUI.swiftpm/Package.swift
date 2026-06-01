// swift-tools-version: 5.7

import PackageDescription
import AppleProductTypes

let package = Package(
    name: "Parte2_SwiftUI",
    platforms: [
        .iOS("16.0")
    ],
    products: [
        .iOSApplication(
            name: "Parte2_SwiftUI",
            targets: ["AppModule"],
            bundleIdentifier: "com.curso.parte2",
            teamIdentifier: "",
            displayVersion: "1.0",
            bundleVersion: "1",
            appIcon: .placeholder(icon: .gamepad),
            accentColor: .presetColor(.orange),
            supportedDeviceFamilies: [
                .pad,
                .phone
            ],
            supportedInterfaceOrientations: [
                .portrait,
                .landscapeRight,
                .landscapeLeft,
                .portraitUpsideDown(.when(deviceFamilies: [.pad]))
            ]
        )
    ],
    targets: [
        .executableTarget(
            name: "AppModule",
            path: "."
        )
    ]
)
