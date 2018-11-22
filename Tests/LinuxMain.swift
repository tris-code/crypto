import XCTest

import ASN1Tests
import SHA1Tests
import UInt24Tests
import UUIDTests
import X509Tests

var tests = [XCTestCaseEntry]()
tests += ASN1Tests.__allTests()
tests += SHA1Tests.__allTests()
tests += UInt24Tests.__allTests()
tests += UUIDTests.__allTests()
tests += X509Tests.__allTests()

XCTMain(tests)
