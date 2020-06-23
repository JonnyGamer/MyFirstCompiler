//
//  Built In Operators.swift
//  Arena 3
//
//  Created by Jonathan Pappas on 6/18/20.
//  Copyright © 2020 Jonathan Pappas. All rights reserved.
//

import Foundation
import Regex

// Equivocation 'is' '=='
func equivocate(_ lhs: String,_ rhs: String) throws -> String {
    if let cc = resolveValue(lhs), let e = resolveType(cc),
        let dd = resolveValue(rhs), let f = resolveType(dd) {
        if e != f { throw E.custom("Equivocation only on 2 values of EQUAL type.\n'\(cc) is \(e)' and '\(dd)' is \(f)'") }
        return "\(cc == dd)"
    } else {
        throw E.custom("One or more of the operands are not actual values")
    }
}

// Not Equicovate 'is not' '!='
func notEquals(_ lhs: String,_ rhs: String) throws -> String {
    let a = try equivocate(lhs, rhs)
    if a == "true" { return "false" }
    if a == "false" { return "true" }
    throw E.custom("META CODE CRASHED !=")
}

func asValue(_ lhs: String,_ rhs: String) throws -> String {
    guard let _ = resolveType(lhs) else { throw E.custom("WONK?") }
    if let c = resolveType(rhs), c != "Type" {
        throw E.custom("'as' must check for 'Type' only\n\(rhs) is a '\(c)', and not a 'Type'")
    }
    return "\(resolveType(lhs) == rhs)"
}
