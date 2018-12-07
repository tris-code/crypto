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

public struct OtherName: Equatable {
    let type: ASN1.ObjectIdentifier
    let value: ASN1
}

// https://tools.ietf.org/html/rfc5280#section-4.2.1.6

extension OtherName {
    // OtherName ::= SEQUENCE {
    //   type-id    OBJECT IDENTIFIER,
    //   value      [0] EXPLICIT ANY DEFINED BY type-id }
    public init(from asn1: ASN1) throws {
        guard let sequence = asn1.sequenceValue,
            sequence.count == 2,
            let type = sequence[0].objectIdentifierValue else
        {
            throw X509.Error.invalidASN1(asn1, in: .otherName(.format))
        }
        self.type = type
        self.value = sequence[1]
    }
}

// MARK: Error

extension OtherName {
    public enum Error {
        public enum Origin {
            case format
        }
    }
}
