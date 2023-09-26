// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
  name: "advent-of-code",
  platforms: [.macOS(.v14)],
  products: [
    .executable(
      name: "advent-of-code",
      targets: ["advent-of-code"]
    )
  ],
  dependencies: [
    .package(
      url: "https://github.com/apple/swift-collections.git",
      exact: "1.0.4"
    ),
    .package(
      url: "https://github.com/apple/swift-argument-parser.git",
      exact: "1.2.3"
    )
  ],
  targets: [
    .executableTarget(
      name: "advent-of-code",
      dependencies: [
        .product(
          name: "Collections",
          package: "swift-collections"),
        .product(
          name: "ArgumentParser",
          package: "swift-argument-parser"
        )
      ]
    )
  ]
)
