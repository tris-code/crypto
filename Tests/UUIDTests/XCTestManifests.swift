import XCTest

extension UUIDTests {
    static let __allTests = [
        ("testDecodeUUIDString", testDecodeUUIDString),
        ("testEncodeUUIDString", testEncodeUUIDString),
        ("testNamespace", testNamespace),
        ("testUUID", testUUID),
        ("testUUIDv5", testUUIDv5),
    ]
}

#if !os(macOS)
public func __allTests() -> [XCTestCaseEntry] {
    return [
        testCase(UUIDTests.__allTests),
    ]
}
#endif
