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

public struct RSA {
    public struct PublicKey: Equatable {
        public let modulus: [UInt8]
        public let exponent: Int
    }
}

public struct DSA { public struct PublicKey: Equatable {} }
public struct ECDSA { public struct PublicKey: Equatable {} }

public enum PublicKey: Equatable {
    case rsa(RSA.PublicKey)
    case dsa(DSA.PublicKey)
    case ecdsa(ECDSA.PublicKey)
}

// MARK: Coding - https://tools.ietf.org/html/rfc5280#section-4.1.2.7

extension RSA.PublicKey {
    public init(from asn1: ASN1) throws {
        guard let keySequence = asn1.sequenceValue,
            keySequence.count == 2,
            let modulus = keySequence[0].insaneIntegerValue,
            let exponent = keySequence[1].integerValue else
        {
            throw Error.invalidASN1(asn1)
        }
        self.modulus = modulus
        self.exponent = exponent
    }
}

extension PublicKey {
    public init(from asn1: ASN1) throws {
        guard let sequence = asn1.sequenceValue,
            sequence.count == 2 else
        {
            throw Error.invalidASN1(asn1)
        }
        let algorithm = try Signature.Algorithm(from: sequence[0])
        guard let bitString = BitString(from: sequence[1]) else {
            throw Error.invalidASN1(asn1)
        }
        let key = try ASN1(from: bitString.bytes)
        self = .rsa(try .init(from: key))
    }
}