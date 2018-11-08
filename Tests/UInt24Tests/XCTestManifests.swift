import XCTest

extension UInt24Tests {
    static let __allTests = [
        ("testBytesSwapped", testBytesSwapped),
        ("testDescription", testDescription),
        ("testUInt24", testUInt24),
        ("testUInt24Max", testUInt24Max),
        ("testUInt24Overflow", testUInt24Overflow),
    ]
}

#if !os(macOS)
public func __allTests() -> [XCTestCaseEntry] {
    return [
        testCase(UInt24Tests.__allTests),
    ]
}
#endif
