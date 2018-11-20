// swift-tools-version:4.2
/******************************************************************************
 *                                                                            *
 * Tris Foundation disclaims copyright to this source code.                   *
 * In place of a legal notice, here is a blessing:                            *
 *                                                                            *
 *     May you do good and not evil.                                          *
 *     May you find forgiveness for yourself and forgive others.              *
 *     May you share freely, never taking more than you give.                 *
 *                                                                            *
 ******************************************************************************/

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
            url: "https://github.com/tris-foundation/stream.git",
            .branch("master")),
        .package(
            url: "https://github.com/tris-foundation/radix.git",
            .branch("master")),
        .package(
            url: "https://github.com/tris-foundation/time.git",
            .branch("master")),
        .package(
            url: "https://github.com/tris-foundation/test.git",
            .branch("master"))
    ],
    targets: [
        .target(name: "UInt24"),
        .target(name: "SHA1", dependencies: ["Hex"]),
        .target(name: "UUID", dependencies: ["Hex", "SHA1"]),
        .target(name: "ASN1", dependencies: ["UInt24", "Stream"]),
        .target(name: "X509", dependencies: ["ASN1", "Stream", "Time"]),
        .target(name: "Crypto", dependencies: ["SHA1", "UUID", "ASN1", "X509"]),
        .testTarget(name: "SHA1Tests", dependencies: ["Test", "SHA1"]),
        .testTarget(name: "UUIDTests", dependencies: ["Test", "UUID"]),
        .testTarget(name: "ASN1Tests", dependencies: ["Test", "ASN1"]),
        .testTarget(name: "X509Tests", dependencies: ["Test", "X509"]),
        .testTarget(name: "UInt24Tests", dependencies: ["Test", "UInt24"]),
    ]
)
