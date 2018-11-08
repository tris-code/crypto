import XCTest

extension UUIDTests {
    static let __allTests = [
        ("testDecodeUUIDString", testDecodeUUIDString),
        ("testEncodeUUIDString", testEncodeUUIDString),
        ("testUUID", testUUID),
    ]
}

#if !os(macOS)
public func __allTests() -> [XCTestCaseEntry] {
    return [
        testCase(UUIDTests.__allTests),
    ]
}
#endif
