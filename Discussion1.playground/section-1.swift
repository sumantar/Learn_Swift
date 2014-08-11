// Playground - noun: a place where people can play


import UIKit

var str = "Hello, playground"

var numbers = [20, 19, 7, 12]

/*
.map => returns an array containing the results of calling 'transform(x)' on each element 'x' of self
*/
numbers.map({
    (number: Int) -> Int in
    let result = 4 * number
    return result
    })

numbers.map({
    number in 3 * number
    })


//numbers.map //=> This will crash the playground


//Reference: http://www.weheartswift.com/higher-order-functions-map-filter-reduce-and-more/

/*
Higher order functions:
1. Map
2. Filter
3. Reduce
4. More

*/

/*
Lets discuss about Closure
Blocks/Closures (different names for the same concept) are extensively used throughout Cocoa and Cocoa Touch and are at the heart of amazing iOS frameworks

Example: 

Lets have two functions as follows
1. Average of squre of two numbers
2. Average of cubes of two numbers
*/

//The standard implementation might look like this
func square(a:Float) -> Float {
    return a * a
}

func cube(a:Float) -> Float {
    return a * a * a
}

func averageSumOfSquares(a:Float,b:Float) -> Float {
    return (square(a) + square(b)) / 2.0
}

func averageSumOfCubes(a:Float,b:Float) -> Float {
    return (cube(a) + cube(b)) / 2.0
}

// The only difference between averageSumOfSquares and averageSumOfCubes are the calls to the square or cube function respectively. It would be nice if we could define a general method that takes as parameters 2 numbers and a function to apply to them and compute their average instead of repeating ourselves
// We can use closure here

func averageOfFunction(a: Float, b: Float, f: (Float -> Float)) -> Float{
    return (f(a)+f(b))/2
}

func abc(a:String) (b:String)->String{
    return a+b
}

let fixA = abc("3")
let r = fixA(b: "5")

averageOfFunction(4.0, 3.0, square)
averageOfFunction(4.0, 3.0, cube)

// There are different ways we can call this closure
// 1. Unmaned closure
// Trailing closure - we can provide parameter in and parenthesis folowed by return type. Then body will be separated by a keyword, "in"

var avg = averageOfFunction(3, 4, {
    (x: Float) -> Float in
    return x * x
    })


//
//2. we can omit type declaration because this can be inferred from the averageOfFunction declaration
// The compiler already knows that averageOfFunction expects a function that receives a float and returns a float

avg = averageOfFunction(3, 4, {
    x in return x * x
    })

//
//3. We can also omit the return statement
avg = averageOfFunction(3, 4, {
    x in x * x
    })

//4. we can omit specifying the parameter names altogether and use the default parameter name $0
// If the function accepted more than one parameter the we would use $K for the (K+1)nth paramter $0,$1,$2…

avg = averageOfFunction(3, 4, {
    $0 * $0
    })

/*
func averageOfFunction1(a: Float, b: Float, f: (Float -> Float)) -> Float{
    return (f(a)+f(b))/2
}
*/

func averageOfFunction1
    (f: (Float -> Float))
    (a: Float, b: Float) -> Float{
    return (f(a)+f(b))/2
}

let sqAvg = averageOfFunction1(square)
let cubAvg = averageOfFunction1(cube)

let sqRes = sqAvg(a:2, b:3)

/********************************************************
Swift’s standard Array Library includes support for 3 higher order sequence functions: 
1. map, 
2. filter 
3. reduce

https://developer.apple.com/library/prerelease/ios/documentation/General/Reference/SwiftStandardLibraryReference/Array.html#//apple_ref/doc/uid/TP40014608-CH5-SW1
*********************************************************/

/********************************************************
Map:
The map method solves the problem of transforming the elements of an array using a function.

[ x1, x2, ... , xn].map(f) -> [f(x1), f(x2), ... , f(xn)]
*********************************************************/

//Example: we have an array of Ints representing some sums of money and we want to create a new array of strings that contains the money value followed by the “$” character
//i.e. [10,20,45,32] -> ["10$","20$","45$","32$"]

var moneyArray = [10,20,45,32]

//If we don't know about map, then we will use it as follows (dirty way)
var stringArray: Array<String> = []
for money in moneyArray{
    stringArray += "\(money)$"
}
stringArray

//Lets use map to simplify this implementation
//Map is declared: func map<U>(transform: (T) -> U) -> U[] 
//That just means that it receives a function named transform that maps the array element type T to a new type U and returns an array of Us

let stringArray1 = moneyArray.map({
    "\($0)&"
    })

stringArray1

let stringArray2 = moneyArray.map({
    money in "\(money)$"
    })

stringArray2


/********************************************************
Filter:
The filter method solves the problem of selecting the elements of an array that pass a certain condition

In Swift filter is declared as a method on the Array class with signature func filter(includeElement: (T) -> Bool) -> T[] i.e. receives a function includeElement that returns true or false for elements of the array and returns only the elements that return true when includeElement is called on them
*********************************************************/

//Example: create a new array that only contains the amounts exceeding 30$
//If we don't use filter, then our code might look like this

var filterArray: Array<Int> = []
for money in moneyArray{
    if money > 30{
        filterArray += money
    }
}

filterArray

//Lets use filter
filterArray = moneyArray.filter({
    $0 > 30
    })

filterArray


/********************************************************
Reduce:
The reduce method solves the problem of combining the elements of an array to a single value

In Swift reduce is declared as a method on the Array class with signature func reduce(initial: U, combine: (U, T) -> U) -> U i.e. receives an initial element of type U and a function that specifies how to combine an element of type U with an element of type T to a single element of type U. The whole array is reduced to a single element of type U
*********************************************************/

//Example: Lets sum all the elemets of the money array
//If we don't know about reduce, then we can write the code as follows

var sum = 0
for money in moneyArray {
    sum = sum + money
}

sum

//Similarly we cam multiply all elements as follows
var product = 1
for money in moneyArray {
    product = product * money
}
product

//Lets use Reduce functions
sum = moneyArray.reduce(0, {
    $0 + $1
    })

product = moneyArray.reduce(1, {
    $0 * $1
})

// We can take advantage of the fact that operators are methods in Swift and make using reduce even more convenient
sum = moneyArray.reduce(0,+)
product = moneyArray.reduce(1, *)


/********************************************************
//Always use let. Try to avoid var
*********************************************************/
class Point {
    var x: Float
    var y: Float
    
    init(x: Float, y: Float) {
        self.x = x
        self.y = y
    }
    
    func doOperation(){
        self.x = 20
    }
    func valueOfX() -> Float{
        return self.x
    }
}

// Example usage
var point = Point(x: 100, y: 200)
var x = point.valueOfX()
point.doOperation()
x = point.valueOfX()



class PointAlt {
    let x: Float
    let y: Float
    
    init(x: Float, y: Float) {
        self.x = x
        self.y = y
    }
    func doOperation(){
        //want to change the instance variable values so that it can be used in another function
        //self.x = 20
    }
    func valueOfX() -> Float{
        return self.x
    }
}

// Example usage
var pointAlt = PointAlt(x: 100, y: 200)
var xValue = pointAlt.valueOfX()
pointAlt.doOperation()
xValue = pointAlt.valueOfX()

/********************************
Swift: Identity Operators
1. Because classes are reference types, it is possible for multiple constants and variables to refer to the same single instance of a class behind the scenes
2. The same is not true for structures and enumerations, because they are value types and are always copied when they are assigned to a constant or variable, or passed to a function
3. It can sometimes be useful to find out if two constants or variables refer to exactly the same instance of a class. To enable this, Swift provides two identity operators:
    a. Identical to (===)
    b. Not identical to (!==)
**********************************/

var pt:[Point] = [Point(x: 100, y: 200), Point(x: 10, y: 20)]
var p: Point = pt[0]

for pointData in pt{
    if pointData === p{
        println("Matched")
    }
    else{
        println("Not Matched")
    }
    
}
//Thankfully the equal to == operator does’t work by default, so we don’t have to worry about these kind of bugs.


/*=======================================================================*/
/*=======================================================================*/
/*=======================================================================*/

//Ref: https://developer.apple.com/library/prerelease/ios/documentation/General/Reference/SwiftStandardLibraryReference/Array.html#//apple_ref/doc/uid/TP40014608-CH5-SW1

/********************************
Understanding Array
**********************************/
//1. Creation
var emptyArray = Array<Int>()
let numericArray = Array(count: 3, repeatedValue: 42)
let stringArr = Array(count: 2, repeatedValue: "Hello")
var subscriptableArray = ["zero", "one", "two", "three"]
let zero = subscriptableArray[0]
// zero is "zero"
let three = subscriptableArray[3]
// three is "three"

//subscriptableArray[4] = "new item"
//Instead, use the append() function, or the += operator.

//Subscript
let subRange = subscriptableArray[1...3]
subscriptableArray[1...2] = ["oneone", "twotwo"]

var array = [0, 1]
array.append(2)
array.append(3)

array
array.insert(9, atIndex: 0)
array

//array.insert(6, atIndex: 6)
//This will give error

let removed = array.removeAtIndex(0)
array

let removed1 = array.removeLast()
array

array.removeAll()
array

//1. count
//2. isEmpty
//3. capacity
/*******************************************/
/*******************************************/
//Algorithm
//1. sort
array = [3, 2, 5, 1, 4]
array.sort { $0 < $1 }
array

array.sort { $1 < $0 }
array

array = [3, 2, 5, 1, 4]

//2. reverse
let reversedArray = array.reverse()

//3. map
//4. reduce
//5. filter

//6. operator +=
array = [0, 1, 2]
array += 3
array += [4, 5, 6]



/********************************
Understanding String
**********************************/
//1. Initializaton/creation
let emptyString = String()
let equivalentString = ""

var string = String(count: 5, repeatedValue: Character("a"))

//2. Query a string
string = "Hello, world!"
let firstCheck = string.isEmpty

string = ""
let secondCheck = string.isEmpty

string = "Hello, world"
let firstCheck1 = string.hasPrefix("Hello")
let secondCheck1 = string.hasPrefix("hello")

string = "Hello, world"
let firstCheck2 = string.hasSuffix("world")

let secondCheck2 = string.hasSuffix("World")

//3. Changing and Converting Strings
let baseString = "hello world"
let uppercaseString = baseString.uppercaseString
let lowercaseString = uppercaseString.lowercaseString

//4. toInt()
string = "42"
if let number = string.toInt() {
    println("Got the number: \(number)")
} else {
    println("Couldn't convert to a number")
}
//5. Operator
let combination = "Hello " + "world"
let exclamationPoint: Character = "!"
let charCombo = combination + exclamationPoint
let extremeCombo = exclamationPoint + charCombo

string = "Hello "
string += "world!"

let string1 = "Hello world!"
let string2 = "Hello" + " " + "world" + "!"
let result = string1 == string2
// result is true

let string11 = "Number 3"
let string22 = "Number 2"

let result1 = string11 < string22
// result1 is false

let result2 = string22 < string11



/********************************
Understanding Dictionary
**********************************/
//1. Creation of object
var emptyDictionary = Dictionary<String, Int>()

//2. Accessing elements
var dictionary = ["one": 1, "two": 2, "three": 3]
let value = dictionary["two"]

if let unwrappedValue = dictionary["three"] {
    println("The integer value for \"three\" was: \(unwrappedValue)")
}

dictionary["three"] = 33

//remove a value for key by assigning a nil value
dictionary["three"] = nil

//insert or update - updateValue
if let unwrappedPreviousValue = dictionary.updateValue(33, forKey: "three") {
    println("Replaced the previous value: \(unwrappedPreviousValue)")
} else {
    println("Added a new value")
}

dictionary = ["one": 1, "two": 2, "three": 3]
let previousValue = dictionary.removeValueForKey("two")

//remove all
dictionary.removeAll()

//Error, while removing from a constant dictionary
//let constantDictionary = ["one": 1, "two": 2, "three": 3]
//constantDictionary.removeAll()

//Querying a dictionary
dictionary = ["one": 1, "two": 2, "three": 3]
let elementCount = dictionary.count

//dictionary.keys => returns a array of keys
dictionary = ["one": 1, "two": 2, "three": 3]
for key in dictionary.keys {
    println("Key: \(key)")
}

//dictionary.values => returns a array of values
for value in dictionary.values {
    println("Key: \(value)")
}

//Operators
//1. ==
let dictionary1 = ["one": 1, "two": 2]
var dictionary2 = ["one": 1]
dictionary2["two"] = 2
let result12 = dictionary1 == dictionary2

//!=
let dictionary3 = ["one": 1, "two": 2]
let dictionary4 = ["one": 1]
let result34 = dictionary3 != dictionary4


/********************************
Understanding Numeric Types
**********************************/
//1. Boolean type - Bool
// true or false

//2. Integer Type - Int
//t holds 32 bits on 32-bit platforms, and 64 bits on 64-bit platforms
/*
Type            min val                         max val
Int8            -128                            127
Int16           -32,768                         32,767
Int32           -2,147,483,648                  2,147,483,647
Int64           -9,223,372,036,854,775,808      9,223,372,036,854,775,807
UInt8           0                               255
UInt16          0                               65,535
UInt32          0                               4,294,967,295
UInt64          0                               18,446,744,073,709,551,615
*/

//3. The primary floating-point type in Swift is Double
//   Float - 32 bit
//   Double - 64 bit
//


/********************************
Understanding Protocols
**********************************/
//1. Equatable
//The Equatable protocol makes it possible to determine whether two values of the same type are considered to be equal.
struct MyStruct1: Equatable{
    var name = "Untitled"
}
func == (lhs: MyStruct1, rhs: MyStruct1) -> Bool {
    return lhs.name == rhs.name
}

var value1 = MyStruct1()
var value2 = MyStruct1()
let firstcheck = value1 == value2

value2.name = "A New Name"
let secondcheck = value1 == value2


//2. Comparable
//The Comparable protocol makes it possible to compare two values of the same type
//There is one required operator overload defined in the protocol (<), as well as one defined in the inherited Equatable protocol (==)
//By adopting the Comparable protocol and adding an operator overload for <, you automatically gain the ability to use >, <=, and >=
struct MyStruct: Comparable {
    var name = "Untitled"
}

func < (lhs: MyStruct, rhs: MyStruct) -> Bool {
    return lhs.name < rhs.name
}
// and == operator overload too
func == (lhs: MyStruct, rhs: MyStruct) -> Bool {
    return lhs.name == rhs.name
}

let value11 = MyStruct()
var value22 = MyStruct()
let firstcheck1 = value11 < value22
// firstCheck is false

value22.name = "A New Name"
let secondcheck2 = value22 < value11
// secondCheck is true

//3. Printable
//The Printable protocol allows you to customize the textual representation of any type ready for printing (for example, to Standard Out)
//
struct MyType: Printable {
    var name = "Untitled"
    var description: String {
    return "MyType: \(name)"
    }
}

let value111 = MyType()
println("Created a \(value111)")
// prints "Created a MyType: Untitled"


/********************************
Understanding Free Functions
**********************************/
//1. Printing
print("Hello, world!\n")
println("Hello, world!")


//2. Algorithms
//Sorting: Use this method to sort a mutable array in place using the standard < operator. All values in the array must be of types that conform to the Comparable protocol, which inherits from the Equatable protocol
var randomArray = [5, 1, 6, 4, 2, 3]
randomArray.sort{ $1 < $0 }
randomArray

randomArray = [5, 1, 6, 4, 2, 3]
var res = randomArray
res.sort{ $0 < $1 }
randomArray

let constantArray = [5, 1, 6, 4, 2, 3]
constantArray.sort{ $1 < $0 }
constantArray


/*=======================================================================*/
/*=======================================================================*/
/*=======================================================================*/

/********************************
Concept of Functional Programming
**********************************/
/*
Computation as the evaluation of mathematical functions and avoids state and mutable data

Functional programming emphasizes functions that produce results that depend only on their inputs and not on the program state. No side effect. This is known as pure mathematical functions


Functional programming has its roots in lambda calculus

Imperative programming changes state and can have side effects.

Concepts:
=========
1) First-class and higher-order functions
=> Higher-order functions are functions that can either take other functions as arguments or return them as results
Example: map, filter, reduce

=> Higher-order functions are closely related to first-class functions.

=> “higher-order" describes a mathematical concept of functions that operate on other functions
=> "first-class" is a computer science term that describes programming language entities that have no restriction on their use

Currying: Higher-order functions enable partial application or currying, a technique in which a function is applied to its arguments one at a time, with each application returning a new function that accepts the next argument. This allows one to succinctly express, for example, the successor function as the addition operator partially applied to the natural number one

function(a, b)
function(a)
function(b) = > This will return the value of function(a, b)


2) Pure functions: No side effects

3) Recursion

4) Strict vs. Non-Strict evaluation
=> strict: Eager evaluation
=> non-strict: Lazy evaluation - Lazy evaluation does not evaluate function arguments unless their values are required to evaluate the function call itself

example: print length([2+1, 3*2, 1/0, 5-4])
a) strict evaluation: It will fail due to division by zero
b) lazy evaluation: returns value 4.i.e. number of items in the list

5) Type Systems - Automatic type inference



Functional Programming in imperative languages
===============================================
Some languages added functional part


Comparison with imperative programming
======================================
Sometimes, we need to maintain the state of the object e.g. maintaining a bank account balance

Pure functional programming language supports different mechanism to achieve it. For Haskeel, it provides them using monads.

Monads offer a way to abstract certain types of computational patterns, including modeling of computations with mutable state (and other side effects such as I/O) in an imperative manner without losing purity

Impure functional languages usually include a more direct method of managing mutable state e.g. Clojure

This kind of approach enables mutability while still promoting the use of pure functions as the preferred way to express computations

Efficiency
==========
Functional programming languages are typically less efficient in their use of CPU and memory than imperative languages such as C and Pascal

This is related to the fact that some mutable data structures like arrays have a very straightforward implementation using present hardware

Flat arrays may be accessed very efficiently with deeply pipelined CPUs, prefetched efficiently through caches (with no complex pointer-chasing), or handled with SIMD instructions

Lazy evaluation may also speed up the program, but it may introduces memory leaks if used improperly.

Coding Style
============

Imperative programs tend to emphasize the series of steps taken by a program in carrying out an action, while functional programs tend to emphasize the composition and arrangement of functions, often without specifying explicit steps
*/


/*
================
~~~~~~~~~~~~~~~~
Lambda Calculus
~~~~~~~~~~~~~~~~
================
Computation based on function abstraction and application using variable binding and substitution

The name derives from the letter lambda (λ) used to denote binding a variable in a function.

Important point - variable binding and substitution.

untyped lambda calculus:

typed lambda calculus: function application has no restrictions. It is claimed to be capable of computing all effectively calculable functions

The typed lambda calculus is a variety that restricts function application, so that functions can only be applied if they are capable of accepting the given input's "type" of data

functional programming languages, which essentially implement the lambda calculus (augmented with some constants and datatypes)

1)
The first simplification is that the λ-calculus treats functions "anonymously", without giving them explicit names

sqsum(x, y) = x*x + y*y
can be rewritten in anonymous form as

(x, y) -> x*x + y*y

We can read it as pair of x and y

id(x) = x
It can be written as x -> x

2)
λ-calculus only uses functions of a single input

An ordinary function that requires two inputs can be reworked into an equivalent function that accepts a single input, and as output returns another function, that in turn accepts a single input. This concept is known as currying

(x, y) -> x*x + y*y
can be rewritten as
x -> (y -> x*x +y*y)

Example (5,2)
((x -> (y -> x*x +y*y))(5))(2)
= (y -> 5*5 + y*y)(2)
= 5*5 + 2*2
= 29
We need to have one more steps to evaluate it as part of lambda calculus principle

----------
Lambda calculus defines some terms or rule - lambda terms. It consists of syntax, transformation rules

1) variable ,x, is itself a valid lambda term
2) if t is a lambda term, and x is a variable, then lambda(x).t is a lambda term. This is known as: lambda abstraction
3) if t and s are lambda terms, then (ts) is a lambda term. This is known as application

First class function: A function operates on another function
A higher-order function—it takes a single-argument function f, and returns another single-argument function

There are several notions of "equivalence" and "reduction" that allow lambda terms to be "reduced" to "equivalent" lambda terms.

Bounded Variables - Alpha equivalence: For instance, lambda(x.x) and lambda(y.y) are alpha-equivalent lambda terms, and they both represent the same function (the identity function). The terms x and y are not alpha-equivalent, because they are not bound in a lambda abstraction.

Free Variable: The free variables of a term are those variables not bound by a lambda abstraction



Reductions: The meaning of lambda expressions is defined by how expressions can be reduced
α-conversion: changing bound variables (alpha);
β-reduction: applying functions to their arguments (beta);
η-conversion: which captures a notion of extensionality (eta).


Substitution:written E[V := R], is the process of replacing all free occurrences of the variable V in the expression E with expression R.

Normal Forms and confluence: Abstract rewriting.
For the untyped lambda calculus, β-reduction as a rewriting rule is neither strongly normalising nor weakly normalising.

However, it can be shown that β-reduction is confluent. (Of course, we are working up to α-conversion, i.e. we consider two normal forms to be equal, if it is possible to α-convert one into the other.)

Logic and predicates - Bool etc

Pairs - tuples

Recursion and fixed points:
Recursion is the definition of a function using the function itself
Lambda calculus does not allow this (we can't refer to a value which is yet to be defined, inside the lambda term defining that same value, as all functions are anonymous in lambda calculus)

However, this impression is misleading. It can be arranged to receive itself as its argument value, through self-application
F(n) = 1, if n = 0; else n × F(n − 1)

In Lambda calculus - to achieve recursion, the intended-as-self-referencing argument (r - in below example) must always be passed to itself within the function body, at a call point:

G := λr. λn.(1, if n = 0; else n × (r r (n−1)))
with  r r x = F x = G r x  to hold, so  r = G  and
F := G G = (λx.x x) G


Typed Lambda Calculus : Functional programming language

Parallelism and concurrency
===========================
Lambda calculus means that evaluation (β-reduction) can be carried out in any order, even in parallel. This means that various nondeterministic evaluation strategies are relevant.However, the lambda calculus does not offer any explicit constructs for parallelism. One can add constructs such as Futures to the lambda calculus for this purpose

*/

/*
Functional programming features not supported in Swift
=======================================================
1. Tail Call Optimisation. TCO is supported under certain circumstances though. Under maximum optimisation if ARC allows.

2. Pure Functions

3. Recursion — You can actually do recursion in Swift. However since there is no tail call optimisation, it is risky to use recursion. But you can safely use recursion if you are sure the depth of recursion is not in the magnitude of tens of thousands. Eg. you could use recursion for traversing tree structures like DOM, XML, JSON.
*/


















