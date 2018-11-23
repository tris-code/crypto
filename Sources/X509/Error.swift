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

extension X509 {
    public struct Error: Swift.Error {
        public let reason: Reason
        public let object: ASN1

        init(_ reason: Reason, _ object: ASN1) {
            self.reason = reason
            self.object = object
        }

        public enum Reason {
            case invalidX509
            case invalidCertificate
            case invalidAlgorithm
            case invalidSignature
            case invalidVersion
            case invalidSerialNumber
            case invalidDistinguishedName
            case invalidRelativeDistinguishedName
            case invalidGeneralName
            case invalidEDIPartyName
            case invalidOtherName
            case invalidValidity
            case invalidTime
            case unsupportedAlgorithm
            case invalidPublicKey
            case invalidExtensions
            case invalidExtension
            case invalidBasicConstrains
            case invalidCRLDistributionPoints
            case invalidDistributionPoint
            case invalidDistributionPointName
            case invalidDistributionPointReasons
            case invalidAttributeTypeAndValue
            case invalidRDNSequence
            case invalidDirectoryString
            // unimplemented
            case unimplemented
            case unimplementedAlgorithm
            case unimplementedIdentifierValue
            case unimplementedExtension
        }
    }
}
