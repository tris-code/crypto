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

public struct Certificate: Equatable {
    public let tbsCertificate: TBSCertificate
    public let signature: Signature

    public init(
        tbsCertificate: TBSCertificate,
        signature: Signature)
    {
        self.tbsCertificate = tbsCertificate
        self.signature = signature
    }
}

// MARK: Coding - https://tools.ietf.org/html/rfc5280#section-4.1

extension Certificate {
    public init(from asn1: ASN1) throws {
        guard asn1.isConstructed,
            let sequence = asn1.sequenceValue,
            sequence.count == 3
        else {
            throw X509.Error.invalidASN1(asn1, in: .format)
        }
        self.tbsCertificate = try .init(from: sequence[0])
        self.signature = try .init(
            algorithm: .init(from: sequence[1]),
            value: .init(from: sequence[2]))
    }
}
