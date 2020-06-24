//
//  Test Var.swift
//  MyFirstCompiler
//
//  Created by Jonathan Pappas on 6/23/20.
//

import XCTest

extension TestVarValues {
    
    // Immediate Assignment Test
    func testImmediateAssignment() {
        XCTAssertNoThrow(try runLine("var a Int = 0"))
        XCTAssert(pointers["a"]?.val == "0")
        XCTAssert(pointers["a"]?.const == false)
        XCTAssert(pointers["a"]?.ref == false)
        XCTAssert(pointers["a"]?.type == "Int")
        prestoChango()
    }
    
    // Immediate Assignment With Type Inference
    func testImmediateAssignmentUsingTypeInference() {
        XCTAssertNoThrow(try runLine("var a = 0"))
        XCTAssert(pointers["a"]?.val == "0")
        XCTAssert(pointers["a"]?.const == false)
        XCTAssert(pointers["a"]?.ref == false)
        XCTAssert(pointers["a"]?.type == "Int")
        prestoChango()
    }
    
    func prestoChango() {
        XCTAssertNoThrow(try runLine("a = 0"))
        XCTAssert(pointers["a"]?.val == "0")
        XCTAssertNoThrow(try runLine("a = 1"))
        XCTAssert(pointers["a"]?.val == "1")
        XCTAssertNoThrow(try runLine("a = 01"))
        XCTAssert(pointers["a"]?.val == "1")
        XCTAssertNoThrow(try runLine("a = 1000"))
        XCTAssert(pointers["a"]?.val == "1000")
        XCTAssertNoThrow(try runLine("a = -1000"))
        XCTAssert(pointers["a"]?.val == "-1000")
        XCTAssertThrowsError(try runLine("a = 0.0"))
    }
    
    func testUndefinedAssignment() {
        // Assign as undefined
        XCTAssertNoThrow(try runLine("var a Int"))
        XCTAssert(pointers["a"]?.val == "undefined")
        XCTAssert(pointers["a"]?.const == false)
        XCTAssert(pointers["a"]?.ref == false)
        XCTAssert(pointers["a"]?.type == "Int")
        // Assign from undefined
        XCTAssertNoThrow(try runLine("a = -0"))
        XCTAssert(pointers["a"]?.val == "0")
        XCTAssert(pointers["a"]?.const == false)
        XCTAssert(pointers["a"]?.ref == false)
        // Reassignment
        prestoChango()
    }
    
    // let a
    func testUndefinedUndefined() {
        // No assign as undefined
        XCTAssertNoThrow(try runLine("var a"))
        XCTAssert(pointers["a"]?.val == "undefined")
        XCTAssert(pointers["a"]?.const == false)
        XCTAssert(pointers["a"]?.ref == false)
        XCTAssert(pointers["a"]?.type == "Undefined")
        // Assign to undefined
        XCTAssertNoThrow(try runLine("a = undefined"))
        XCTAssert(pointers["a"]?.val == "undefined")
        XCTAssert(pointers["a"]?.const == false)
        XCTAssert(pointers["a"]?.ref == false)
        // Assign to 0
        XCTAssertNoThrow(try runLine("a = 0"))
        XCTAssert(pointers["a"]?.val == "0")
        XCTAssert(pointers["a"]?.const == false)
        XCTAssert(pointers["a"]?.ref == false)
        XCTAssert(pointers["a"]?.type == "Int")
        // Reassignment error
        prestoChango()
    }

    // Type Inference Test - Int
    func testTypeInferenceInt() {
        XCTAssertNoThrow(try runLine("var a = -00"))
        XCTAssert(pointers["a"]?.val == "0")
        XCTAssert(pointers["a"]?.const == false)
        XCTAssert(pointers["a"]?.ref == false)
        XCTAssert(pointers["a"]?.type == "Int")
        prestoChango()
    }
    
    // Type Inference Test - Double
    func testTypeInferenceDouble() {
        XCTAssertNoThrow(try runLine("var a = -00.00"))
        XCTAssert(pointers["a"]?.val == "0.0")
        XCTAssert(pointers["a"]?.const == false)
        XCTAssert(pointers["a"]?.ref == false)
        XCTAssert(pointers["a"]?.type == "Double")
    }
    
    func testLetErrors() {
        XCTAssertThrowsError(try runLine("var a a = 0"))
        XCTAssertThrowsError(try runLine("var a a Int = 0"))
    }
    
    
    func testVarTypeTypes() {
        // Immediate Assignment - Type Type
        XCTAssertNoThrow(try runLine("var a Type = Int"))
        XCTAssert(pointers["a"]?.val == "Int")
        XCTAssert(pointers["a"]?.const == false)
        XCTAssert(pointers["a"]?.ref == false)
        XCTAssert(pointers["a"]?.type == "Type")
        // Redefine It
        XCTAssertNoThrow(try runLine("a = Int"))
        XCTAssert(pointers["a"]?.val == "Int")
        XCTAssert(pointers["a"]?.type == "Type")
        pointers.removeAll()
        
        // Type Inference Test - Type Type
        XCTAssertNoThrow(try runLine("var a = Type"))
        XCTAssert(pointers["a"]?.val == "Type")
        XCTAssert(pointers["a"]?.const == false)
        XCTAssert(pointers["a"]?.ref == false)
        XCTAssert(pointers["a"]?.type == "Type")
        // Redefine It
        XCTAssertNoThrow(try runLine("a = Int"))
        XCTAssert(pointers["a"]?.val == "Int")
        XCTAssert(pointers["a"]?.type == "Type")
    }
    
}
