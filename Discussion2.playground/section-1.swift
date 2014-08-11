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

//var f1c = curry(f1, 20)

//Currying example
//Example-1
func twoWords(a: String)(b: String) ->String {
    return "\(a) \(b)"
}

let res0 = twoWords("I am ")(b: "here")
let res = twoWords("Hello ")
let res1 = res(b: "World")

//Lets we need to add another parameter
func threeWords(a: String)(b: String)(c: String) ->String {
    return "\(a) \(b) \(c)"
}

let res00 = threeWords("I am ")(b: "here")(c: "!")

let helloWorld = threeWords("Hello")(b: "World")
helloWorld(c: "!")
//Since it was currying, we can achieve it by using twoWords function

let res01 = twoWords("I am")
let res02 = res01(b: "here")
//let res03 = res02(b: "!")

//Example-2
func square(a:Float) -> Float {
    return a * a
}

func cube(a:Float) -> Float {
    return a * a * a
}

func averageOfFunction
    (f: (Float -> Float))
    (a: Float, b: Float) -> Float{
        return (f(a)+f(b))/2
}

let sqAvg = averageOfFunction(square)
let cubAvg = averageOfFunction(cube)

let sqRes = sqAvg(a:2, b:3)
let cubRes = cubAvg(a: 2, b: 3)


/*
Tail Recursion
Tail Call

Traditional Recursion: Final calculation will be carried out after all recursive function call. Hence each function call, compiler needs to add  new stack frame to call stack. Compiler has to remember entry point of the each call.
i.e.  we perform recursive calls first, and then we take the return value of the recursive call and calculate the result. In this manner, we don't get the result of the calculation until we have returned from every recursive call

Here is an example:

sum(5) = 1 + 2 + 3 + 4 + 5 = 15

recsum(5)
5 + recsum(4)
5 + (4 + recsum(3))
5 + (4 + (3 + recsum(2)))
5 + (4 + (3 + (2 + recsum(1))))
5 + (4 + (3 + (2 + 1)))
15

In tail recursion, we will do calculation first. Then we execute recursion call, passing the results of the current step to the next step. We don't need current current stack frame any more. We optimized and will avoid stack overflow
Basically, the return value of any given recursive step is the same as the return value of the next recursive call.

Example: 
def tailrecsum(x, running_total=0):
    if x == 0:
        return running_total
    else:
        return tailrecsum(x - 1, running_total + x)


Recursion Vs Iteration
Tail recursion is similar to iteration

*/

//Factorial
func factorial(n: Int) -> Int{
    if n == 1{
        return 1
    }
    else{
        return n * factorial(n-1)
    }
}

let factorialRes = factorial(4)

func factorialTrailRecursuion(n: Int, result: Int = 1) -> Int{
    if n == 1{
        return result
    }
    else{
        return factorialTrailRecursuion(n-1, result: n * result)
    }
    
}

func fact(n: Int) -> Int{
    return factorialTrailRecursuion(n, result:1)
}

let factorialTailRes = fact(4)


//Example-2: Fibonaci series
func fibonaci(x: Int) -> Int{
    /*
    if x == 0 {
        return 0
    }
    else if x == 1 {
        return 1
    }*/
    if x < 2{
        return x
    }
    else{
        return (fibonaci(x-1) + fibonaci(x-2))
    }
}

let fibRes = fibonaci(5)
/*
func fib(n: Int) -> Int {
    return n < 2 ? n : (fib(n—1) + fib(n-2))
}

let fibResult = fib(4)
fibResult
*/

func fib(n: Int, iterator: Int, acc: Int) -> Int {
    if iterator == n{
        return acc
    }
    else{
        return fib(n, iterator+1, acc+iterator)
    }
}

func fibResult(n: Int) -> Int{
    if n < 2 {
        return n
    }
    else{
        return fib(n, 1, 1)
    }
    
}

let fibTellCall = fibResult(5)

































