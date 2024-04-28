// swift-tools-version: 5.10

import PackageDescription

let package = Package(
  name: "CalcVariance",
  products: [
    .library(name: "CalcVariance", targets: ["CalcVariance"]),
    .library(name: "Simple", targets: ["CalcVariance", "Simple"]),
  ],
  dependencies: [
    .package(url: "https://github.com/apple/swift-docc-plugin", from: "1.3.0")
  ],
  targets: [
    .target(name: "CalcVariance"),
    .target(name: "Simple"),
    .testTarget(name: "CalcVarianceTests", dependencies: ["CalcVariance"]),
    .testTarget(name: "SimpleTests", dependencies: ["Simple"]),
  ]
)
