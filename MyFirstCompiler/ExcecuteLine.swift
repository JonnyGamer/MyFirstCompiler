//
//  Excecute Line.swift
//  Arena 3
//
//  Created by Jonathan Pappas on 6/17/20.
//  Copyright © 2020 Jonathan Pappas. All rights reserved.
//

import Foundation
import Regex

var multilineComment = false

func runLine(_ lino: String,_ lineNumber: Int) throws {
    var line = lino
    
    // Embarrasing Glitch. Fixing print("HI there"). Etc. PUTTING VALUES IN POINTER LOCC
    var saved = [String]()
    while let po = try line.firstResolvableType() {
        pointers.add("__loc\(saved.count)__", (type: po.1, val: po.0.fix, const: true, ref: false, any: false))
        line.replaceFirst(matching: try Regex(string: po.0.fix), with: "__loc\(saved.count)__")
        saved.append(po.0.fix)
    }
    // Removing pointers
    defer {
        // for i in saved, remove from pointers
        for i in 0..<saved.count {
            pointers["__loc\(i)__"] = nil
        }
    }
    
    // Tidy up line, remove Unnessesarcy Spaces..
    line.replaceFirst(matching: "^ *(.*?) *$", with: "$1")
    line.replaceAll(matching: Regex("  +"), with: " ")

    var hit = [true, true]
    if let got = pointers[line] {
        share(line, "is", got); return
    }
    
    if line == "_" { warn("'_' is bad.. Please remove it."); return }
    
    // Comments
    switch line {
        case Regex("^//"), Regex("^ *$"): return
        case Regex(#"/\*"#): multilineComment = true
        case Regex(#"\*\/"#): multilineComment = false; return
        default: hit[0] = false
    }
    if multilineComment { return }
    
    // If Statements
    switch line {
        case Regex("^skip if"): try skipIf(line); return
        case Regex(#"^.+ skip if"#): try skipNLines(line); return
        case Regex(#"^skip"#): skipLines += 1; return
        case Regex(#"^.+ skip"#): try skipNLines(line); return
        case Regex("^if"): try ifStatement(line); return
        case Regex("^or if"): try orifStatement(line); return
        case Regex("^or"): try orStatement(line); return
        case Regex("^end if$"): try ends.rmvLast("end if"); return
        default: hit[1] = false
    }
    if ends.last?.0 == false { return }
    
    switch line {
        
    // Defining a Value
    case Regex("^let"): try makeValue(line, "let")
    case Regex("^var"): try makeValue(line, "var")
    case Regex("^ref"): try makeValue(line, "ref")
    case Regex("^any"): try makeValue(line, "any")
        
    // Deleting a value
    case Regex("^rmv"): deleteValue(line)
        
    // Check the value of
    case Regex(#"^typeOf\(.*\)$"#): try checkDataTypes(line)
    // Print the value of
    case Regex(#"^print\(.*\)$"#): try newPrintValue(line)
        
    // aka
    case Regex(#".+"#): try resolveParenExpressions(line)
        
    default:
        if hit == [true, true] {
            throw E.custom("'\(line)' is unrecognized")
        }
    }
    
    
}
