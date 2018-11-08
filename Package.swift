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
        .library(name: "Crypto", targets: ["Crypto"])
    ],
    dependencies: [
        .package(
            url: "https://github.com/tris-foundation/stream.git",
            .branch("master")),
        .package(
            url: "https://github.com/tris-foundation/hex.git",
            .branch("master")),
        .package(
            url: "https://github.com/tris-foundation/test.git",
            .branch("master"))
    ],
    targets: [
        .target(name: "SHA1", dependencies: ["Hex"]),
        .target(name: "UUID", dependencies: ["Hex", "SHA1"]),
        .target(name: "Crypto", dependencies: ["Stream"]),
        .testTarget(name: "SHA1Tests", dependencies: ["Test", "SHA1"]),
        .testTarget(name: "ASN1Tests", dependencies: ["Test", "Crypto"]),
        .testTarget(name: "UInt24Tests", dependencies: ["Test", "Crypto"]),
        .testTarget(name: "UUIDTests", dependencies: ["Test", "UUID"]),
    ]
)
