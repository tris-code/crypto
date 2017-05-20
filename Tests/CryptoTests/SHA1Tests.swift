/*
 * Copyright 2017 Tris Foundation and the project authors
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License
 *
 * See LICENSE.txt in the project root for license information
 * See CONTRIBUTORS.txt for the list of the project authors
 */

import XCTest
@testable import Crypto

class SHA1Tests: XCTestCase {
    func testSHA1() {
        let bytes = [UInt8]("The quick brown fox jumps over the lazy dog".utf8)
        var sha1 = SHA1()
        sha1.update(bytes)
        let result = sha1.final()
        let expected: SHA1.Hash = (
            0x2fd4e1c6,
            0x7a2d28fc,
            0xed849ee1,
            0xbb76e739,
            0x1b93eb12
        )
        XCTAssertEqual(result.0, expected.0)
        XCTAssertEqual(result.1, expected.1)
        XCTAssertEqual(result.2, expected.2)
        XCTAssertEqual(result.3, expected.3)
        XCTAssertEqual(result.4, expected.4)
    }

    func testSHA1Array() {
        let bytes = [UInt8]("The quick brown fox jumps over the lazy dog".utf8)
        var sha1 = SHA1()
        sha1.update(bytes)
        let hash = sha1.final()
        let result = [UInt8](hash)
        let expected: [UInt8] = [0x2f, 0xd4, 0xe1, 0xc6,
                                 0x7a, 0x2d, 0x28, 0xfc,
                                 0xed, 0x84, 0x9e, 0xe1,
                                 0xbb, 0x76, 0xe7, 0x39,
                                 0x1b, 0x93, 0xeb, 0x12]
        XCTAssertEqual(result, expected)
    }

    func testSHA1String() {
        let bytes = [UInt8]("The quick brown fox jumps over the lazy dog".utf8)
        var sha1 = SHA1()
        sha1.update(bytes)
        let hash = sha1.final()
        let result = String(hash)
        let expected = "2fd4e1c67a2d28fced849ee1bb76e7391b93eb12"
        XCTAssertEqual(result, expected)
    }

    func testSHA1ArrayExtension() {
        let bytes = [UInt8]("The quick brown fox jumps over the lazy dog".utf8)
        let result = bytes.sha1()
        let expected: [UInt8] = [0x2f, 0xd4, 0xe1, 0xc6,
                                 0x7a, 0x2d, 0x28, 0xfc,
                                 0xed, 0x84, 0x9e, 0xe1,
                                 0xbb, 0x76, 0xe7, 0x39,
                                 0x1b, 0x93, 0xeb, 0x12]
        XCTAssertEqual(result, expected)
    }


    static var allTests = [
        ("testSHA1", testSHA1),
        ("testSHA1Array", testSHA1Array),
        ("testSHA1String", testSHA1String),
        ("testSHA1ArrayExtension", testSHA1ArrayExtension),
    ]
}
