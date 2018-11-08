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

import SHA1

extension UUID {
    /// UUID version 5 - sha1(namespace + name)
    public init(namespace: UUID, name: String) {
        let bytes = namespace.bytes + [UInt8](name.utf8)

        var sha1 = SHA1()
        sha1.update(bytes)
        let hash = sha1.final()

        var uuid = unsafeBitCast(hash.bigEndian, to: (UUID, UInt32).self).0
        uuid.version = .v5
        uuid.clock.clearReserved()
        self = uuid
    }
}
