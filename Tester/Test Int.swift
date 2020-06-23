//
//  Test Int Double.swift
//  MyFirstCompiler
//
//  Created by Jonathan Pappas on 6/23/20.
//

import XCTest

extension TestInt {

    // Check if all these are of type Int
    func testIfTheseAreTypeInt() {
        let int = "Int"
        XCTAssert(resolveType("1") == int)
        XCTAssert(resolveType("111") == int)
        XCTAssert(resolveType("-1") == int)
        XCTAssert(resolveType("-11") == int)
        XCTAssert(resolveType("0") == int)
        XCTAssert(resolveType("00") == int)
        XCTAssert(resolveType("01") == int)
        XCTAssert(resolveType("011") == int)
        XCTAssert(resolveType("-0") == int)
        XCTAssert(resolveType("-01") == int)
    }
    
    // Test if these are not Ints
    func testIfTheseAreNotInts() {
        let int = "Int"
        XCTAssert(resolveType("") != int)
        XCTAssert(resolveType(" ") != int)
        XCTAssert(resolveType("- 0") != int)
        XCTAssert(resolveType("0-") != int)
        XCTAssert(resolveType("0- ") != int)
        XCTAssert(resolveType(" 1") != int)
        XCTAssert(resolveType("--1") != int)
        XCTAssert(resolveType("ao") != int)
        XCTAssert(resolveType("0O") != int)
        XCTAssert(resolveType("000000000.") != int)
        XCTAssert(resolveType("1 ") != int)
        XCTAssert(resolveType("1$") != int)
        XCTAssert(resolveType("^1") != int)
        XCTAssert(resolveType("1.0") != int)
        XCTAssert(resolveType(".") != int)
    }
    
    // Check if the Int Clean method works
    func testIntCleaner() {
        // Test for 0s
        XCTAssert(resolveValue("0")! == "0")
        XCTAssert(resolveValue("0000")! == "0")
        XCTAssert(resolveValue("-0")! == "0")
        // Basic Test
        XCTAssert(resolveValue("1")! == "1")
        XCTAssert(resolveValue("10001")! == "10001")
        // Test for Leading 0s
        XCTAssert(resolveValue("01")! == "1")
        XCTAssert(resolveValue("00001")! == "1")
        XCTAssert(resolveValue("000010")! == "10")
        XCTAssert(resolveValue("-01")! == "-1")
        XCTAssert(resolveValue("-000000001")! == "-1")
    }
    
    func testForIntegers() {
        let t = "true", f = "false"
        // Check for 0s
        XCTAssert((try? equivocate("0", "0")) == t)
        XCTAssert((try? equivocate("00", "000")) == t)
        XCTAssert((try? equivocate("0", "-0")) == t)
        // Check for integers
        XCTAssert((try? equivocate("1", "1")) == t)
        XCTAssert((try? equivocate("1", "2")) == f)
        XCTAssert((try? equivocate("-1", "1")) == f)
        // Negative Integers
        XCTAssert((try? equivocate("-100", "-100")) == t)
        XCTAssert((try? equivocate("-100", "-10")) == f)
        // Integers with leading 0s
        XCTAssert((try? equivocate("01", "1")) == t)
        XCTAssert((try? equivocate("-001", "-1")) == t)
        XCTAssert((try? equivocate("-001", "-00000001")) == t)
    }

}
