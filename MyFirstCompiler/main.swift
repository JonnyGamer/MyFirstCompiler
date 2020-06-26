//
//  main.swift
//  MyFirstCompiler
//
//  Created by Jonathan Pappas on 6/23/20.
//

import Foundation
import CloudKit

var c = Date().timeIntervalSince1970
for _ in 1...1000000 {
    
    
}
var d = Date().timeIntervalSince1970
print("DONE")
print(1 / (d - c))

// let (f, g) = (Date().timeIntervalSince1970, Date().timeIntervalSince1970)
// print(1 / (g - f))




print((d - c) * 1000000)
c = Date().timeIntervalSince1970
d = Date().timeIntervalSince1970
print((d - c) * 1000000)
c = Date().timeIntervalSince1970
d = Date().timeIntervalSince1970
print((d - c) * 1000000)
c = Date().timeIntervalSince1970
d = Date().timeIntervalSince1970
print((d - c) * 1000000)
c = Date().timeIntervalSince1970
d = Date().timeIntervalSince1970
print((d - c) * 1000000)

var ao = [Double]()
for i in 1...1000000 {
    let a = Date().timeIntervalSince1970
    let b = Date().timeIntervalSince1970
    ao.append((b - a) * 100000000)
}
var ap = 0.0
ao.map { ap += $0 }
ap /= 1000000
print(ap)


print(Date().timeIntervalSince1970)
//usleep(10000000)
print(Date().timeIntervalSince1970)

print(Date().timeIntervalSince1970 - Date().timeIntervalSince1970)



/*
func tuple<T>(_ this: T) -> Foo<T> { return Foo.o(this) }

enum Foo<T> {
    case o(T)
    var O: T {
        get { P }
        set(to) { self = .o(to) }
    }
    var P: T { switch self { case .o(let p): return p } }
}

var bar = tuple(5)
print(bar.O)

bar.O = 100
print(bar.O)



//struct ​<T> {
//    var O: T
//    init(_ o: T) { O = o }
//}
//
//let foo = ​(5)
//print(foo.O)
//print(type(of: foo))


 let fooo: ((Int)) -> Int = { $0 }
 print(type(of: fooo))
 let a = fooo(5)

// let foo: (Int, Int) = (100, 200)
// print(foo.0) // prints 100
// print(foo.1) // prints 200

let aooo = type(of: ())
print(aooo() == ())


// print(foo)
// print(type(of: foo))
// print(type(of: ao))
// print((5))
// print(type(of: ()))

// var (a, b): (Int, String) = (6, "kk")

// begin()
*/
