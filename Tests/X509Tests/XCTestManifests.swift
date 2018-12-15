#if !canImport(ObjectiveC)
import XCTest

extension CertificateDecodeTests {
    // DO NOT MODIFY: This is autogenerated, use: 
    //   `swift test --generate-linuxmain`
    // to regenerate.
    static let __allTests__CertificateDecodeTests = [
        ("testAlgorithmIdentifier", testAlgorithmIdentifier),
        ("testAttributeTypeAndValue", testAttributeTypeAndValue),
        ("testDirectoryString", testDirectoryString),
        ("testName", testName),
        ("testOtherName", testOtherName),
        ("testSerialNumber", testSerialNumber),
        ("testSubjectPublicKeyInfo", testSubjectPublicKeyInfo),
        ("testTime", testTime),
        ("testValidity", testValidity),
        ("testVersion", testVersion),
    ]
}

extension ExtensionDecodeTests {
    // DO NOT MODIFY: This is autogenerated, use: 
    //   `swift test --generate-linuxmain`
    // to regenerate.
    static let __allTests__ExtensionDecodeTests = [
        ("testAuthorityKeyIdentifier", testAuthorityKeyIdentifier),
        ("testAuthorityKeyIdentifierExtension", testAuthorityKeyIdentifierExtension),
        ("testCertificatePoliciesExtension", testCertificatePoliciesExtension),
        ("testCertificateType", testCertificateType),
        ("testExtKeyUsage", testExtKeyUsage),
        ("testKeyUsage", testKeyUsage),
        ("testKeyUsageExtension", testKeyUsageExtension),
        ("testReasons", testReasons),
        ("testSubjectAltNames", testSubjectAltNames),
    ]
}

public func __allTests() -> [XCTestCaseEntry] {
    return [
        testCase(CertificateDecodeTests.__allTests__CertificateDecodeTests),
        testCase(ExtensionDecodeTests.__allTests__ExtensionDecodeTests),
    ]
}
#endif
