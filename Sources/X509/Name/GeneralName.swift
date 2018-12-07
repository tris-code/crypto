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

public enum GeneralName: Equatable {
    case otherName(OtherName)
    case rfc822Name(String)
    case dnsName(String)
    case x400Address(ORAddress)
    case directoryName(Name)
    case ediPartyName(EDIPartyName)
    case uniformResourceIdentifier(String)
    case ipAddress([UInt8])
    case registeredId(ASN1.ObjectIdentifier)
}

// https://tools.ietf.org/html/rfc5280#section-4.2.1.6

public typealias GeneralNames = [GeneralName]
// SubjectAltName ::= GeneralNames
public typealias SubjectAltName = GeneralNames
// IssuerAltName ::= GeneralNames
public typealias IssuerAltName = GeneralNames

extension Array where Element == GeneralName {
    // GeneralNames ::= SEQUENCE SIZE (1..MAX) OF GeneralName
    public init(from asn1: ASN1) throws {
        guard let sequence = asn1.sequenceValue,
            sequence.count >= 1 else
        {
            throw X509.Error.invalidASN1(asn1, in: .generalName(.rootSequence))
        }
        self = try sequence.map(GeneralName.init)
    }
}

extension GeneralName {
    public enum Tag: UInt8 {
        case otherName                 = 0
        case rfc822Name                = 1
        case dnsName                   = 2
        case x400Address               = 3
        case directoryName             = 4
        case ediPartyName              = 5
        case uniformResourceIdentifier = 6
        case ipAddress                 = 7
        case registeredId              = 8
    }
    // GeneralName ::= CHOICE {
    //   otherName                       [0]     OtherName,
    //   rfc822Name                      [1]     IA5String,
    //   dNSName                         [2]     IA5String,
    //   x400Address                     [3]     ORAddress,
    //   directoryName                   [4]     Name,
    //   ediPartyName                    [5]     EDIPartyName,
    //   uniformResourceIdentifier       [6]     IA5String,
    //   iPAddress                       [7]     OCTET STRING,
    //   registeredID                    [8]     OBJECT IDENTIFIER }
    public init(from asn1: ASN1) throws {
        guard asn1.class == .contextSpecific,
            let tag = Tag(rawValue: asn1.tag.rawValue) else
        {
            throw X509.Error.invalidASN1(asn1, in: .generalName(.generalName))
        }
        switch tag {
        case .otherName:
            self = .otherName(try .init(from: asn1))
        case .rfc822Name:
            guard let string = asn1.stringValue else {
               throw X509.Error.invalidASN1(asn1, in: .generalName(.rfc822Name))
            }
            self = .rfc822Name(string)
        case .dnsName:
            guard let string = asn1.stringValue else {
                throw X509.Error.invalidASN1(asn1, in: .generalName(.dnsName))
            }
            self = .dnsName(string)
        case .x400Address:
            self = .x400Address(try .init(from: asn1))
        case .directoryName:
            self = .directoryName(try .init(from: asn1))
        case .ediPartyName:
            self = .ediPartyName(try .init(from: asn1))
        case .uniformResourceIdentifier:
            guard let string = asn1.stringIdentifierValue else {
                throw X509.Error.invalidASN1(asn1, in: .generalName(.uniformResourceIdentifier))
            }
            self = .uniformResourceIdentifier(string)
        case .ipAddress:
            guard let bytes = asn1.dataValue else {
               throw X509.Error.invalidASN1(asn1, in: .generalName(.ipAddress))
            }
            self = .ipAddress(bytes)
        case .registeredId:
            guard let bytes = asn1.dataValue else {
               throw X509.Error.invalidASN1(asn1, in: .generalName(.registeredId))
            }
            self = .registeredId(.init(rawValue: bytes))
        }
    }
}

// Error

extension GeneralName {
    public enum Error {
        public enum Origin {
            case rootSequence
            case generalName
            case rfc822Name
            case dnsName
            case uniformResourceIdentifier
            case ipAddress
            case registeredId
        }
    }
}
