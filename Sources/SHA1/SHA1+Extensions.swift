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

import Hex

extension SHA1.Hash {
    public var bigEndian: SHA1.Hash {
        return .init(
            a: a.bigEndian,
            b: b.bigEndian,
            c: c.bigEndian,
            d: d.bigEndian,
            e: e.bigEndian)
    }
}

extension Array where Element == UInt8 {
    public init(_ hash: SHA1.Hash) {
        var hash = hash.bigEndian
        self = [UInt8](UnsafeRawBufferPointer(start: &hash, count: 20))
    }

    public func sha1() -> [UInt8] {
        var sha1 = SHA1()
        sha1.update(self)
        let hash = sha1.final()
        return [UInt8](hash)
    }
}

extension String {
    public init(_ hash: SHA1.Hash) {
        var hash = hash.bigEndian
        self = withUnsafeBytes(of: &hash) { buffer in
            return String(encodingToHex: buffer)
        }
    }
}
