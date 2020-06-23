//
//  Type Checking.swift
//  Arena 3
//
//  Created by Jonathan Pappas on 6/17/20.
//  Copyright © 2020 Jonathan Pappas. All rights reserved.
//

import Foundation
import Regex

private func getType(_ value: String) -> String? {
    if bitter(value) { return "Type" }
    return bit.find(value)?.key
}

public func passTypeCheck(_ value: String) -> Bool {
    return (try? checkDataTypes(value)) != nil
}

// Returns Your Type
public func resolveType(_ name: String) -> String? {
    if let wo = getType(name) { return wo }
    var o = name
    while let c = pointers[o] {
        o = c.type
    }
    if !types.contains(o) { return pointers[name]?.type }
    return o
}

// Returns the smallest value
public func resolveValue(_ name: String) -> String? {
    var o = name
    while let c = pointers[o] {
        o = c.val
    }
    if let ao = getType(o) {
        return bit[ao]?.clean(o) ?? o
    } else {
        return pointers[name]?.type
    }
}

public func checkDataTypes(_ value: String) throws {
    var b = value.replacingFirst(matching: #"^typeOf\((.*)\)"#, with: "$1")
    var name: String? = nil
    
    // Check for references
    if let got = resolveType(b) {
        name = b; b = got
    }
    
    if let val = try? pointers.finalVal(name ?? b), let found = bit.find(val) {
        let clen = found.value.clean(b)
        //  b == "Any"
        if pointers[name ?? "__;Ledenne"]?.any == true {
            let fofo = found.key == "Undefined" ? "Undefined" : found.key
            share(name ?? clen, "is an Any<\(fofo)>.")
            say("Any<\(pointers[name ?? "0-2iw9"]?.type ?? fofo)>")
        } else {
            if val == "undefined" { share(b, "is of type:"); say(clen); return }
            share(name ?? clen, "is of type:")
            say(found.key)
        }
        
    // For Special Types. Like 'Type'
    } else if let val = try? pointers.finalVal(name ?? b), bitter(val) {
        
        if pointers[name ?? "__;Ledenne"]?.any == true {
            share(name ?? "HUH?", "is an Any<\(b)>.")
            say("Any<\(b)>")
        } else {
            share(name ?? "HUH?", "is of type:")
            say(b)
        }
        
    } else {
        throw E.custom("'\(b)' is unrecognizable")
    }
}

public func printValue(_ value: String) throws {
    let a = value.replacingFirst(matching: #"^print\((.*)\)"#, with: "$1")
    if let b = resolveValue(a) {
        say(b)
    } else { throw E.custom("META CODE CRASHED") }
}

// Update for Expressions
public func newPrintValue(_ value: String) throws {
    let a = value.replacingFirst(matching: #"^print\((.*)\)"#, with: "$1")
    say(try resolveParenExpressions(a))
}

public extension String {
    func firstResolvableType() throws -> (String, String)? {
        for i in bit {
            if var a = try Regex(string: #"( |^|\()"# + i.value.regex + #"( |$|\))"#).firstMatch(in: self)?.matchedString {
                a = a.rmv([#"^ "#, #" $"#, #"^\("#, #"\)$"#])
                // replacingAll(matching: "^ ?(.*?) ?$", with: "$1")
                return (a, i.key)
            }
        }
        return nil
    }
}
