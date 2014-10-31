// Playground - noun: a place where people can play

import UIKit
import Swift

var str = "Hello, playground"

struct Stack<T> {
    
    var stackItems = [T]()
    
    mutating func push(x: T){
        stackItems.append(x)
    }
    
    mutating func pop() -> T{
        return stackItems.removeLast()
    }
    
}

var intStack = Stack<Int>(stackItems: [0])
let pop = intStack.pop()
//let pop1 = intStack.pop() //This will give exception as array is empty


intStack.push(10)
intStack.push(10)
intStack.push(10)
intStack.push(10)

let pop1 = intStack.pop()

/*
func peekStack(s: Stack<Int>){
    for x in s{
        println(x)
    }
}

//The above code will generate an error as: type 'Stack<Int>' does not conform to protocol 'Sequence'
*/
/*
Earlier, we had discussed about the protocol (in previous sample)

When, we sue for.....in loop, compiler, does this internally.
var __g = someSequence.generate()
while let x = __g.next(){
    .......
}

protocol Generator{
    typealias Element
    mutating func next() -> Element?
}

i.e. need to use the protocol "sequence"
protocol Sequence{

    typealias GeneratorType: Generator{
        func generate()->GeneratorType
    }
}
As sequece protocol needs to of type Generator, we need to implement it

*/

/*
struct StackGenerator<T>: Generator{
    
    var items: Slice<T>
    
    mutating func next() -> T? {
        if items.isEmpty{ return nil }
        let ret = items[0]
        items = items[1..<items.count]
        return ret
    }
}


extension Stack: Sequence{
    func generate()->StackGenerator<T>{
        return StackGenerator(items: stackItems[0..<stackItems.endIndex])
    }
}

//Lets iterate
func peekStack(s: Stack<Int>){
    for x in s{
        println(x)
    }
}

*/

/*
var myStack = Stack<Int>(stackItems: [0])

myStack.push(10)
myStack.push(20)
myStack.push(30)
myStack.push(40)

peekStack(myStack)
*/
/*
Ref: http://robots.thoughtbot.com/swift-sequences

Summary: 
Protocols are hook into swifts core language
Swift generic combines abstraction, safety, and performance in a new way

*/


/* 
Swift - Model
1. It is statically compiled
2. Small runtime
3. Transparent interactions with C and Objective-C

Compiler Arcchitecture
======================

Objective-C:
Source Code -> clang (Parsing) -> LLVM (Low level optimization + Code Generation)

Swift:
Source Code -> Swift (Parsing + High level optimization) -> LLVM (Low level optimization + Code Generation)


Devitualization
================
Resolving dynamic method calls at compile time
1. if Swift can see where you constructed the object
2. if Swift knows that a class does not have any sub class
3. if you have marked a method with @final attribute

High-Level Optimization
========================
ARC optimization
Enum Analysis
Alias Analysis
Value Propagation
Library optimization on Strings, Array etc...


*/































