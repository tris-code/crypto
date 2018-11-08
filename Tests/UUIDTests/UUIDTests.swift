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
@testable import UUID

final class UUIDTests: TestCase {
    func testUUID() {
        let uuid = UUID()
        assertNotNil(uuid)
    }

    func testEncodeUUIDString() {
        let uuid = UUID()
        let uuidString = uuid.uuidString
        assertEqual(uuidString.count, 36)
        let parts = uuidString.split(separator: "-")
        assertEqual(parts.count, 5)
        if parts.count == 5 {
            // UUID version
            assertEqual(parts[2].first, "4")
        }
    }

    func testDecodeUUIDString() {
        let uuid = UUID()
        let uuidString = uuid.uuidString
        assertEqual(UUID(uuidString: uuidString), uuid)
    }

    func testNamespace() {
        assertEqual(UUID.dns.uuidString, "6ba7b810-9dad-11d1-80b4-00c04fd430c8")
        assertEqual(UUID.url.uuidString, "6ba7b811-9dad-11d1-80b4-00c04fd430c8")
        assertEqual(UUID.oid.uuidString, "6ba7b812-9dad-11d1-80b4-00c04fd430c8")
        assertEqual(UUID.x500.uuidString,"6ba7b814-9dad-11d1-80b4-00c04fd430c8")
    }

    func testUUIDv5() {
        let uuid = UUID(namespace: .dns, name: "tris.foundaton")
        assertEqual(uuid.uuidString, "2fe823aa-a1fb-52b0-8ba8-4fd99abd8850")
    }
}
