//
//  Test.swift
//  Test
//
//  Created by Jonathan Pappas on 6/23/20.
//

import XCTest
    
class TestInt: XCTestCase {}
class TestDoubles: XCTestCase {}
class TestLetValues: XCTestCase {}
class TestStrangeTypes: XCTestCase {}
class TestVarValues: XCTestCase {}
class TestRefValues: XCTestCase {}

extension XCTestCase {
    open override func tearDown() { pointers.removeAll() }
}





//func testPrintFunction() {
//    XCTAssertThrowsError(try runLine("print()"))
//    XCTAssertThrowsError(try runLine("print( )"))
//    XCTAssertThrowsError(try runLine("print(  )"))
//
//    XCTAssertNoThrow(try runLine("print(5)"))
//    XCTAssertNoThrow(try runLine("print(500)"))
//    XCTAssertNoThrow(try runLine("print(-5)"))
//    XCTAssertNoThrow(try runLine("print(-500)"))
//}

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
