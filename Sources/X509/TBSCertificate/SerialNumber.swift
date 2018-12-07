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

extension TBSCertificate {
    public struct SerialNumber: Equatable {
        public let bytes: [UInt8]
    }
}

extension TBSCertificate.SerialNumber {
    public init(from asn1: ASN1) throws {
        guard let bytes = asn1.insaneIntegerValue,
            bytes.count > 0 else
        {
            throw X509.Error(.invalidSerialNumber, asn1)
        }
        self.bytes = bytes
    }
}
