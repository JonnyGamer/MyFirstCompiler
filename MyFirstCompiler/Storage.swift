//
//  Storage.swift
//  Arena 3
//
//  Created by Jonathan Pappas on 6/17/20.
//  Copyright © 2020 Jonathan Pappas. All rights reserved.
//

import Foundation
import Regex

public var lines = [Int:[String]]()
public var lineCount = 0
public var types = ["Int", "Double", "String", "Regex", "Bool", "Void", "Type", "Undefined"] // "Character"
public var wrappers = [1:["Test1"],2:["Test2"]]

var pointers = [
    String:(
        type: String,
        val: String,
        const: Bool,
        ref: Bool,
        any: Bool
    )
]()

public extension Dictionary where Key == String, Value == (type: String, val: String, const: Bool, ref: Bool, any: Bool) {
    mutating func add(_ key: Key,_ val: Value) {
        self[key] = val
    }
    func finalVal(_ key: String) throws -> String {
        if let a = resolveValue(self[key]?.val ?? "__O_)#I)#03") {
            return a
        }; throw E.custom("BUG IN META CODE")
    }
}

public extension Dictionary where Key == String, Value == (regex: String, clean: (String) -> String) {
    
    func find(_ value: String) -> Element? {
        var on = ""
        do {
            for i in self {
                on = i.key + ": " + i.value.regex
                if try !Regex(string: "^(" + i.value.regex + ")$").allMatches(in: value).isEmpty {
                    return i
                }
            }; return nil
        } catch {
            return nil
            // throw E.custom("Regex broke: \(on)")
        }
    }
}

public var bit: [String:(regex: String, clean: (String) -> String)] = [
    "Bool": (regex: "true|false", clean: { $0 }),
    "Regex": (regex: #"/.+/"#, clean: { $0 }),
    // "Character": (regex: #"^\".\"$"#, clean: { $0 }),
                        //#"\"[^\"]+\""#
    "String": (regex: #"\"[^\"]*\""#, clean: { $0 }),
    "Undefined": (regex: "undefined", clean: { $0 }),
    
    "Int": (regex: #"-?\d+"#,
            clean: {
                // var a = $0.rmv(["^(-?)0+"], "$1")
                var a = $0.rmv(["^(-?)0+(.+)$"], "$1$2")
                if a == "" || a == "-0" { a = "0" }
                return a
    }),
    
    "Double": (regex: #"-?\d+\.\d+"#,
               clean: {
                var a = $0
                if !a.hasSuffix(".0") { a = $0.rp1(#"(\.(0|.*?))0+$"#, with: "$1") }
                return a
    }),
    
    "Void": (regex: #"Void|\(\)"#, clean: { $0 }),
    
    // "Any": (regex: "^.+$", clean: { $0 }),
]

// For Special Types like 'Type' etc. HAHAHA
public func bitter(_ specialType: String) -> Bool {
    var checkIfWrapper = specialType
    var hemo = checkIfWrapper
    hemo = checkIfWrapper.replacingFirst(matching: Regex(#"\<.+"#), with: "")
    checkIfWrapper = checkIfWrapper.replacingFirst(matching: Regex(#".+?\<(.+)\>"#), with: "$1")
    var off = 0
    // Fixing case of Any<Test<Int, Double>, Test<Int, Double>>
    let typos = checkIfWrapper.split { (hm) -> Bool in
        let hmm = String(hm)
        if hmm == "<" { off += 1 }
        if hmm == ">" { off -= 1 }
        return off == 0 && hmm == ","
    }
    
    if wrappers.contains(where: { (gen) -> Bool in
        gen.value.contains(hemo) && gen.key == typos.count
    }) {
        
        for i in typos {
            if types.contains(String(i)) {
                return true
            } else {
                if bitter(String(i)) {
                    return true
                }
            }
        }
        
    }
    
    return types.contains(specialType)
    
}


