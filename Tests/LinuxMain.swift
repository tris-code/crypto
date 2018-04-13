import XCTest

import ASN1Tests
import CryptoTests

var tests = [XCTestCaseEntry]()
tests += ASN1Tests.__allTests()
tests += CryptoTests.__allTests()

XCTMain(tests)
