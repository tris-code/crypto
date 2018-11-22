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
import Time

public typealias TrisTime = Time

extension Certificate {
    public enum Time: Equatable {
        case utc(TrisTime)
        case generalized(TrisTime)
    }
}

// https://tools.ietf.org/html/rfc5280#section-4.1

extension Certificate.Time {
    // Time ::= CHOICE {
    //   utcTime        UTCTime,
    //   generalTime    GeneralizedTime }
    public init(from asn1: ASN1) throws {
        guard let bytes = asn1.dataValue,
            let time = Time(validity: bytes) else
        {
            throw X509.Error(.invalidTime, asn1)
        }
        switch asn1.tag {
            case .utcTime: self = .utc(time)
            case .generalizedTime: self = .generalized(time)
            default: throw X509.Error(.invalidTime, asn1)
        }
    }
}

// MARK: Utils

extension Time {
    init?(validity: [UInt8]) {
        let string = String(decoding: validity, as: UTF8.self)
        self.init(string, format: "%d%m%y%H%M%S")
    }
}
