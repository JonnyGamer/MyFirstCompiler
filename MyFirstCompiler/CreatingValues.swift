//
//  test.swift
//  Arena 3
//
//  Created by Jonathan Pappas on 6/16/20.
//  Copyright © 2020 Jonathan Pappas. All rights reserved.
//

import Foundation
import Regex


func makeValue(_ line: String,_ g: String) throws {
    var assignment = false
    var c = false
    var r = false
    var a = false
    var valueName: String
    switch g {
    case "ref": valueName = line.replacingFirst(matching: "^ref *", with: ""); r = true
    case "var": valueName = line.replacingFirst(matching: "^var *", with: "")
    case "let": valueName = line.replacingFirst(matching: "^let *", with: ""); c = true
    case "any": valueName = line.replacingFirst(matching: "^any *", with: ""); r = true; a = true
    default: throw E.custom("META CODE BROKE; Something wonked 'ref' 'var' 'let'")
    }
    
    // Find out if this value has a explicit type
    var type = "Undefined"
    if valueName.contains(" ") {
        let tt = valueName.replacingAll(matching: #"^[^\s]+ "#, with: "")
        let t = tt.replacingAll(matching: #" =.+"#, with: "")
        valueName = valueName.replacingAll(matching: Regex(#"([^\s]+).+"#), with: "$1")
        if types.contains(t) || bitter(t) {
            type = t
        } else {
            if t.first != "=" {
                throw E.custom("\(t) Type does not exist")
            } else { assignment = true }
        }
        
        // Watch out for: `let b Int = 5`  and  `let b Int<Ha, Ha> = 5`
        let ot = line.replacingAll(matching: #"<.+>( =)"#, with: "$1")
        let tp = ot.replacingAll(matching: #"[^\s]+ [^\s]+ [^\s]+ ([^\s]+).+"#, with: "$1")
        if tp == "=" {
            assignment = true
        }
    }
    
    // Check for _ value
    
    // Check if name is already in use
    if pointers[valueName] == nil {
        if valueName.contains(" ") { throw E.nameContainsSpace(valueName) }
        
        // Find out if this value has a explicit type
        pointers.add(valueName, (type: type, val: "undefined", const: c, ref: r, any: a))
        share("Succesfully made value: \(valueName)")
    } else {
        throw E.nameAlreadyExists(valueName)
    }
    
    // Create the value, if you want to.. :)
    if !assignment { return }
    if assignment { pointers[valueName]?.type = "Undefined" }
    var newValue = line
    newValue = newValue.replacingAll(matching: Regex(#"[^\s]+ ([^\s]+ )"#), with: "$1")
    try resolveParenExpressions(newValue)
    let newType = resolveType(pointers[valueName]?.val ?? "_-303e") ?? "djnwd"
    pointers[valueName]?.type = newType
    if pointers[valueName]?.type != type && type != "Undefined" {
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

// Created for `EXPRESSIONS`
@discardableResult
func assignValue(_ valueName: String,_ to: String) throws -> String {
    // If in use
    if let po = pointers[valueName] {
        if po.const, po.val != "undefined" { throw E.custom("Cannot mutate a 'let'") }
        
        // if po.type != "Any"
        if !po.any {
            if resolveType(to) == po.type || po.type == "Undefined" {
                if po.ref {
                    if let blo = pointers[to]?.any { pointers[valueName]?.any = blo }
                    if Regex(#"^__.+__$"#).matches(to), let ao = resolveValue(to) {
                        pointers[valueName]?.val = ao
                    } else {
                        pointers[valueName]?.val = to
                    }
                } else {
                    if let aa = resolveValue(to) {
                        pointers[valueName]?.val = aa
                    } else {
                        throw E.custom("Your Type Regex didn't work")
                    }
                }
            } else {
                throw E.custom("Cannot mutate defined type")
            }
            
        } else {
            if po.ref {
                if let blo = pointers[to]?.any { pointers[valueName]?.any = blo }
                pointers[valueName]?.val = to
            } else if let aa = resolveValue(to) {
                pointers[valueName]?.val = aa
            } else {
                throw E.custom("BADD bad bad bad")
            }
        }
        
    } else { throw E.custom("Cannot mutate nonexistant value") }
    pointers["_"] = nil
    return "()"
}

func deleteValue(_ line: String) {
    let a = line.replacingFirst(matching: "^rmv (.+)", with: "$1")
    if pointers[a] == nil { warn("You are deleting a nonexistant value: '\(a)'") }
    pointers[a] = nil
}
