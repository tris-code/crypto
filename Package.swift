// swift-tools-version:5.0
import PackageDescription

let package = Package(
    name: "Crypto",
    products: [
        .library(name: "SHA1",targets: ["SHA1"]),
        .library(name: "UUID",targets: ["UUID"]),
        .library(name: "ASN1",targets: ["ASN1"]),
        .library(name: "Crypto", targets: ["Crypto"])
    ],
    dependencies: [
        .package(
            url: "https://github.com/tris-code/stream.git",
            .branch("master")),
        .package(
            url: "https://github.com/tris-code/radix.git",
            .branch("master")),
        .package(
            url: "https://github.com/tris-code/time.git",
            .branch("master")),
        .package(
            url: "https://github.com/tris-code/test.git",
            .branch("master"))
    ],
    targets: [
        .target(name: "UInt24"),
        .target(name: "SHA1", dependencies: ["Hex"]),
        .target(name: "UUID", dependencies: ["Hex", "SHA1"]),
        .target(name: "ASN1", dependencies: ["UInt24", "Stream", "Hex"]),
        .target(name: "X509", dependencies: ["ASN1", "Stream", "Time"]),
        .target(name: "Crypto", dependencies: ["SHA1", "UUID", "ASN1", "X509"]),
        .testTarget(name: "SHA1Tests", dependencies: ["Test", "SHA1"]),
        .testTarget(name: "UUIDTests", dependencies: ["Test", "UUID"]),
        .testTarget(name: "ASN1Tests", dependencies: ["Test", "ASN1"]),
        .testTarget(name: "X509Tests", dependencies: ["Test", "X509"]),
        .testTarget(name: "UInt24Tests", dependencies: ["Test", "UInt24"]),
    ]
)
