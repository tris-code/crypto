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

public enum Name: Equatable {
    case rdnSequence(RDNSequence)
}

// https://tools.ietf.org/html/rfc5280#section-4.1.2.4

extension Name {
    // Name ::= CHOICE { -- only one possibility for now --
    //   rdnSequence  RDNSequence }
    public init(from asn1: ASN1) throws {
        guard asn1.tag == .sequence else {
            throw Error.invalidASN1(asn1)
        }
        self = .rdnSequence(try RDNSequence(from: asn1))
    }
}
