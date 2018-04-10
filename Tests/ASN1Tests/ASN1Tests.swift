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

class ASN1Tests: TestCase {
    func testIdentifier() {
        let identifier = ASN1.Identifier(rawValue: 0x30)
        assertEqual(identifier?.isConstructed, true)
        assertEqual(identifier?.class, .universal)
        assertEqual(identifier?.tag, .sequence)
    }

    func testEqualityBug() {
        let identifier1 = ASN1.Identifier(
            isConstructed: true,
            class: .contextSpecific,
            tag: .ber)

        let identifier2 = ASN1.Identifier(
            isConstructed: true,
            class: .universal,
            tag: .sequence)

        assertNotEqual(identifier1, identifier2)
    }
}
