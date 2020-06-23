//
//  Type Tests.swift
//  MyFirstCompiler
//
//  Created by Jonathan Pappas on 6/23/20.
//

import XCTest

extension StrangeTypes {
    func testStrangeValues() {
        XCTAssert(resolveType("/ /") == "Regex")
        XCTAssert(resolveType("()") == "Void")
        XCTAssert(resolveType("undefined") == "Undefined")
        
        XCTAssert(resolveType("") == nil)
        XCTAssert(resolveType(".") == nil)
        XCTAssert(resolveType(" ") == nil)
        XCTAssert(resolveType("//") == nil)
        XCTAssert(resolveType("( )") == nil)
    }
    
    func testTypesofTypes() {
        XCTAssert(resolveType("Int") == "Type")
        XCTAssert(resolveType("Double") == "Type")
        XCTAssert(resolveType("String") == "Type")
        XCTAssert(resolveType("Void") == "Type")
        XCTAssert(resolveType("Undefined") == "Type")
        XCTAssert(resolveType("Regex") == "Type")
        XCTAssert(resolveType("Type") == "Type")
    }
    
    func testValuesOfTypeType() {
        XCTAssert(resolveValue("Int") == "Int")
        XCTAssert(resolveValue("Double") == "Double")
        XCTAssert(resolveValue("String") == "String")
        XCTAssert(resolveValue("Void") == "Void")
        XCTAssert(resolveValue("Undefined") == "Undefined")
        XCTAssert(resolveValue("Regex") == "Regex")
        XCTAssert(resolveValue("Type") == "Type")
    }
}
