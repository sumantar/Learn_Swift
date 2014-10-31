// Playground - noun: a place where people can play

import UIKit

var str = "Hello, playground"

///////////////////////////////
// Optional
// Non-optional type can't be nil
// Wrapped with a value
// missing values are nil
// Present values are wrapped in an optional
// When we use the value, we need to unwrap the variable
// 1. Use forced unwrapping operator (!) only if we are sure
// 2. Use 'if let' optional binding to test and unwrap at the same time
// 3. Optional chaining (?) is a concise way to work with chained optionals
//////////////////////////////

var age:Int? = nil
age = 10

var ageIncreament = age! * 2

func findIndexOfString(string: String, array: [String]) -> Int?{
    for(index, value) in enumerate(array){
        if value == string{
            return index
        }
    }
    return nil
}

var neighbors = ["Alex", "Anna", "Madission", "Dave"]
let indexOfString:Int? = findIndexOfString("Madission",neighbors)

//Optional binding
//Test and unwrap at the same time

let index = findIndexOfString("Anna", neighbors)

if let indexValue = index{ //here indexValue unwrap and test
    let print = "Hello, \(neighbors[indexValue])"
}
else{
    let print = "Must have moved away"
}

class Person{
    var residence: Residence?
}

class Residence{
    var address: Address?
}

class Address{
    var buildingNumber: String?
    var streetName: String?
    var apartmentNumber: String?
}

let paul = Person() //It will be nil

var addressNumber: Int?

if let home = paul.residence{
    if let postalAddress = home.address{
        if let building = postalAddress.buildingNumber{
            if let convertedNumber = building.toInt(){
                
            }
        }
    }
}

//The above code snippet can be reduced to single line
// chained optional
addressNumber = paul.residence?.address?.buildingNumber?.toInt()

///////////////////////////////
// ARC
// 1. Use strong refernces from owners to the objects they own 
// 2. Use weak references among objects with independent life time. Breaking cycles
// 3. Use unowned references from owned objects with the same life time
//////////////////////////////

/*

//Ownership issues. This will leak the memory with cyclic dependancy
class Apartement{
    var tenant: PersonClass?
}

class PersonClass{
    var home: Apartement?
    
    func moveIn(apt: Apartement){
        self.home = apt
        apt.tenant = self
    }
}

var renters = ["Hari": PersonClass()]
var apts = [507: Apartement()]

renters["Hari"]!.moveIn(apts[507]!)

renters["Hari"] = nil

*/

// We will provide weak reference to fix the ownership issue

class Apartement{
    weak var tenant: PersonClass?
}

class PersonClass{
    weak var home: Apartement?
    
    func moveIn(apt: Apartement){
        self.home = apt
        apt.tenant = self
    }
}

var renters = ["Hari": PersonClass()] //Dictionay
var apts = [507: Apartement()] //Dictionay

renters["Hari"]!.moveIn(apts[507]!)

renters["Hari"] = nil

// weak references are optional values
// binding the optional produces a strong reference

if let tenant = apts[507]!.tenant{
    //tenant is the strong reference
}

//testing a weak reference does not produce a srong reference

var apt = apts[507]!

if (apt.tenant != nil){
    /*
    apt.tenant!.cashRentCheck()
    apt.tenant!.greet()
    */
}

// Use unowned references from owned objects with the same life time

class Person1{
    var card: CreditCard?
    
}

class CreditCard{
    unowned let holder: Person1
    
    init(holder: Person1){
        self.holder = holder
    }
}

///////////////////////////////
// Initialization
// Every value must be initialized before it is used
// Forced by the compiler
// 1. Designated Initializers
//  Designated initializers are the primary initializers for a class. A designated initializer fully initializes all properties introduced by that class and calls an appropriate superclass initializer to continue the initialization process up the superclass chain.
//  A class must have atleast one designated initializer

// 2. Convenience Initializers
//  Convenience initializers are secondary, supporting initializers for a class. You can define a convenience initializer to call a designated initializer from the same class as the convenience initializer with some of the designated initializer’s parameters set to default values. You can also define a convenience initializer to create an instance of that class for a specific use case or input value type
//  You do not have to provide convenience initializers if your class does not require them

// 3. Initialization chaining rule:
// Rule-1: Designated initializers must call a designated initializer from their immediate superclass
// Rule-2: Convenience initializers must call another initializer available in the same class
// Rule-3: Convenience initializers must ultimately end up calling a designated initializer
// Summary:
// Designated initializers must always delegate up.
// Convenience initializers must always delegate across.

// subclasses do not not inherit their superclass initializers by default. However, superclass initializers are automatically inherited if certain conditions are met. In practice, this means that you do not need to write initializer overrides in many common scenarios, and can inherit your superclass initializers with minimal effort whenever it is safe to do so
// Assuming that you provide default values for any new properties you introduce in a subclass, the following two rules apply:
// Rule-1: If your subclass doesn’t define any designated initializers, it automatically inherits all of its superclass designated initializers
// Rule-2: If your subclass provides an implementation of all of its superclass designated initializers—either by inheriting them as per rule 1, or by providing a custom implementation as part of its definition—then it automatically inherits all of the superclass convenience initializers
//***********************
//***********************
// Note: 
// 1. Initialize all values before use them
// 2. set all stored propties first, then call super.init
// 3. Designated initializers only delegate up
// 4. Convenience initializers only delegate across
// 5. Use deinitializer, when we need it
//***********************
//***********************

//////////////////////////////

//class initiaization
class MyClass{
    init(luckyNumber: Int, message:String)
    {
        
    }
}

let instance = MyClass(luckyNumber: 42, message: "Not today")

//Structure initialization
struct Color{
    let red, green, blue: Double
    init(grayScale: Double){
        red = grayScale
        green = grayScale
        blue = grayScale
    }
}
//memberwise initializers
//let magenta = Color(red:1.0, green: 0.0, blue:1.0)

//Convenience Initializers
class Car{
    var color: Color
    init(color: Color){
        self.color = color
    }
}

class RaceCar: Car{
    var hasTurbo: Bool
    
    init(color: Color, turbo: Bool){
        hasTurbo = turbo
        super.init(color: color)
    }
    
    convenience override init(color: Color) {
        self.init(color: color, turbo: true)
    }
    convenience init(){
        self.init(color: Color(grayScale: 0.4))
    }
}

//Lazy Properties
//keyword: @lazy

/*
class Game{
    @lazy var multiplayerManager: MultiplayerManager()
    var singlePlayer: Player?
    func beginGaameWithPlayers(players: Player...){
        if players.count == 1{
            singlePlayer = players[0]
        }
        else{
            for player in players{
                multiplayerManager.addPlayer(player)
            }
        }
    }
    
}
*/

//Deinitialization
//keyword: deinit

/*
class FileHandle{
    let fileDescriptor: FileDescriptor
    init(path: String){
        fileDescriptor = openFile(path)
        
    }
    deinit{
        closeFile(fileDescriptor)
    }
}
*/


///////////////////////////////
// Closure: Closures are self-contained blocks of functionality that can be passed around and used in your code
// It is similar to blocks in objective-c. lamda in other programming language
// Function is a special case of closure
//
// We can write a closure without a name by surrounding code with braces ({}). Use "in" to separate the arguments and return type from the body
//
// Closures can capture and store references to any constants and variables from the context in which they are defined

//Syntax:
/*
{ (parameters) -> (return type) in
    (statements)
}
*/

//////////////////////////////

var clients = ["Ram", "Hari", "Gopal", "Shyam"]
clients.sort({(a: String, b: String) -> Bool in
     return a < b
    })

let sortedClients = clients

// Shorthand Arguments Names
//Swift automatically provides shorthand argument names to inline closures, which can be used to refer to the values of the closure’s arguments by the names $0, $1, $2, and so on

var clients1 = ["Ram", "Hari", "Gopal", "Shyam"]
clients1.sort({ $0 < $1})
let sortedClients1 = clients1

//Closure are ARC objects

//Capture Lists
/*
class TempNotifier{
    var onChange: (Int) -> Void = {}
    var currentTemp = 72
    init(){
        onChange = {[unowned self] temp in
            self.currentTemp = temp
        }
    }
}
*/




///////////////////////////////
// Pattern matching
// Different types of patterns:
// 1. wildcard pattern: _
// 2. identifier Pattern
// 3. Value-Binding Pattern
// 4. Tuple Pattern
// 5. Enumeration case pattern
// 6. Type casting pattern
// 7. Expression Pattern

// Switch statement form:

/*
switch <control expression> {
case <pattern 1>:
    (statements)
case <pattern 2> where <condition>:
    (statements)
case <pattern 3> where <condition>,
<pattern 4> where <condition>:
    (statements)
default:
    (statements)
}
*/

//////////////////////////////
/*
switch trainStatus{
case .OnTime:
    println("----")
case .Delayed(1):
    println("----")
case .Delayed(2...10):
    println("----")
case .Delayed(_):
    println("----")
}
*/

/*
func tuneUp(car: Car){
    switch car{
    case let formulaOne as FormulaOne:
        println("----")
    case let raceCar as RaceCar:
        println("----")
    default:
        println("----")
    }
}
*/

//Wildcard
for _ in 1...3 {
    // Do something three times.
    var x = "x"
}

// identifier Pattern
//An identifier pattern matches any value and binds the matched value to a variable or constant name. For example, in the following constant declaration, someValue is an identifier pattern that matches the value 42 of type Int:

let someValue = 42
//When the match succeeds, the value 42 is bound (assigned) to the constant name someValue.



// Value-Binding Pattern
//A value-binding pattern binds matched values to variable or constant names. Value-binding patterns that bind a matched value to the name of a constant begin with the keyword let; those that bind to the name of variable begin with the keyword var

let point = (3, 2)
switch point {
    // Bind x and y to the elements of point.
case let (x, y):
    println("The point is at (\(x), \(y)).")
}
// prints "The point is at (3, 2).”



// Tuple Pattern
// A tuple pattern is a comma-separated list of zero or more patterns, enclosed in parentheses. Tuple patterns match values of corresponding tuple types

let points = [(0, 0), (1, 0), (1, 1), (2, 0), (2, 1)]
// This code isn't valid. element 0 is an expression pattern
/*
for (x, 0) in points {
    /* ... */
}
*/

for (x, _) in points {
    /* ... */
}


let color = (1.0, 1.0, 1.0, 1.0)

switch color{
case (0.0, 0.5...1.0, let blue, _):
    println("----")
case let (r, g, b, 1.0) where r == g && g == b:
    println("----")
default:
    println("----");
}



// Enumeration case pattern
// An enumeration case pattern matches a case of an existing enumeration type. Enumeration case patterns appear only in switch statement case labels


// Type casting pattern
//There are two type-casting patterns, the is pattern and the as pattern. Both type-casting patterns appear only in switch statement case labels. The is and as patterns have the following form:

/*
// 1. is <type>
// The is pattern matches a value if the type of that value at runtime is the same as the type specified in the right-hand side of the is pattern—or a subclass of that type. The is pattern behaves like the is operator in that they both perform a type cast but discard the returned type

// 2. <apttern> as <type>
// The as pattern matches a value if the type of that value at runtime is the same as the type specified in the right-hand side of the as pattern—or a subclass of that type. If the match succeeds, the type of the matched value is cast to the pattern specified in the left-hand side of the as pattern.

// Note: 
// 1. type casting "is" - upcasting
// 2. type casting "as/as?" - downcasting
if let movie = item as? Movie {

}

*/




// Expression Pattern
// An expression pattern represents the value of an expression.
// Expression patterns appear only in switch statement case labels

let point1 = (1, 2)
switch point1 {
case (0, 0):
    println("(0, 0) is at the origin.")
case (-2...2, -2...2):
    println("(\(point1.0), \(point1.1)) is near the origin.")
default:
    println("The point is at (\(point1.0), \(point1.1)).")
}
// prints "(1, 2) is near the origin.”

/*
Special protocols implemented by Apple

LogicValue
Printable
Sequence
IntegerLiteralConvertable
FloatLiteralConvertable
StringLiteralConvertable
ArrayLiteralConvertable
DictionaryLiteralConvertable


Type casting: 'is' & 'as'
if item is Song

Any

Unlike arithmetic operators in C, arithmetic operators in Swift do not overflow by default. Overflow behavior is trapped and reported as an error.

To opt in to overflow behavior, use Swift’s second set of arithmetic operators that overflow by default, such as the overflow addition operator (&+). All of these overflow operators begin with an ampersand (&)

var willOverflow = UInt8.max // willOverflow equals 255, which is the largest value a UInt8 can hold
willOverflow = willOverflow &+ 1 // willOverflow is now equal to 0”

var willUnderflow = UInt8.min // willUnderflow equals 0, which is the smallest value a UInt8 can hold
willUnderflow = willUnderflow &- 1 // willUnderflow is now equal to 255

let x = 1
let y = x &/ 0 // y is equal to 0
============================================================================================================================================================


Bitwise operator: 
~ : bitwise NOT
let initialBits: UInt8 = 0b00001111
let invertedBits = ~initialBits  // equals 11110000

& : bitwise AND
let firstSixBits: UInt8 = 0b11111100
let lastSixBits: UInt8  = 0b00111111
let middleFourBits = firstSixBits & lastSixBits  // equals 00111100

| : bitwise OR
let someBits: UInt8 = 0b10110010
let moreBits: UInt8 = 0b01011110
let combinedbits = someBits | moreBits  // equals 11111110

^ : bitwise XOR
let firstBits: UInt8 = 0b00010100
let otherBits: UInt8 = 0b00000101
let outputBits = firstBits ^ otherBits  // equals 00010001

>> and << : bitwise Shift
let shiftBits: UInt8 = 4   // 00000100 in binary
shiftBits << 1             // 00001000
shiftBits << 2             // 00010000
shiftBits << 5             // 10000000
shiftBits << 6             // 00000000
shiftBits >> 2             // 00000001

================================================================================================================================================================
*/


/*
Swift gives you the freedom to define your own custom infix, prefix, postfix, and assignment operators, with custom precedence and associativity values

Operator over loading.
Operator function: Classes or structure can have their own implementation of existing operator.

Example: + operator

It should be defined as a global function

*/

class Vector2D {
var x = 0.0, y = 0.0
init(x: Double, y: Double){
self.x = x
self.y = y
}
}

func + (left: Vector2D, right: Vector2D) -> Vector2D {
return Vector2D(x: left.x + right.x, y: left.y + right.y)
}

let vector = Vector2D(x: 3.0, y: 1.0)
let anotherVector = Vector2D(x: 2.0, y: 4.0)
let combinedVector = vector + anotherVector


prefix func - (vector: Vector2D) -> Vector2D {
return Vector2D(x: -vector.x, y: -vector.y)
}

let positive = Vector2D(x: 3.0, y: 4.0)
let negative = -positive

let alsoPositive = -negative

/*
Assignment operator: with the @assignment attribute. You must also mark a compound assignment operator’s left input parameter as <<inout>>, because the parameter’s value will be modified directly from within the operator function

*/
func += (inout left: Vector2D, right: Vector2D) {
left = left + right
}

var original = Vector2D(x: 1.0, y: 2.0)
let vectorToAdd = Vector2D(x: 3.0, y: 4.0)
original += vectorToAdd


///

prefix func ++ (inout vector: Vector2D) -> Vector2D {
vector += Vector2D(x: 1.0, y: 1.0)
return vector
}

var toIncrement = Vector2D(x: 3.0, y: 4.0)
let afterIncrement = ++toIncrement

//Equivalence operator
func == (left: Vector2D, right: Vector2D) -> Bool {
return (left.x == right.x) && (left.y == right.y)
}

func != (left: Vector2D, right: Vector2D) -> Bool {
return !(left == right)
}

let twoThree = Vector2D(x: 2.0, y: 3.0)
let anotherTwoThree = Vector2D(x: 2.0, y: 3.0)
if twoThree == anotherTwoThree {
println("These two vectors are equivalent.")
}



/*
Custom operators
New operators are declared at a global level using the operator keyword, and can be declared as prefix, infix or postfix:

operator prefix +++ {}

Custom infix operators can also specify a precedence and an associativity
The possible values for associativity are left, right, and none

Operator precedence gives some operators higher priority than others; these operators are calculated first
Operator associativity defines how operators of the same precedence are grouped together (or associated)—either grouped from the left, or grouped from the right


The associativity value defaults to none if it is not specified. The precedence value defaults to 100 if it is not specified.

*/



prefix operator +++ {}

prefix func +++ (inout vector: Vector2D) -> Vector2D {
vector += vector
return vector
}

var toBeDoubled = Vector2D(x: 1.0, y: 4.0)
let afterDoubling = +++toBeDoubled


infix operator +- { associativity left precedence 140 }//Defining the custom precedence

func +- (left: Vector2D, right: Vector2D) -> Vector2D {
return Vector2D(x: left.x + right.x, y: left.y - right.y)
}

let firstVector = Vector2D(x: 1.0, y: 2.0)
let secondVector = Vector2D(x: 3.0, y: 4.0)
let plusMinusVector = firstVector +- secondVector





/*
_ character is used for place hoder. it is used in place of a loop variable

protocol types like Any or Pullable throws away type information. It is great for dynamic polymorphism 
But, Swift generics, conserve type inforamtion. It is type safe and fast.

*/

//Finding an item in Array
//func indexOf<T>(sought: T,  inArray array: [T]) -> Int?{
//    for i in 0..<array.count{
//        if array[i] == sought{
//            return i
//        }
//    }
//    
//    return nil
//}

/*

Generic Vs. Protocol Constraints

*/

//func indexOf<T: Equatable>(sought: T,  inArray array: [T]) -> Int?{
//    for i in 0..<array.count{
//        if array[i] == sought{
//            return i
//        }
//    }
//    
//    return nil
//}

/*
Generics: 
inout parameters: The parameter values can be chnaged. We need to pass & in parameter name

Generic types - T: Place holder
Generic: Type Constranits - example: Dictionay. The type constraints is that all the keys are unique.
Similarly, we can add such constraints in our own generic implementation:

Syntax: Put a class or protocol constraints after a type parameter name which will be separated by a colon
//Generic type constraints
func someFunction<T: SomeClass, U: SomeProtocol>(someT: T, someU: U) {
// function body goes here
}

*/

//Find the index of the string array
func findStringIndex(array: [String], valueToFind: String) -> Int? {
    for (index, value) in enumerate(array) {
        if value == valueToFind {
            return index
        }
    }
    return nil
}


//Lets have the generic implementation
/*
func findIndex<T>(array: [T], valueToFind: T) -> Int?{
    for(index, value) in enumerate(array){
        if value == valueToFind{
            return index
        }
    }
    
    return nil
}
*/

//The above function will generate error: can't compare the custom values
//Solution: Equatable protocol

/*
Special protocols implemented by Apple

LogicValue
Printable
Sequence
IntegerLiteralConvertable
FloatLiteralConvertable
StringLiteralConvertable
ArrayLiteralConvertable
DictionaryLiteralConvertable
*/


func findIndex<T: Equatable>(array: [T], valueToFind: T) -> Int?{
    for(index, value) in enumerate(array){
        if value == valueToFind{
            return index
        }
    }
    
    return nil
}

let doubleIndex = findIndex([3.14159, 0.1, 0.25], 9.3)
let stringIndex = findIndex(["Mike", "Malcolm", "Andrea"], "Andrea")


/*
Associated Types: When defining a protocol, it is sometimes useful to declare one or more associated types as part of the protocol’s definition
It is specified with a typealias keyword

*/

protocol Container {
    typealias ItemType
    mutating func append(item: ItemType)
    var count: Int { get }
    subscript(i: Int) -> ItemType { get }
}

//When we implement the protocol, we can specify the associated type. However, Swifts type inference takes care about it. Hence we can ignore to specify the associated type

struct IntStack: Container {
    
    // original IntStack implementation
    var items = [Int]()
    
    mutating func push(item: Int) {
        items.append(item)
    }
    
    mutating func pop() -> Int {
        return items.removeLast()
    }
    // conformance to the Container protocol. This is not required as Swifts type inference takes care about it.
    //Hence, we can comment this line
    //typealias ItemType = Int
    
    
    mutating func append(item: Int) {
        self.push(item)
    }
    
    var count: Int {
        return items.count
    }
    
    subscript(i: Int) -> Int {
        return items[i]
    }
}

//Here is a generic implementation
struct Stack<T>: Container{
    
    var items = [T]()
    
    mutating func push(item: T){
        items.append(item)
    }
    
    
    mutating func pop() -> T {
        return items.removeLast()
    }
    
    mutating func append(item: T) {
        self.push(item)
    }
    
    var count: Int {
    return items.count
    }
    
    subscript(i: Int) -> T {
        return items[i]
    }
}

/*
As explained type constraints, it will be useful to define a requiement for associated types
We Can use, where clause for this.

*/
func allItemsMatch<C1: Container, C2: Container where C1.ItemType == C2.ItemType, C1.ItemType: Equatable> (someContainer: C1, anotherContainer: C2) -> Bool {
        
    // check that both containers contain the same number of items
    if someContainer.count != anotherContainer.count {
        return false
    }
    
    // check each pair of items to see if they are equivalent
    for i in 0..<someContainer.count {
        if someContainer[i] != anotherContainer[i] {
            return false
        }
    }
    
    // all items match, so return true
    return true
        
}


var stackOfStrings = Stack<String>()
stackOfStrings.push("uno")
stackOfStrings.push("dos")
stackOfStrings.push("tres")


var arrayOfStrings = Stack<String>()
stackOfStrings.push("uno")
stackOfStrings.push("dos")
stackOfStrings.push("tres")
stackOfStrings.push("tres1")

//var arrayOfStrings = ["uno", "dos", "tres"]

if allItemsMatch(stackOfStrings, arrayOfStrings) {
    println("All items match.")
    let res = "All items match."
} else {
    println("Not all items match.")
    let res = "Not All items match."
}


/*
LogicValue: Protocol

The under-the-covers method that Swift uses to turn non-Bool values in booleans for use in if statements is the getLogicValue() method of the LogicValue protocol (which Optional implements):

func hasLogin() -> Bool {
    return self.credential.getLogicValue()
}
*/

/*
Using protocol value
we can use 'as' for downcasting

*/
//func protocolValue(object: Thing){
//    if let pullableObject = object as Pullable{
//        //pull it
//    }
//    else{
//        //error
//    }
//}

/*

Approximation

*/

//Fibonaci Series: 0,1,1,2,3,5,8,13,
func fibonaci(n: Int) -> Double{
    return n < 2 ? Double (n):fibonaci(n-1)+fibonaci(n-2)
}

let fibo = fibonaci(1)
//let phi = fibonaci(45)/fibonaci(44)

//Manual memorization
//This is an example of tail recursion or TOC

var fibonaciMemo = Dictionary<Int, Double>()
//returns the nth fibonaci number: 0,1,1,2,3,5,8,13,21...
func fibinaciM(n: Int)->Double{
    if let result = fibonaciMemo[n]{
        return result
    }
    else{
        let result = n < 2 ? Double (n):fibinaciM(n-1)+fibinaciM(n-2)
        fibonaciMemo[n] = result
        return result
    }
}

//let fibiRes = fibinaciM(46)
//let phi = fibinaciM(45)/fibinaciM(44)

//Automatic memorization using closure
//let fibonacciAM: (Int)->Double = memoize{
//    (fibonacciAM, n) in
//    n < 2 ? Double (n):fibonacciAM(n-1)+fibonacciAM(n-2)
//}

/*Similarly we can implement similar method to parse a plist file, returning a NSString type*/

//Lets implement this function that takes ONE parameter
/*
func memoize<T: Hashable, U>(body: (T)->U ) -> (T)->U{
    var memo = Dictionary<T,U>()
    return { x in
        if let q = memo[x]{ return q }
        let r = body(x)
        memo[x] = r
        return r
    }
}

var factorial: (Int)->Int = {$0}
factorial = memoize{x in x == 0 ? 1:x*factorial(x - 1)}
let fact = factorial(3)
*/
//Lets implement this function that takes TWO parameter
func memoize<T: Hashable, U>( body: ( (T)->U, T )->U ) -> (T)->U {
    var memo = Dictionary<T, U>()
    var result: ((T)->U)!
    result = { x in
        if let q = memo[x] { return q }
        let r = body(result, x)
        memo[x] = r
        return r
    }
    return result
}

/*
let fibonacci = memoize {
    fibonacci, n in
    n < 2 ? Double(n) : fibonacci(n-1) + fibonacci(n-2)
}

//let finalRes = fibonacci(45)/fibonacci(44)

let factorial = memoize { factorial, x in x == 0 ? 1 : x * factorial(x - 1) }
let finalResult = factorial(3)

*/







































