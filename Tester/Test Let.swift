//
//  Test Values.swift
//  MyFirstCompiler
//
//  Created by Jonathan Pappas on 6/23/20.
//

import XCTest

extension TestLetValues {
    
    func testBadLets() {
        XCTAssertThrowsError(try runLine("let a Double = 0"))
        XCTAssertThrowsError(try runLine("let b Double = b"))
        XCTAssertThrowsError(try runLine("let c = c"))
    }
    
    // Immediate Assignment Test
    func testImmediateAssignment() {
        XCTAssertNoThrow(try runLine("let a Int = 0"))
        XCTAssert(pointers["a"]?.val == "0")
        XCTAssert(pointers["a"]?.const == true)
        XCTAssert(pointers["a"]?.ref == false)
        XCTAssert(pointers["a"]?.type == "Int")
    }
    
    // Immediate Assignment With Type Inference
    func testImmediateAssignmentUsingTypeInference() {
        XCTAssertNoThrow(try runLine("let a = 0"))
        XCTAssert(pointers["a"]?.val == "0")
        XCTAssert(pointers["a"]?.const == true)
        XCTAssert(pointers["a"]?.ref == false)
        XCTAssert(pointers["a"]?.type == "Int")
    }
    
    func testUndefinedAssignment() {
        // Assign as undefined
        XCTAssertNoThrow(try runLine("let a Int"))
        XCTAssert(pointers["a"]?.val == "undefined")
        XCTAssert(pointers["a"]?.const == true)
        XCTAssert(pointers["a"]?.ref == false)
        XCTAssert(pointers["a"]?.type == "Int")
        // Assign from undefined
        XCTAssertNoThrow(try runLine("a = -0"))
        XCTAssert(pointers["a"]?.val == "0")
        XCTAssert(pointers["a"]?.const == true)
        XCTAssert(pointers["a"]?.ref == false)
        // Reassignment error
        XCTAssertThrowsError(try runLine("a = -0"))
    }
    
    // let a
    func testUndefinedUndefined() {
        // No assign as undefined
        XCTAssertNoThrow(try runLine("let a"))
        XCTAssert(pointers["a"]?.val == "undefined")
        XCTAssert(pointers["a"]?.const == true)
        XCTAssert(pointers["a"]?.ref == false)
        XCTAssert(pointers["a"]?.type == "Undefined")
        // Assign to undefined
        XCTAssertNoThrow(try runLine("a = undefined"))
        XCTAssert(pointers["a"]?.val == "undefined")
        XCTAssert(pointers["a"]?.const == true)
        XCTAssert(pointers["a"]?.ref == false)
        // Assign to 0
        XCTAssertNoThrow(try runLine("a = 0"))
        XCTAssert(pointers["a"]?.val == "0")
        XCTAssert(pointers["a"]?.const == true)
        XCTAssert(pointers["a"]?.ref == false)
        XCTAssert(pointers["a"]?.type == "Int")
        // Reassignment error
        XCTAssertThrowsError(try runLine("a = -0"))
        XCTAssertThrowsError(try runLine("a = -0.0"))
    }

    // Type Inference Test - Int
    func testTypeInferenceInt() {
        XCTAssertNoThrow(try runLine("let a = -00"))
        XCTAssert(pointers["a"]?.val == "0")
        XCTAssert(pointers["a"]?.const == true)
        XCTAssert(pointers["a"]?.ref == false)
        XCTAssert(pointers["a"]?.type == "Int")
    }
    
    // Type Inference Test - Double
    func testTypeInferenceDouble() {
        XCTAssertNoThrow(try runLine("let a = -00.00"))
        XCTAssert(pointers["a"]?.val == "0.0")
        XCTAssert(pointers["a"]?.const == true)
        XCTAssert(pointers["a"]?.ref == false)
        XCTAssert(pointers["a"]?.type == "Double")
    }
    
    func testLetErrors() {
        XCTAssertThrowsError(try runLine("let a a = 0"))
        XCTAssertThrowsError(try runLine("let a a Int = 0"))
    }
    
    
    func testLetTypeTypes() {
        // Immediate Assignment - Type Type
        XCTAssertNoThrow(try runLine("let a Type = Int"))
        XCTAssert(pointers["a"]?.val == "Int")
        XCTAssert(pointers["a"]?.const == true)
        XCTAssert(pointers["a"]?.ref == false)
        XCTAssert(pointers["a"]?.type == "Type")
        pointers.removeAll()
        
        // Type Inference Test - Type Type
        XCTAssertNoThrow(try runLine("let a = Type"))
        XCTAssert(pointers["a"]?.val == "Type")
        XCTAssert(pointers["a"]?.const == true)
        XCTAssert(pointers["a"]?.ref == false)
        XCTAssert(pointers["a"]?.type == "Type")
    }
    
}
