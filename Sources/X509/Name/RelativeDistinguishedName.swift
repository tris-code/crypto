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

public struct RelativeDistinguishedName: Equatable {
    public let components: Set<AttributeTypeAndValue>

    public init(_ components: Set<AttributeTypeAndValue>) {
        self.components = components
    }
}

// https://tools.ietf.org/html/rfc5280#section-4.1.2.4

extension RelativeDistinguishedName {
    // RelativeDistinguishedName ::=
    //   SET SIZE (1..MAX) OF AttributeTypeAndValue
    public init(from asn1: ASN1) throws {
        guard let items = asn1.setValue,
            items.count >= 1 else
        {
            throw X509.Error.invalidASN1(asn1, in: .relativeDistinguishedName(.format))
        }
        var components = Set<AttributeTypeAndValue>()
        for item in items {
            try components.insert(.init(from: item))
        }
        self.components = components
    }
}

// MARK: Error

extension RelativeDistinguishedName {
    public enum Error {
        public enum Origin {
            case format
        }
    }
}
