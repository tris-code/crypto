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

public struct Signature: Equatable {
    public let padding: Int
    public let encrypted: [UInt8]

    public init(padding: Int, encrypted: [UInt8]) {
        self.padding = padding
        self.encrypted = encrypted
    }
}

// https://tools.ietf.org/html/rfc5280#section-4.1.1.3

extension Signature {
    public init(from asn1: ASN1) throws {
        guard let bitString = BitString(from: asn1) else {
            throw X509.Error(.invalidSignature, asn1)
        }
        self.padding = bitString.padding
        self.encrypted = bitString.bytes
    }
}

struct BitString {
    let padding: Int
    let bytes: [UInt8]

    init?(from asn1: ASN1) {
        guard asn1.tag == .bitString,
            let data = asn1.dataValue,
            data.count >= 2 else
        {
            return nil
        }
        self.padding = Int(data[0])
        self.bytes = [UInt8](data[1...])
    }
}
