// Playground - noun: a place where people can play

import UIKit
//import Cocoa

var str = "Hello, playground"
/*
Currying and Closure

Reference: http://vperi.com/2014/06/04/currying-closures-in-swift/
*/

var f1 = { (x: Int) -> Void in println("f1: \(x)") }
f1(100)

var f1c = curry(f1, 20)
