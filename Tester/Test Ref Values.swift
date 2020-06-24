//
//  Test Ref Values.swift
//  MyFirstCompiler
//
//  Created by Jonathan Pappas on 6/23/20.
//

import XCTest

extension TestRefValues {
    
    // Immediate Assignment Test
    func testImmediateAssignment() {
        XCTAssertNoThrow(try runLine("var a Int = 0"))
        
        // Double Check with VAR
        XCTAssertNoThrow(try runLine("var b = a"))
        XCTAssert(resolveValue("b") == "0")
        XCTAssertNoThrow(try runLine("a = 1"))
        XCTAssert(resolveValue("b") == "0")
        pointers["b"] = nil
        
        // Double Check with REF
        XCTAssertNoThrow(try runLine("a = 0"))
        XCTAssertNoThrow(try runLine("ref b = a"))
        XCTAssert(pointers["b"]?.ref == true)
        XCTAssert(resolveValue("b") == "0")
        XCTAssertNoThrow(try runLine("a = 1"))
        XCTAssert(resolveValue("b") == "1")
        
        XCTAssertThrowsError(try runLine("ref c Double = a"))
    }
    
    // Testing Ref of Ref of Ref etc.
    func testRefOfRefOfRef() {
        XCTAssertNoThrow(try runLine("var a = 0"))
        XCTAssertNoThrow(try runLine("ref b = a"))
        XCTAssertNoThrow(try runLine("ref c = b"))
        XCTAssertNoThrow(try runLine("ref d = c"))
        XCTAssertNoThrow(try runLine("ref e = d"))
        XCTAssertNoThrow(try runLine("ref f = e"))
        XCTAssertNoThrow(try runLine("ref g = f"))
        XCTAssertNoThrow(try runLine("ref h = g"))
        XCTAssertNoThrow(try runLine("ref i = h"))
        XCTAssertNoThrow(try runLine("ref j = i"))
        XCTAssert(resolveValue("j") == "0")
        XCTAssertNoThrow(try runLine("a = 1"))
        XCTAssert(resolveValue("j") == "1")
    }
    
//    // I should probably not allow this one. DEFINETELY
//    // FIX: You can only assign refs to VARIABLES, and not '0' or smth
//    func testRefofSelf() {
//        XCTAssertNoThrow(try runLine("ref a = 0"))
//        XCTAssertNoThrow(try runLine("ref b = a"))
//        XCTAssertNoThrow(try runLine("ref c = b"))
//        XCTAssertNoThrow(try runLine("a = c"))
//    }
    
    // If I allow this, I have to do something trickier above ^^^^
    func testUndefinedAssignment() {
        XCTAssertNoThrow(try runLine("ref a Int"))
        XCTAssert(pointers["a"]?.const == false)
        XCTAssert(pointers["a"]?.ref == true)
        XCTAssert(pointers["a"]?.type == "Int")
        XCTAssert(pointers["a"]?.val == "undefined")
        
        XCTAssertNoThrow(try runLine("var ao = 5.0"))
        XCTAssertNoThrow(try runLine("var ap = 5"))
        XCTAssertThrowsError(try runLine("a = ao"))
        XCTAssertNoThrow(try runLine("a = ap"))
    }
    
    func testUndefinedAssignmentInfered() {
        XCTAssertNoThrow(try runLine("ref a"))
        XCTAssert(pointers["a"]?.const == false)
        XCTAssert(pointers["a"]?.ref == true)
        XCTAssert(pointers["a"]?.type == "Undefined")
        XCTAssert(pointers["a"]?.val == "undefined")
        
        XCTAssertNoThrow(try runLine("var ao = 5.0"))
        XCTAssertNoThrow(try runLine("var ap = 5"))
        XCTAssertNoThrow(try runLine("a = ao"))
        XCTAssert(pointers["a"]?.type == "Double")
        XCTAssertThrowsError(try runLine("a = ap"))
    }
    
}
