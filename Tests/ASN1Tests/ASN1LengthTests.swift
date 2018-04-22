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
