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

extension Extension {
    public struct KeyIdentifier: RawRepresentable, Equatable {
        public var rawValue: [UInt8]

        public init(rawValue: [UInt8]) {
            self.rawValue = rawValue
        }
    }
}

// MARK: Coding - https://tools.ietf.org/html/rfc5280#section-4.2.1.9

extension Extension.KeyIdentifier {
    // KeyIdentifier ::= OCTET STRING
    public init(from asn1: ASN1) throws {
        guard let bytes = asn1.dataValue else {
            throw Error.invalidASN1(asn1)
        }
        self.rawValue = bytes
    }
}
