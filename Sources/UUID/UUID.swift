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

// https://tools.ietf.org/html/rfc4122

//    0                   1                   2                   3
//     0 1 2 3 4 5 6 7 8 9 0 1 2 3 4 5 6 7 8 9 0 1 2 3 4 5 6 7 8 9 0 1
//    +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
//    |                          time_low                             |
//    +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
//    |       time_mid                |         time_hi_and_version   |
//    +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
//    |clk_seq_hi_res |  clk_seq_low  |         node (0-1)            |
//    +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
//    |                         node (2-5)                            |
//    +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+

public struct UUID {
    public internal(set) var time: Time
    public internal(set) var clock: Clock
    public internal(set) var node: Node

    public internal(set) var version: Version {
        get { return time.version }
        set { time.version = newValue }
    }

    public enum Version {
        case v1, v2, v3, v4, v5
        case unknown
    }

    public struct Time {
        var low: UInt32
        var mid: UInt16
        var hiVersion: UInt16

        public var value: UInt64 {
            // clear 4 bits used by version
            return UInt64(hiCurrentEndian) << 48
                | UInt64(mid.bigEndian) << 32
                | UInt64(low.bigEndian)
        }

        public init(_ value: UInt64) {
            low = UInt32(truncatingIfNeeded: value).bigEndian
            mid = UInt16(truncatingIfNeeded: value >> 32).bigEndian
            hiVersion = UInt16(truncatingIfNeeded: value >> 48).bigEndian
            hiVersion &= ~(0b1111 << 12)
        }

        internal init(low: UInt32, mid: UInt16, hiVersion: UInt16) {
            self.low = low.bigEndian
            self.mid = mid.bigEndian
            self.hiVersion = hiVersion.bigEndian
        }

        internal var hiCurrentEndian: UInt16 {
            return hiVersion.bigEndian & ~(0b1111 << 12)
        }

        internal var version: Version {
            get {
                return Version(rawValue: UInt8(hiVersion.bigEndian >> 12))
            }
            set {
                // the version in the most significant 4 bits
                let newValue = UInt16(newValue.rawValue) << 12
                hiVersion = (hiCurrentEndian | newValue).bigEndian
            }
        }
    }

    public struct Clock {
        var _value: UInt16

        init(_ value: UInt16) {
            // most significant 2 bits are reserved
            _value = (value | 0b1000_0000).bigEndian
        }

        var isValid: Bool {
            return _value >> 6 == 0b10
        }

        public internal(set) var value: UInt16 {
            get { return _value.bigEndian & 0b0011_1111 }
            set { _value = (value | 0b1000_0000).bigEndian }
        }
    }

    public struct Node {
        public let bytes: (UInt8, UInt8, UInt8, UInt8, UInt8, UInt8)

        public init(_ bytes: (UInt8, UInt8, UInt8, UInt8, UInt8, UInt8)) {
            self.bytes = bytes
        }

        public init(_ value: UInt64) {
            self.bytes = (
                UInt8(truncatingIfNeeded: value >> 40),
                UInt8(truncatingIfNeeded: value >> 32),
                UInt8(truncatingIfNeeded: value >> 24),
                UInt8(truncatingIfNeeded: value >> 16),
                UInt8(truncatingIfNeeded: value >> 8),
                UInt8(truncatingIfNeeded: value >> 0))
        }
    }
}

extension UUID.Version {
    var rawValue: UInt8 {
        switch self {
        case .v1: return 1
        case .v2: return 2
        case .v3: return 3
        case .v4: return 4
        case .v5: return 5
        case .unknown: return 0
        }
    }

    init(rawValue: UInt8) {
        switch rawValue {
        case 1: self = .v1
        case 2: self = .v2
        case 3: self = .v3
        case 4: self = .v4
        case 5: self = .v5
        default: self = .unknown
        }
    }
}

extension UUID: RawRepresentable {
    public typealias RawValue = (UInt64, UInt64)

    public init?(rawValue: RawValue) {
        let uuid = unsafeBitCast(rawValue, to: UUID.self)
        guard uuid.clock.isValid else {
            return nil
        }
        self = uuid
    }

    public var rawValue: RawValue {
        return unsafeBitCast(self, to: RawValue.self)
    }
}

extension UUID: Equatable {
    public static func == (lhs: UUID, rhs: UUID) -> Bool {
        return lhs.rawValue == rhs.rawValue
    }
}
