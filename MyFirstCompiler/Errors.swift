//
//  Errors.swift
//  Arena 3
//
//  Created by Jonathan Pappas on 6/17/20.
//  Copyright © 2020 Jonathan Pappas. All rights reserved.
//

import Foundation

var warnings = [String]()
func warn(_ this: String) { warnings.append(this) }

enum E: Error {
    case nameAlreadyExists(String)
    case nameContainsSpace(String)
    
    case custom(String)
    
    func message() -> String {
        switch self {
        case let .nameAlreadyExists(name): return "'\(name)' already exists"
        case let .nameContainsSpace(name): return"'\(name)' name contains space"
        case let .custom(name): return name
        }
    }
}
