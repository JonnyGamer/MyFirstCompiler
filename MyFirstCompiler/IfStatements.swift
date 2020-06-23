//
//  If Statements.swift
//  Arena 3
//
//  Created by Jonathan Pappas on 6/17/20.
//  Copyright © 2020 Jonathan Pappas. All rights reserved.
//

import Foundation
import Regex

var skipLines = 0
func skipIf(_ line: String) throws {
    var bool = line; bool.replaceFirst(matching: Regex("skip if *"), with: "")
    if resolveType(bool) == "Bool" {
        let a = resolveValue(bool)
        if a == "true" {
            skipLines += 1
        }
    } else {
        throw E.custom("If Statements must be Booleans 'if true'")
    }
}

func skipNLines(_ line: String) throws {
    if let popo = Regex(#"^(.+)(?= skip$)"#).firstMatch(in: line)?.matchedString {
        if let into = Int(try resolveParenExpressions(popo)) {
            skipLines += into
            return
        } else { throw E.custom("skips must have an Int value.") }
    }
    
    var bool = line; bool.replaceFirst(matching: Regex(#".+ skip if *"#), with: "")
    let into = line.replacingFirst(matching: Regex(#" skip if.+"#), with: "")
    let foo = try resolveParenExpressions(bool)
    if resolveType(foo) == "Bool" {
        if foo == "true" {
            if let ints = Int(try resolveParenExpressions(into)) {
                skipLines += ints
                return
            } else { throw E.custom("skips must have an Int value.") }
        }
    } else {
        throw E.custom("If Statements must be Booleans 'if true'")
    }
}

var ends = [(Bool, used: Bool)]()
extension Array {
    mutating func rmvLast(_ of: String) throws {
        if self.count > 0 {
            self.removeLast()
        } else { throw E.custom("Your '\(of)' kind of broke") }
    }
}

func canRun() -> Bool {
    if ends.isEmpty { return true }
    var bb = ends
    bb.removeLast()
    for i in bb {
        if !i.0 { return false }
    }; return true
}

func ifStatement(_ line: String) throws {
    if !canRun() { ends.append((false, false)); return }
    var bool = line; bool.replaceFirst(matching: Regex("if *"), with: "")
    // New if statement logic
    switch try resolveParenExpressions(bool) {
        case "true": ends.append((true, true))
        case "false": ends.append((false, false))
        default: throw E.custom("If Statements must be Booleans 'if true'")
    }
}

func orStatement(_ line: String) throws {
    if ends.isEmpty { throw E.custom("'or' cannot be used without an 'if'") }
    if !canRun() { ends[ends.count - 1].0 = false; return }
    if line == "or" {
        if ends.last?.used ?? true {
            ends[ends.count - 1].0 = false
            return
        }
        ends[ends.count - 1] = (true, used: true)
    }
}

func orifStatement(_ line: String) throws {
    if ends.isEmpty { throw E.custom("'or if' cannot be used without an 'if'") }
    if !canRun() { ends[ends.count - 1].0 = false; return }
    var bool = line; bool.replaceFirst(matching: Regex("or *if *"), with: "")
    
    if ends.last?.used ?? true {
        ends[ends.count - 1].0 = false
        return
    }
    switch try resolveParenExpressions(bool) {
        case "true": ends[ends.count - 1] = (true, used: true)
        case "false": ends[ends.count - 1] = (false, used: false)
        default: throw E.custom("Or If Statements must be Booleans 'or if true'")
    }
}
