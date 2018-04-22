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

import Test
import Stream
@testable import Crypto

class ASN1Tests: TestCase {
    func testEqualityBug() {
        let identifier1 = ASN1.Identifier(
            isConstructed: true,
            class: .contextSpecific,
            tag: .endOfContent)

        let identifier2 = ASN1.Identifier(
            isConstructed: true,
            class: .universal,
            tag: .sequence)

        assertNotEqual(identifier1, identifier2)
    }
}
