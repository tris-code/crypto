/******************************************************************************
 *                                                                            *
 * Tris Foundation disclaims copyright to this source code.                   *
 * In place of a legal notice, here is a blessing:                            *
 *                                                                            *
 *     May you do good and not evil.                                          *
 *     May you find forgiveness for yourself and forgive others.              *
 *     May you share freely, never taking more than you give.                 *
 *                                                                            *
 ******************************************************************************
 *  This file contains code that has not yet been described                   *
 ******************************************************************************/

import Stream

public struct ASN1: Equatable {
    public var identifier: Identifier
    public var content: Content

    public init(identifier: Identifier, content: Content) {
        self.identifier = identifier
        self.content = content
    }

    public enum Integer: Equatable {
        case sane(Int)
        case insane([UInt8])
    }

    public enum Content: Equatable {
        case boolean(Bool)
        case integer(Integer)
        case string(String)
        case data([UInt8])
        case sequence([ASN1])
    }

    public struct Identifier {
        public var isConstructed: Bool
        public var `class`: Class
        public var tag: Tag

        public init(isConstructed: Bool, class: Class, tag: Tag) {
            self.isConstructed = isConstructed
            self.class = `class`
            self.tag = tag
        }

        public enum Class: UInt8 {
            case universal = 0b00
            case application = 0b01
            case contextSpecific = 0b10
            case `private` = 0b11
        }

        public enum Tag: UInt8 {
            case endOfContent = 0x00
            case boolean = 0x01
            case integer = 0x02
            case bitString = 0x03
            case octetString = 0x04
            case null = 0x05
            case objectIdentifier = 0x06
            case objectDescriptor = 0x07
            case instanceOfExternal = 0x08
            case real = 0x09
            case enumerated = 0x0a
            case embeddedPPV = 0x0b
            case utf8String = 0x0c
            case relativeOID = 0x0d
            // 0x0e & 0x0f undefined
            case sequence = 0x10
            case set = 0x11
            case numericString = 0x12
            case printableString = 0x13
            case teletexString = 0x14
            case videotexString = 0x15
            case ia5String = 0x16
            case utcTime = 0x17
            case generalizedTime = 0x18
            case graphicString = 0x19
            case visibleString = 0x1a
            case generalString = 0x1b
            case universalString = 0x1c
            case characterString = 0x1d
            case bmpString = 0x1e
        }
    }
}

// FIXME: Synthesized Equatable bug
extension ASN1.Identifier: Equatable {
    public static func ==(lhs: ASN1.Identifier, rhs: ASN1.Identifier) -> Bool {
        return lhs.class == rhs.class
            && lhs.tag == rhs.tag
            && lhs.isConstructed == rhs.isConstructed
    }
}
