import XCTest

extension ASN1DecodeTests {
    static let __allTests = [
        ("testContentData", testContentData),
        ("testContentEnumerated", testContentEnumerated),
        ("testContentPrintableString", testContentPrintableString),
        ("testContentSequence", testContentSequence),
        ("testContentUTF8String", testContentUTF8String),
        ("testContextSpecificEndOfContent", testContextSpecificEndOfContent),
        ("testUniversalSequence", testUniversalSequence),
    ]
}

extension ASN1EncodeTests {
    static let __allTests = [
        ("testContentData", testContentData),
        ("testContentEnumerated", testContentEnumerated),
        ("testContentPrintableString", testContentPrintableString),
        ("testContentSequence", testContentSequence),
        ("testContentUTF8String", testContentUTF8String),
        ("testContextSpecificEndOfContent", testContextSpecificEndOfContent),
        ("testUniversalSequence", testUniversalSequence),
    ]
}

extension ASN1LengthTests {
    static let __allTests = [
        ("testReadLength1Octet", testReadLength1Octet),
        ("testReadLength2Octets", testReadLength2Octets),
        ("testReadLength4Octets", testReadLength4Octets),
    ]
}

extension ASN1Tests {
    static let __allTests = [
        ("testEqualityBug", testEqualityBug),
    ]
}

#if !os(macOS)
public func __allTests() -> [XCTestCaseEntry] {
    return [
        testCase(ASN1DecodeTests.__allTests),
        testCase(ASN1EncodeTests.__allTests),
        testCase(ASN1LengthTests.__allTests),
        testCase(ASN1Tests.__allTests),
    ]
}
#endif
