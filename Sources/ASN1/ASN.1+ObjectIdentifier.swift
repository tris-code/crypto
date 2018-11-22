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

import Stream

extension ASN1 {
    // TODO: restructure?
    public enum ObjectIdentifier: Equatable, Hashable {
        case sha256WithRSAEncryption
        case rsaEncryption
        // MARK: id-at-*
        case attribute(Attribute)
        // MARK: id-ce-*
        case certificateExtension(CertificateExtension)
        // MARK: id-pkix-*
        case pkix(Pkix)
        // MARK: unknown
        case other([UInt8])

        public enum Attribute: Equatable, Hashable {
            case name
            case surname
            case givenName
            case initials
            case generationQualifier
            case commonName
            case localityName
            case stateOrProvinceName
            case organizationName
            case organizationalUnitName
            case title
            case dnQualifier
            case countryName
            case serialNumber
            case pseudonym
        }

        public enum CertificateExtension: Equatable, Hashable {
            case subjectKeyIdentifier
            case keyUsage
            case basicConstrains
            case crlDistributionPoints
            case certificatePolicies
            case authorityKeyIdentifier
            case extKeyUsage
        }

        public enum Pkix: Equatable, Hashable {
            case `extension`(Extension)
            case accessDescription(AccessDescription)

            public enum Extension: Equatable, Hashable {
                case authorityInfoAccessSyntax
            }

            public enum AccessDescription: Equatable, Hashable {
                case oscp(OSCP)
                case caIssuers
                case timeStamping
                case caRepository

                public enum OSCP: Equatable, Hashable {
                    case basicResponse
                    case nonce
                    case crlReference
                    case nocheck
                }
            }
        }
    }

    enum ObjectIdentifierBytes {
        static let sha256WithRSAEncryption: [UInt8] = [
            0x2a, 0x86, 0x48, 0x86, 0xf7, 0x0d, 0x01, 0x01, 0x0b
        ]

        static let rsaEncryption: [UInt8] = [
            0x2a, 0x86, 0x48, 0x86, 0xf7, 0x0d, 0x01, 0x01, 0x01
        ]

        // MARK: id-at-*

        enum Attribute {
            // id-at OBJECT IDENTIFIER ::= { joint-iso-ccitt(2) ds(5) 4 }
            static let prefix: [UInt8] = [0x55, 0x04]
            // Naming attributes of type X520name
            static let name: [UInt8] = prefix + [0x29]
            static let surname: [UInt8] = prefix + [0x04]
            static let givenName: [UInt8] = prefix + [0x2a]
            static let initials: [UInt8] = prefix + [0x2b]
            static let generationQualifier: [UInt8] = prefix + [0x2c]
            // Naming attributes of type X520CommonName
            static let commonName: [UInt8] = prefix + [0x03]
            // Naming attributes of type X520LocalityName
            static let localityName: [UInt8] = prefix + [0x07]
            // Naming attributes of type X520StateOrProvinceName
            static let stateOrProvinceName: [UInt8] = prefix + [0x08]
            // Naming attributes of type X520OrganizationName
            static let organizationName: [UInt8] = prefix + [0x0a]
            // Naming attributes of type X520OrganizationalUnitName
            static let organizationalUnitName: [UInt8] = prefix + [0x0b]
            // Naming attributes of type X520Title
            static let title: [UInt8] = prefix + [0x0c]
            // Naming attributes of type X520dnQualifier
            static let dnQualifier: [UInt8] = prefix + [0x2e]
            // Naming attributes of type X520countryName (digraph from IS 3166)
            static let countryName: [UInt8] = prefix + [0x06]
            // Naming attributes of type X520SerialNumber
            static let serialNumber: [UInt8] = prefix + [0x05]
            // Naming attributes of type X520Pseudonym
            static let pseudonym: [UInt8] = prefix + [0x41]
        }

        // MARK: id-ce-*

        enum CertificateExtension {
            static let prefix: [UInt8] = [0x55, 0x1d]
            static let subjectKeyIdentifier = prefix + [0x0e]
            static let keyUsage = prefix + [0x0f]
            static let basicConstrains = prefix + [0x13]
            static let crlDistributionPoints = prefix + [0x1f]
            static let certificatePolicies = prefix + [0x20]
            static let authorityKeyIdentifier = prefix + [0x23]
            static let extKeyUsage = prefix + [0x25]
        }

        enum Pkix {
            // 1.3.6.1.5.5.7.*
            static let prefix: [UInt8] = [0x2b, 0x06, 0x01, 0x05, 0x05, 0x07]

            enum Extension {
                static let prefix: [UInt8] = Pkix.prefix + [0x01]
                // 1.3.6.1.5.5.7.1.1
                static let authorityInfoAccessSyntax = prefix + [0x01]
            }

            enum AccessDescription {
                // 1.3.6.1.5.5.7.48.*
                static let prefix: [UInt8] = Pkix.prefix + [0x30]

                enum OSCP {
                    // 1.3.6.1.5.5.7.48.1.*
                    static let prefix: [UInt8] = AccessDescription.prefix + [0x01]
                    static let basicResponse = prefix + [0x01]
                    static let nonce = prefix + [0x02]
                    static let crlReference = prefix + [0x03]
                    static let nocheck = prefix + [0x05]
                }

                static let caIssuers: [UInt8] = prefix + [0x02]
                static let timeStamping: [UInt8] = prefix + [0x03]
                static let caRepository: [UInt8] = prefix + [0x05]
            }
        }
    }
}

// TODO: optimize, this is just a stub

public protocol ObjectIdentifierProtocol: RawRepresentable
    where RawValue == [UInt8] {}

// MARK: ObjectIdentifier

extension ASN1.ObjectIdentifier: ObjectIdentifierProtocol {
    typealias Raw = ASN1.ObjectIdentifierBytes

    public var rawValue: [UInt8] {
        switch self {
        case .sha256WithRSAEncryption: return Raw.sha256WithRSAEncryption
        case .rsaEncryption: return Raw.rsaEncryption
        case .attribute(let value): return value.rawValue
        case .certificateExtension(let value): return value.rawValue
        case .pkix(let value): return value.rawValue
        case .other(let value): return value
        }
    }

    public init(rawValue bytes: [UInt8]) {
        switch bytes {
        case Raw.sha256WithRSAEncryption:
            self = .sha256WithRSAEncryption
        case Raw.rsaEncryption:
            self = .rsaEncryption
        case _ where bytes.starts(with: Raw.Attribute.prefix):
            switch Attribute(rawValue: bytes) {
            case .some(let value): self = .attribute(value)
            case .none: self = .other(bytes)
            }
        case _ where bytes.starts(with: Raw.CertificateExtension.prefix):
            switch CertificateExtension(rawValue: bytes) {
            case .some(let value): self = .certificateExtension(value)
            case .none: self = .other(bytes)
            }
        case _ where bytes.starts(with: Raw.Pkix.prefix):
            switch Pkix(rawValue: bytes) {
            case .some(let value): self = .pkix(value)
            case .none: self = .other(bytes)
            }
        default:
            self = .other(bytes)
        }
    }
}

// MARK: ObjectIdentifier.Attribute

extension ASN1.ObjectIdentifier.Attribute: ObjectIdentifierProtocol {
    typealias Raw = ASN1.ObjectIdentifierBytes.Attribute

    public var rawValue: [UInt8] {
        switch self {
        case .name: return Raw.name
        case .surname: return Raw.surname
        case .givenName: return Raw.givenName
        case .initials: return Raw.initials
        case .generationQualifier: return Raw.generationQualifier
        case .commonName: return Raw.commonName
        case .localityName: return Raw.localityName
        case .stateOrProvinceName: return Raw.stateOrProvinceName
        case .organizationName: return Raw.organizationName
        case .organizationalUnitName: return Raw.organizationalUnitName
        case .title: return Raw.title
        case .dnQualifier: return Raw.dnQualifier
        case .countryName: return Raw.countryName
        case .serialNumber: return Raw.serialNumber
        case .pseudonym: return Raw.pseudonym
        }
    }

    public init?(rawValue bytes: [UInt8]) {
        switch bytes {
        case Raw.name: self = .name
        case Raw.surname: self = .surname
        case Raw.givenName: self = .givenName
        case Raw.initials: self = .initials
        case Raw.generationQualifier: self = .generationQualifier
        case Raw.commonName: self = .commonName
        case Raw.localityName: self = .localityName
        case Raw.stateOrProvinceName: self = .stateOrProvinceName
        case Raw.organizationName: self = .organizationName
        case Raw.organizationalUnitName: self = .organizationalUnitName
        case Raw.title: self = .title
        case Raw.dnQualifier: self = .dnQualifier
        case Raw.countryName: self = .countryName
        case Raw.serialNumber: self = .serialNumber
        case Raw.pseudonym: self = .pseudonym
        default: return nil
        }
    }
}

// MARK: ObjectIdentifier.CertificateExtension

extension ASN1.ObjectIdentifier.CertificateExtension: ObjectIdentifierProtocol {
    typealias Raw = ASN1.ObjectIdentifierBytes.CertificateExtension

    public var rawValue: [UInt8] {
        switch self {
        case .subjectKeyIdentifier: return Raw.subjectKeyIdentifier
        case .keyUsage: return Raw.keyUsage
        case .basicConstrains: return Raw.basicConstrains
        case .crlDistributionPoints: return Raw.crlDistributionPoints
        case .certificatePolicies: return Raw.certificatePolicies
        case .authorityKeyIdentifier: return Raw.authorityKeyIdentifier
        case .extKeyUsage: return Raw.extKeyUsage
        }
    }

    public init?(rawValue bytes: [UInt8]) {
        switch bytes {
        case Raw.subjectKeyIdentifier: self = .subjectKeyIdentifier
        case Raw.keyUsage: self = .keyUsage
        case Raw.basicConstrains: self = .basicConstrains
        case Raw.crlDistributionPoints: self = .crlDistributionPoints
        case Raw.certificatePolicies: self = .certificatePolicies
        case Raw.authorityKeyIdentifier: self = .authorityKeyIdentifier
        case Raw.extKeyUsage: self = .extKeyUsage
        default: return nil
        }
    }
}

// MARK: ObjectIdentifier.Pkix

extension ASN1.ObjectIdentifier.Pkix: ObjectIdentifierProtocol {
    typealias Raw = ASN1.ObjectIdentifierBytes.Pkix

    public var rawValue: [UInt8] {
        switch self {
        case .extension(.authorityInfoAccessSyntax):
            return Raw.Extension.authorityInfoAccessSyntax
        case .accessDescription(.oscp(.basicResponse)):
            return Raw.AccessDescription.OSCP.basicResponse
        case .accessDescription(.oscp(.nonce)):
            return Raw.AccessDescription.OSCP.nonce
        case .accessDescription(.oscp(.crlReference)):
            return Raw.AccessDescription.OSCP.crlReference
        case .accessDescription(.oscp(.nocheck)):
            return Raw.AccessDescription.OSCP.nocheck
        case .accessDescription(.caIssuers):
            return Raw.AccessDescription.caIssuers
        case .accessDescription(.timeStamping):
            return Raw.AccessDescription.timeStamping
        case .accessDescription(.caRepository):
            return Raw.AccessDescription.caRepository
        }
    }

    public init?(rawValue bytes: [UInt8]) {
        switch bytes {
        case Raw.Extension.authorityInfoAccessSyntax:
            self = .extension(.authorityInfoAccessSyntax)
        case Raw.AccessDescription.OSCP.basicResponse:
            self = .accessDescription(.oscp(.basicResponse))
        case Raw.AccessDescription.OSCP.nonce:
            self = .accessDescription(.oscp(.nonce))
        case Raw.AccessDescription.OSCP.crlReference:
            self = .accessDescription(.oscp(.crlReference))
        case Raw.AccessDescription.OSCP.nocheck:
            self = .accessDescription(.oscp(.nocheck))
        case Raw.AccessDescription.caIssuers:
            self = .accessDescription(.caIssuers)
        case Raw.AccessDescription.timeStamping:
            self = .accessDescription(.timeStamping)
        case Raw.AccessDescription.caRepository:
            self = .accessDescription(.caRepository)
        default: return nil
        }
    }
}

extension ObjectIdentifierProtocol {
    public var stringValue: String {
        let bytes = rawValue
        guard !bytes.isEmpty else {
            return ""
         }

        var oid: String = "\(bytes[0] / 40).\(bytes[0] % 40)"

        var next = 0
        for byte in bytes[1...] {
            next = (next << 7) | (Int(byte) & 0x7F)
            if (byte & 0x80) == 0 {
                oid.append(".\(next)")
                next = 0
            }
        }

        return oid
    }
}
