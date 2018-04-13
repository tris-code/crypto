import XCTest

extension SHA1Tests {
    static let __allTests = [
        ("testSHA1", testSHA1),
        ("testSHA1Array", testSHA1Array),
        ("testSHA1ArrayExtension", testSHA1ArrayExtension),
        ("testSHA1String", testSHA1String),
    ]
}

#if !os(macOS)
public func __allTests() -> [XCTestCaseEntry] {
    return [
        testCase(SHA1Tests.__allTests),
    ]
}
#endif
