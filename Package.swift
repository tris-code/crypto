// swift-tools-version:4.2
/*
 * Copyright 2017 Tris Foundation and the project authors
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License
 *
 * See LICENSE.txt in the project root for license information
 * See CONTRIBUTORS.txt for the list of the project authors
 */

import PackageDescription

let package = Package(
    name: "Crypto",
    products: [
        .library(name: "Crypto", targets: ["Crypto"])
    ],
    dependencies: [
        .package(
            url: "https://github.com/tris-foundation/stream.git",
            .branch("master")),
        .package(
            url: "https://github.com/tris-foundation/test.git",
            .branch("master"))
    ],
    targets: [
        .target(name: "Crypto", dependencies: ["Stream"]),
        .testTarget(name: "CryptoTests", dependencies: ["Crypto", "Test"]),
        .testTarget(name: "ASN1Tests", dependencies: ["Crypto", "Test"]),
        .testTarget(name: "UInt24Tests", dependencies: ["Test"])
    ]
)
