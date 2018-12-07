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

import ASN1
import Stream

public enum Version: UInt8, Equatable {
    case v3 = 0x02
}

extension Version {
    public init(from asn1: ASN1) throws {
        guard let sequence = asn1.sequenceValue,
            sequence.count == 1,
            let value = sequence[0].integerValue,
            let rawVersion = UInt8(exactly: value),
            let version = Version(rawValue: rawVersion) else
        {
            throw Error.invalidASN1(asn1)
        }
        self = version
    }
}
