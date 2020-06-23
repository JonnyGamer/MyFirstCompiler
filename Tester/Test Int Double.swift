//
//  Test Int Double.swift
//  MyFirstCompiler
//
//  Created by Jonathan Pappas on 6/23/20.
//

import XCTest

extension TestDoubles {
    
    // Check if all these are of type Double
    func testIfTheseAreTypeDouble() {
        let dub = "Double"
        XCTAssert(resolveType("1.0") == dub)
        XCTAssert(resolveType("1.01") == dub)
        XCTAssert(resolveType("1.00") == dub)
        XCTAssert(resolveType("111.0") == dub)
        XCTAssert(resolveType("-1.0") == dub)
        XCTAssert(resolveType("-11.0") == dub)
        XCTAssert(resolveType("0.0") == dub)
        XCTAssert(resolveType("00.0") == dub)
        XCTAssert(resolveType("00.00") == dub)
        XCTAssert(resolveType("01.0") == dub)
        XCTAssert(resolveType("011.0") == dub)
        XCTAssert(resolveType("-0.0") == dub)
        XCTAssert(resolveType("-01.0") == dub)
    }
    
    // Test if these are not Doubles
    func testIfTheseAreNotDoubles() {
        let i = "Double"
        XCTAssert(resolveType("") != i)
        XCTAssert(resolveType(" ") != i)
        XCTAssert(resolveType("1.") != i)
        XCTAssert(resolveType(".1") != i)
        XCTAssert(resolveType(".") != i)
        XCTAssert(resolveType("1..1") != i)
        XCTAssert(resolveType("1.1.1") != i)
        XCTAssert(resolveType("- 0.0") != i)
        XCTAssert(resolveType("0.0-") != i)
        XCTAssert(resolveType("0.0- ") != i)
        XCTAssert(resolveType("0.-1") != i)
        XCTAssert(resolveType(" 1.0") != i)
        XCTAssert(resolveType("1.0 ") != i)
        XCTAssert(resolveType("ao.0") != i)
        XCTAssert(resolveType("0O.0") != i)
        XCTAssert(resolveType("000000000.") != i)
        XCTAssert(resolveType("1a1") != i)
    }
    
    // Check if the Double Clean method works
    func testDoubleCleaner() {
        // Test for 0s
        XCTAssert(resolveValue("0.0")! == "0.0")
        XCTAssert(resolveValue("0000.0")! == "0.0")
        XCTAssert(resolveValue("0.0000")! == "0.0")
        XCTAssert(resolveValue("0000.0000")! == "0.0")
        XCTAssert(resolveValue("-0.0")! == "0.0")
        // Basic Test
        XCTAssert(resolveValue("1.0")! == "1.0")
        XCTAssert(resolveValue("1.1")! == "1.1")
        XCTAssert(resolveValue("10001.10001")! == "10001.10001")
        // Test for Leading 0s
        XCTAssert(resolveValue("01.0")! == "1.0")
        XCTAssert(resolveValue("00001.0")! == "1.0")
        XCTAssert(resolveValue("000010.0")! == "10.0")
        XCTAssert(resolveValue("-01.0")! == "-1.0")
        XCTAssert(resolveValue("-000000001.0")! == "-1.0")
        // Test for Trailing 0s
        XCTAssert(resolveValue("1.0")! == "1.0")
        XCTAssert(resolveValue("1.0000")! == "1.0")
        XCTAssert(resolveValue("10.0000")! == "10.0")
        XCTAssert(resolveValue("-1.0000")! == "-1.0")
        XCTAssert(resolveValue("1.10")! == "1.1")
        XCTAssert(resolveValue("1.1000")! == "1.1")
        XCTAssert(resolveValue("1.12000")! == "1.12")
        XCTAssert(resolveValue("-1.12000")! == "-1.12")
        XCTAssert(resolveValue("-1.12000100")! == "-1.120001")
        // Test for Leading and Trailing 0s
        XCTAssert(resolveValue("01.00")! == "1.0")
        XCTAssert(resolveValue("00001.0000")! == "1.0")
        XCTAssert(resolveValue("000010.000")! == "10.0")
        XCTAssert(resolveValue("-01.000")! == "-1.0")
        XCTAssert(resolveValue("-000000001.0000")! == "-1.0")
        XCTAssert(resolveValue("-000000001.10000")! == "-1.1")
    }
    
    
    func testForDoubles() {
        let t = "true", f = "false"
        // Check for 0s
        XCTAssert((try? equivocate("0.0", "0.0")) == t)
        XCTAssert((try? equivocate("00.0", "000.0")) == t)
        XCTAssert((try? equivocate("0.00", "0.000")) == t)
        XCTAssert((try? equivocate("00.00", "000.0000")) == t)
        XCTAssert((try? equivocate("0.0", "-0.0")) == t)
        // Check for integers
        XCTAssert((try? equivocate("1.0", "1.0")) == t)
        XCTAssert((try? equivocate("1.0", "2.0")) == f)
        XCTAssert((try? equivocate("-1.0", "1.0")) == f)
        // Negative Integers
        XCTAssert((try? equivocate("-100.0", "-100.0")) == t)
        XCTAssert((try? equivocate("-100.0", "-10.0")) == f)
        // Integers with extra 0s
        XCTAssert((try? equivocate("01.0", "1.0")) == t)
        XCTAssert((try? equivocate("-001.0", "-1.0")) == t)
        XCTAssert((try? equivocate("-001.0", "-00000001.0")) == t)
        XCTAssert((try? equivocate("01.010", "1.01")) == t)
        XCTAssert((try? equivocate("-001.00010", "-1.0001")) == t)
        XCTAssert((try? equivocate("-001.0101000", "-00000001.0101")) == t)
    }
    
}



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

//func testForEqual() {
//    let t = "true", f = "false"
//    // Check for integers
//    XCTAssert((try? equivocate("1", "1")) == t)
//    XCTAssert((try? equivocate("1", "2")) == f)
//
//    // Different Typed Values
//    XCTAssertThrowsError(try equivocate("1", ""))
//    XCTAssertThrowsError(try equivocate("1", "1.0"))
//    XCTAssertThrowsError(try equivocate("", ""))
//}
