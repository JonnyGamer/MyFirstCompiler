//
//  Test.swift
//  Test
//
//  Created by Jonathan Pappas on 6/23/20.
//

import XCTest
    
class TestInt: XCTestCase {}
class TestDoubles: XCTestCase {}
class TestStrangeTypes: XCTestCase {}
class TestLetValues: XCTestCase {}
class TestVarValues: XCTestCase {}
class TestRefValues: XCTestCase {}

extension XCTestCase {
    open override func tearDown() { pointers.removeAll() }
}



class TestAnyValues: XCTestCase {}
extension TestAnyValues {
    
    func testAnyFunnyInference() {
        XCTAssertNoThrow(try runLine("any aa Int = 0.0"))
        XCTAssert(resolveValue("aa") == "0.0")
        XCTAssertNoThrow(try runLine("aa = 0"))
        XCTAssert(resolveValue("aa") == "0")
    }
    
    func testAny() {
        XCTAssertNoThrow(try runLine("any a Int = 0"))
        XCTAssert(pointers["a"]?.any == true)
        XCTAssert(pointers["a"]?.const == false)
        XCTAssert(pointers["a"]?.ref == true)
        XCTAssert(resolveType("a") == "Int")
        
        XCTAssertNoThrow(try runLine("a = 0.0"))
        XCTAssert(resolveType("a") == "Double")
        
        XCTAssertNoThrow(try runLine("any b = Int"))
        XCTAssertNoThrow(try runLine("a = b"))
        XCTAssert(resolveType("a") == "Type")
        XCTAssertNoThrow(try runLine("b = 2"))
        XCTAssert(resolveType("a") == "Int")
    }
    
    
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
