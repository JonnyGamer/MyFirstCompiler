//
//  test.swift
//  Arena 3
//
//  Created by Jonathan Pappas on 6/16/20.
//  Copyright © 2020 Jonathan Pappas. All rights reserved.
//

import Foundation
import Regex

// Create a Value!
func makeValue(_ line: String,_ g: String) throws {
    var assignment = false, c = false, r = false, a = false
    var valueName = "", type = "Undefined"
    
    try resolveStorageType(line, g, &valueName, &r, &c, &a)
    try findIfValueHasExplicitType(&valueName, &type, &assignment, line)
    try checkIfNameIsAlreadyInUse(valueName, type, c, r, a)
    try immediateAssignment(assignment, valueName, line, type)
}

// Assign and Reassign Values!
@discardableResult
func assignValue(_ valueName: String,_ to: String) throws -> String {
    // If in use
    if let po = pointers[valueName] {
        try assignTheValue(po, valueName, to)
    } else { throw E.custom("Cannot mutate nonexistant value") }
    pointers["_"] = nil // Remove any _
    return "()"
}

// Delete Values from existence!
func deleteValue(_ line: String) {
    let a = line.replacingFirst(matching: "^rmv (.+)", with: "$1")
    if pointers[a] == nil { warn("You are deleting a nonexistant value: '\(a)'") }
    pointers[a] = nil
}







// MARK: MAKING A VALUE

// This method tests whether your value is ANY REF VAR or LET
private func resolveStorageType(_ line: String,_ g: String,_ valueName: inout String, _ r: inout Bool,_ c: inout Bool,_ a: inout Bool) throws {
    switch g {
    case "ref": valueName = line.replacingFirst(matching: "^ref *", with: ""); r = true
    case "var": valueName = line.replacingFirst(matching: "^var *", with: "")
    case "let": valueName = line.replacingFirst(matching: "^let *", with: ""); c = true
    case "any": valueName = line.replacingFirst(matching: "^any *", with: ""); r = true; a = true
    default: throw E.custom("META CODE BROKE; Something wonked 'ref' 'var' 'let' 'any'")
    }
}

private func findIfValueHasExplicitType(_ valueName: inout String,_ type: inout String,_ assignment: inout Bool,_ line: String) throws {
    if valueName.contains(" ") {
        let tt = valueName.replacingAll(matching: #"^[^\s]+ "#, with: "")
        let t = tt.replacingAll(matching: #" =.+"#, with: "")
        valueName = valueName.replacingAll(matching: Regex(#"([^\s]+).+"#), with: "$1")
        
        try checkIfExplicitTypeExists(&type, t, &assignment)
        reduceExplicitType(line, &assignment)
    }
}

private func checkIfExplicitTypeExists(_ type: inout String,_ t: String,_ assignment: inout Bool) throws {
    if types.contains(t) || bitter(t) {
        type = t
    } else {
        if t.first != "=" {
            throw E.custom("\(t) Type does not exist")
        } else { assignment = true }
    }
}

// Watch out for: `let b Int = 5`  and  `let b Int<Ha, Ha> = 5`
private func reduceExplicitType(_ line: String,_ assignment: inout Bool) {
    let ot = line.replacingAll(matching: #"<.+>( =)"#, with: "$1")
    let tp = ot.replacingAll(matching: #"[^\s]+ [^\s]+ [^\s]+ ([^\s]+).+"#, with: "$1")
    if tp == "=" {
        assignment = true
    }
}

private func checkIfNameIsAlreadyInUse(_ valueName: String,_ type: String,_ c: Bool,_ r: Bool,_ a: Bool) throws {
    if pointers[valueName] == nil {
        if valueName.contains(" ") { throw E.nameContainsSpace(valueName) }
        
        // Find out if this value has a explicit type
        pointers.add(valueName, (type: type, val: "undefined", const: c, ref: r, any: a))
        share("Succesfully made value: \(valueName)")
    } else {
        throw E.nameAlreadyExists(valueName)
    }
}

private func immediateAssignment(_ assignment: Bool,_ valueName: String,_ line: String,_ type: String) throws {
    // Create the value, if you want to.. :)
    if !assignment { return }
    if assignment { pointers[valueName]?.type = "Undefined" }
    var newValue = line
    newValue = newValue.replacingAll(matching: Regex(#"[^\s]+ ([^\s]+ )"#), with: "$1")
    try resolveParenExpressions(newValue)
    let newType = resolveType(pointers[valueName]?.val ?? "_-303e") ?? "djnwd"
    pointers[valueName]?.type = newType
    if pointers[valueName]?.type != type && type != "Undefined" && pointers[valueName]?.any == false {
        throw E.custom("Cannot define type, and then assign it to something else")
    }
}

func redefineValue(_ line: String) throws {
    // Is of form "a is 88"
    if let valueName = Regex(".+?(?= *=)").firstMatch(in: line)?.matchedString,
    let redefiningTo = Regex("(?== *).*").firstMatch(in: line)?.matchedString {
        let to = redefiningTo.replacingFirst(matching: Regex("^= "), with: "")
        try assignValue(valueName, to)
    }
}




// MARK: ASSIGNING A VALUE
// The True Assignment (ANY, REF, VAR, LET)
private func assignTheValue(_ po: ValueStorage,_ valueName: String,_ to: String) throws {
    if po.ref {
        try assignRef(po, valueName, to) // ANY REF
    } else if !po.const {
        try assignVar(po, valueName, to) // VAR
    } else {
        if po.val != "undefined" { throw E.custom("Cannot mutate a 'let'") }
        try assignVar(po, valueName, to) // LET
    }
}

// Assigns a REF or ANY storage type. Checks for __loc0__
private func assignRef(_ po: ValueStorage,_ valueName: String,_ to: String) throws {
    if Regex(#"^__.+__$"#).matches(to) { //, let ao = resolveValue(to) {
        try assignVar(po, valueName, to)
    } else if let toType = resolveType(to) {
        try assignment(po, valueName, to, toType)
    }
}

// Assigns a regular VAR
private func assignVar(_ po: ValueStorage,_ valueName: String,_ to: String) throws {
    if let toValue = resolveValue(to), let toType = resolveType(to) {
        try assignment(po, valueName, toValue, toType)
    }
}

// Create an Assignment
private func assignment(_ po: ValueStorage,_ valueName: String,_ toValue: String,_ toType: String) throws {
    try checkForMutatingType(po, toType)
    pointers[valueName]?.val = toValue
    if po.type == "Undefined" || po.any {
        pointers[valueName]?.type = toType
    }
}

// Check if the type will MUTATE and if it's ok
private func checkForMutatingType(_ po: ValueStorage,_ toType: String) throws {
    if toType != po.type && po.type != "Undefined" && !po.any {
        throw E.custom("Cannot mutate defined type")
    }
}
