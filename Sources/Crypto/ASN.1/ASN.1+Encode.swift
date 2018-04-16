/*
 * Copyright 2017 Tris Foundation and the project authors
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License
 *
 * See LICENSE.txt in the project root for license information
 * See CONTRIBUTORS.txt for the list of the project authors
 */

import Stream

extension ASN1 {
    public func encode(to stream: StreamWriter) throws {
        let writer = Writer(to: stream)
        try writer.write(self)
    }
}

extension ASN1.Identifier {
    func encode(to stream: StreamWriter) throws {
        var rawTag = tag.rawValue | (`class`.rawValue << 6)
        if isConstructed {
            rawTag |= 0x20
        }
        try stream.write(UInt8(rawTag))
    }
}

extension ASN1 {
    public class Writer {
        let stream: StreamWriter

        public init(to stream: StreamWriter) {
            self.stream = stream
        }

        public enum Error: Swift.Error {
            case invalidLength
            case invalidIdentifier
        }

        func write(_ asn1: ASN1) throws {
            try asn1.identifier.encode(to: stream)

            switch asn1.content {
            case .integer(let value) where
                asn1.identifier.tag == .integer ||
                asn1.identifier.tag == .enumerated:
                try write(value)
            case .string(let value) where
                    asn1.identifier.tag == .printableString ||
                    asn1.identifier.tag == .utf8String:
                try write(value)
            case .data(let value) where
                asn1.identifier.tag == .objectIdentifier ||
                asn1.identifier.tag == .octetString:
                try write(value)
            case .sequence(let value) where asn1.identifier.isConstructed:
                try write(value)
            default:
                throw Error.invalidIdentifier
            }
        }

        func write(_ values: [ASN1]) throws {
            try stream.withSubStream(sizedBy: Length.self) { stream in
                for value in values {
                    try value.encode(to: stream)
                }
            }
        }

        func write(_ value: Integer) throws {
            switch value {
            case .sane(let value):
                switch value {
                case 0...0xFF:
                    try stream.write(UInt8(1))
                    try stream.write(UInt8(value))
                case 0x01_00...0xFF_FF:
                    try stream.write(UInt8(2))
                    try stream.write(UInt16(value))
                case 0x0001_0000...0x00FF_FFFF:
                    try stream.write(UInt8(3))
                    try stream.write(UInt24(value))
                case 0x0100_0000...0xFFFF_FFFF:
                    try stream.write(UInt8(4))
                    try stream.write(UInt32(value))
                default:
                    try stream.write(UInt8(8))
                    try stream.write(UInt64(value))
                }
            case .insane(let bytes):
                let length = Length(bytes.count)
                try length.encode(to: stream)
                try stream.write(bytes)
            }
        }

        func write(_ bytes: [UInt8]) throws {
            let length = Length(bytes.count)
            try length.encode(to: stream)
            try stream.write(bytes)
        }

        func write(_ string: String) throws {
            try write([UInt8](string.utf8))
        }
    }
}
