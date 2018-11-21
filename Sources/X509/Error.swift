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

extension X509 {
    public enum Error: Swift.Error {
        case invalidX509
        case invalidCertificate
        case invalidAlgorithm
        case unimplementedAlgorithm(String)
        case invalidSignature
        case invalidVersion
        case invalidSerialNumber
        case invalidIdentifier
        case unimplementedIdentifierValue(String)
        case invalidValidity
        case unsupportedAlgorithm
        case invalidPublicKey
        case invalidExtensions
        case invalidExtension(String)
        case unimplementedExtension(String)
    }
}
