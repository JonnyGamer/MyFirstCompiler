//
//  Resolve Expressions.swift
//  Arena 3
//
//  Created by Jonathan Pappas on 6/21/20.
//  Copyright © 2020 Jonathan Pappas. All rights reserved.
//

import Foundation
import Regex

// So you can add your own custom operators ;)
let infixiOperators: [Int:[String:(String, String) throws -> String]] = [
    1: ["is":equivocate, "==":equivocate, "^":notEquals, "!=":notEquals],
    2: ["as":asValue],
    10: ["=":assignValue] // assignment
]

@discardableResult
func resolveParenExpressions(_ line: String) throws -> String {
    var lino = line
    
    // |\[[^)(]*\]
    let topBrace = Regex(#"\([^)(]*\)"#)
    while var lina = topBrace.firstMatch(in: lino)?.matchedString {
        if lina.count == 2 { throw E.custom("Empty Parenthesis '()' not allowed") }
        lina.removeFirst(); lina.removeLast()
        lino.replaceFirst(matching: topBrace, with: try resolveLowLevelExpression(lina))
    }
    
    lino = try resolveLowLevelExpression(lino)
    if let rrr = resolveValue(lino) {
        return rrr
    }
    throw E.custom("Resolved to awkward result?")
}


func resolveLowLevelExpression(_ line: String) throws -> String {
    var lino = line
    for i in infixiOperators.sorted(by: {
        $0.key > $1.key
    }) {
        // This is for infix operators of equal importance. Resolve left to right equally.
        var yo = ""
        for j in i.value {
            yo += j.key.fix + "|"
        }; yo.removeLast()
        
        while let po = try? Regex(string: #"[^\s]+ (\#(yo)) [^\s]+"#).firstMatch(in: lino)?.matchedString {
            
            var (iname, a0, a1) = (po, po, po)
            a0.replaceFirst(matching: Regex("(.+)( .+ )(.+)"), with: "$1")
            iname.replaceFirst(matching: Regex("(.+ )(.+)( .+)"), with: "$2")
            a1.replaceFirst(matching: Regex("(.+)( .+ )(.+)"), with: "$3")
            if let bb = try i.value[iname]?(a0, a1) {
                lino.replaceFirst(matching: try Regex(string: po.fix), with: bb)
            }
        }
        
    }
    return lino
}

let meta = #"^\"#
extension String {
    var fix: String {
        var yo = ""
        for i in self {
            if meta.contains(String(i)) {
                yo += #"\"# + "\(String(i))"
            } else {
                yo += String(i)
            }
        }
        return yo
    }
}


// Not in use?
func resolvePrefixExpressions(_ line: String) throws -> String {
    return ""
}


func extractOperands(_ from: String,_ infix: String) throws -> (String, String) {
    let a = try? Regex(string: ".+(?= \(infix)").firstMatch(in: from)?.matchedString
    let b = try? Regex(string: "(?<=\(infix) ).+").firstMatch(in: from)?.matchedString
    if let c = a, let d = b {
        return (c, d)
    } else {
        throw E.custom("Operation '\(infix)' must have 2 operands")
    }
}



// Check for Boolean Expression
func booleanExpression(_ line: String) throws -> String {
    if line == "true" || line == "false" { return line }
    // Equivocation 5 is 5
    if Regex(".+ is .+").matches(line) {
        let a = Regex(".+(?= is)").firstMatch(in: line)?.matchedString
        let b = Regex("(?<=is ).+").firstMatch(in: line)?.matchedString
        if let c = a, let d = b {
            return try equivocate(c, d)
        } else {
            throw E.custom("Something very oddd happened")
        }
    } else {
        throw E.custom("'\(line)' is not a Boolean expression")
    }
}
