//
//  Begin.swift
//  Arena 3
//
//  Created by Jonathan Pappas on 6/23/20.
//  Copyright © 2020 Jonathan Pappas. All rights reserved.
//

import Foundation
import Regex

// This is the beginning state of my code
func begin(_ fileToRead: String = "magical.txt") {
    
    PRINT.share = false
    var a = #file
    a = a.replacingFirst(matching: #"main\.swift"#, with: fileToRead)

    let b = (try? String.init(contentsOfFile: a)) ?? ""
    let code = b.split(separator: "\n", maxSplits: .max, omittingEmptySubsequences: false)
    _ = Regex("\n").allMatches(in: b).count + 1

    do {
        
        thisLine: for i in code {
            // Save the Lines in Memory
            lineCount += 1
            let yo = i.split(separator: ";", maxSplits: .max, omittingEmptySubsequences: false)
            let bb = yo.map { String($0) }
            lines[lineCount] = bb
            
            // Check if this line can be skipped
            if skipLines > 0 { skipLines -= 1; continue thisLine }
            
            sameLine: for line in bb {
                try runLine(line, lineCount)
                
                // Pin Warnigs :)
                for i in warnings {
                    warning(i, line: lineCount)
                }; warnings = []
            }
        }

    // Errors Halt the Program
    } catch let err as E {
        error(err.message(), line: lineCount)
    } catch let err {
        error("Unknown Error? \(err.localizedDescription)", line: lineCount)
    }

}
