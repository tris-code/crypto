/*
 * Copyright 2017 Tris Foundation and the project authors
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License
 *
 * See LICENSE.txt in the project root for license information
 * See CONTRIBUTORS.txt for the list of the project authors
 */

import Test
import Stream
@testable import Crypto

class ASN1LengthTests: TestCase {
    func testReadLength1Octet() {
        scope {
            let length = try ASN1.Length(from: InputByteStream([0x81, 0x01]))
            assertEqual(length.value, 1)
        }
    }

    func testReadLength2Octets() {
        scope {
            let length = try ASN1.Length(
                from: InputByteStream([0x82, 0x00, 0x01]))
            assertEqual(length.value, 1)
        }
    }

    func testReadLength4Octets() {
        scope {
            let length = try ASN1.Length(
                from: InputByteStream([0x84, 0x00, 0x00, 0x00, 0x01]))
            assertEqual(length.value, 1)
        }
    }
}
