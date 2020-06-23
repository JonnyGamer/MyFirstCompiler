//
//  Extensions.swift
//  Arena 3
//
//  Created by Jonathan Pappas on 6/17/20.
//  Copyright © 2020 Jonathan Pappas. All rights reserved.
//

import Foundation
import Regex

public extension String {
    func rmv(_ what: [StaticString],_ with: String = "") -> String {
        var str = self
        for i in what {
            str = str.replacingFirst(matching: Regex(i), with: with)
        }
        return str
    }
    func rp1(_ what: StaticString, with: String) -> String {
        return self.replacingFirst(matching: Regex(what), with: with)
    }
}

postfix operator ¡
postfix func ¡<T>(_ op: Optional<T>) throws -> T {
    if let ao = op {
        return ao
    }; throw E.custom("nil.")
}
