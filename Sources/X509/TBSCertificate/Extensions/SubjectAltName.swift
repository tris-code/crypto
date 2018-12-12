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

// MARK: Coding - https://tools.ietf.org/html/rfc5280#section-4.2.1.6

extension Extension {
    // SubjectAltName ::= GeneralNames
    public typealias SubjectAltName = GeneralNames
}
