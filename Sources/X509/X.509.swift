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
import Time
import Stream

// https://tools.ietf.org/html/rfc5280

public struct X509: Equatable {
    public let certificate: Certificate
    public let algorithm: Algorithm
    public let signature: Signature

    public init(
        certificate: Certificate,
        algorithm: Algorithm,
        signature: Signature)
    {
        self.certificate = certificate
        self.algorithm = algorithm
        self.signature = signature
    }
}

// https://tools.ietf.org/html/rfc5280#section-4.1

extension X509 {
    public init(from asn1: ASN1) throws {
        guard asn1.isConstructed,
            let sequence = asn1.sequenceValue,
            sequence.count == 3
        else {
            throw Error(.invalidX509, asn1)
        }
        self.certificate = try Certificate(from: sequence[0])
        self.algorithm = try Algorithm(from: sequence[1])
        self.signature = try Signature(from: sequence[2])
    }
}
