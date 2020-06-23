//
//  Printing.swift
//  Arena 3
//
//  Created by Jonathan Pappas on 6/17/20.
//  Copyright © 2020 Jonathan Pappas. All rights reserved.
//

import Foundation

// I really appreciate this. I have 4 levels of print-outs
// share - The 'share' method, when turned on, described everything that is taking place
// say - This is equivolent to the 'print' method
// warning - This is a warnig message. It an be muted ;)
// error - This is an error message, always displayed

// share, say, and warning are can all be individually muted.
// You can mute all 3 by setting PRINT.mute to true
// Turning on Print.mute will mute all printouts. Except for Error.

typealias PrintFunc = ([Any], String, String) -> ()
let printo = unsafeBitCast(print, to: PrintFunc.self)

struct PRINT {
    static var share = true
    static var say = true
    static var warn = true
    static var mute = false
}

func share(_ items: Any..., separator: String = " ",_ terminator: String = "\n") {
    if !PRINT.share || PRINT.mute { return }
    printo(items, separator, terminator)
}
func say(_ items: Any..., separator: String = " ",_ terminator: String = "\n") {
    if !PRINT.say || PRINT.mute { return }
    printo(items, separator, terminator)
}
func warning(_ items: Any..., line: Int) {
    if !PRINT.warn || PRINT.mute { return }
    print("\n–––––")
    print("Warning on line \(line)")
    printo(items, " ", "\n")
    print("–––––\n")
}
func error(_ items: Any..., line: Int) {
    print("\n–––––")
    print("Error on line \(line)")
    printo(items, " ", "\n")
    print("–––––\n")
}
