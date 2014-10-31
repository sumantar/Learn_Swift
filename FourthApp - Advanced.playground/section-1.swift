// Playground - noun: a place where people can play

import UIKit

var str = "Hello, playground"

/////////////////////////
//Some more features on
// Sequence
//////////////////////////

/*
Sequence in Swift
*/
/*
References:
https://medium.com/swift-programming/sequence-beyond-primitive-iterations-in-swift-80bc2507d8cc
http://natashatherobot.com/swift-conform-to-sequence-protocol/
http://www.scottlogic.com/blog/2014/06/26/swift-sequences.html

*/


/*
Iterations
One fundamental brick in programming is iterations.
Swift also offers a more modern syntax for for/in with Range Operators
*/

//prints 0 to 9
for x in 0..<10 {
    println("\(x)")
}

//prints 0 to 9
for x in 0...10 {
    println("\(x)")
}

//Sequence protocol
//In Swift, Strings, Arrays, Dictionaries implements the Sequence-protocol. How do we implement in our own data type.
//Apple doesn't document it properly. However, I have found out some information by doint it.

import Swift

//Go to the defination of Swift
//Here is the defination of protocol defined by Apple
/*
protocol SequenceType : _Sequence_Type {
typealias Generator : GeneratorType
func generate() -> Generator
}

This is the comment for GeneratorType

/// A `GeneratorType` is notionally a `SequenceType` that is consumed
/// when iterated.
///
/// While it is safe to copy a `GeneratorType`, only one copy should be advanced
/// with `next()`.
///
/// If an algorithm requires two `GeneratorType`\ s for the same
/// `SequenceType` to be advanced at the same time, and the specific
/// `SequenceType` type supports that, then those `GeneratorType`
/// objects should be obtained from `SequenceType` by two distinct
/// calls to `generate().  However in that case the algorithm should
/// probably require `CollectionType`, since `CollectionType` implies
/// multi-pass.
protocol GeneratorType {

/// The type of which `Self` is a generator.
typealias Element

/// If all elements are exhausted, return `nil`.  Otherwise, advance
/// to the next element and return it.
///
/// Note: after `next()` on an arbitrary generator has returned
/// `nil`, subsequent calls to `next()` have unspecified behavior.
/// Specific implementations of this protocol are encouraged to
/// respond by calling `preconditionFailure("...")`.
mutating func next() -> Element?
}

*/

//In summary, we need to implement, generate method.
//What generate() does is that it returns a Type that implements Generator Protocol and call next() (which will return and remove first object from collection). This is repeated until it reaches nil
/*
Lets have a sample implementation
When we have a webservice call, we create a model object - MyItem.
Then a list contains all items provided by Webservice

*/

class MyItem {
    let name:String = ""
    let priority:Int = 0
    
    init (name: String, priority: Int){
        self.name = name
        self.priority = priority
    }
}

let item1 = MyItem(name: "abc", priority: 1)
let item2 = MyItem(name: "def", priority: 2)


//Lets define the collection class
class Items: SequenceType{
    var items: [MyItem] = []
    func addItem(item: MyItem){
        items.append(item)
    }
    
    //Now we need to implement generate method
    func generate()-> GeneratorOf<MyItem> {
        var i = 0
        return GeneratorOf<MyItem> {
            return i >= self.items.count ? .None : self.items[i++]
        }
    }
}

//Note: .None is nil i.e. end of the iterator

let items = Items()
items.addItem(item1)
items.addItem(item2)


//Now we can iterate in the array
for item in items{
    println("item: \(item.name), \(item.priority)")
}

//Define a generic generator
struct GenericGenerator<T>: GeneratorType {
    var items: [T]
    mutating func next() -> T? {
        return items.isEmpty ? .None : items.removeAtIndex(0)
    }
}

//Lets define the collection class
class ModifiedItems: SequenceType{
    var collectonItems: [MyItem] = []
    func addItem(item: MyItem){
        collectonItems.append(item)
    }
    
    //Now we need to implement generate method
    func generate() -> GenericGenerator<MyItem> {
        return GenericGenerator(items: collectonItems)
    }
}

let modifiedItems = ModifiedItems()
modifiedItems.addItem(item1)
modifiedItems.addItem(item2)

//Now iterate
for item in modifiedItems{
    println("item: \(item.name) \(item.priority)")
}

/////////////////////////
//Some more features on
// Boolean
//////////////////////////

/*
Blogs:

https://developer.apple.com/swift/blog/

*/

/*
LogicValue -> it is changed to BooleanType
*/
//https://developer.apple.com/swift/blog/?id=8
//https://developer.apple.com/swift/blog/?id=8


/// Protocol describing types that can be used as logical values within
/// a condition.
///
/// Types that conform to the `BooleanType` protocol can be used as
/// condition in various control statements (`if`, `while`, C-style
/// `for`) as well as other logical value contexts (e.g., `case`
/// statement guards).
//protocol BooleanType {
//    var boolValue: Bool { get }
//}

//Lets have our own model structure that can be either true or false.
//By default it should return false
enum MyBool{
    case myTrue, myFalse
}

extension MyBool{
    init(){
        self = .myFalse
    }
}

//Operator overloading
//We need to move it to another file or begining else we will get errors
func ==(lhs: MyBool, rhs: MyBool) -> Bool {
    switch (lhs, rhs) {
    case (.myTrue,.myTrue), (.myFalse,.myFalse):
        return true
    default:
        return false
    }
}

//Lets have some more opeartor overloading


//Swift enum declarations implicitly scope their enumerators within their body, allowing us to refer to MyBool.myFalse and even .myFalse when a contextual type is available

//Lets ensure that our type should work with premitive type true and false
//Then it should confirm to BooleanLiteralConvertible
/*
protocol BooleanLiteralConvertible {
    typealias BooleanLiteralType
    class func convertFromBooleanLiteral(value: BooleanLiteralType) -> Self
}
*/

extension MyBool: BooleanLiteralConvertible{
    static func convertFromBooleanLiteral(value: Bool) -> MyBool{
        return value ? myTrue : myFalse
    }
}

let a : MyBool = true
/*
if a{
    println(" TRUE ")
}
*/
//This will throw error as 'MyBool' does not confirm to protocol 'BooleanType'

/*
/// Protocol describing types that can be used as logical values within
/// a condition.
///
/// Types that conform to the `BooleanType` protocol can be used as
/// condition in various control statements (`if`, `while`, C-style
/// `for`) as well as other logical value contexts (e.g., `case`
/// statement guards).
protocol BooleanType {
    var boolValue: Bool { get }
}
*/
extension MyBool : BooleanType{
    var boolValue: Bool{
        switch self{
        
        case .myTrue: return true
        case .myFalse: return false
            
        }
    }
}



if a{
    println(" TRUE ")
}

//anything that conforms to BooleanType to be castable to MyBool
extension MyBool{
    init(_ v : BooleanType){
        if v.boolValue{
            self = .myTrue
        }
        else{
            self = .myFalse
        }
    }
}

var basicBool : Bool = true
let b = MyBool(basicBool)

//Note that the use of _ in the initializer argument list disables the keyword argument, which allows the MyBool(x) syntax to be used instead of requiring MyBool(v: x)

//Lets implement comparision of two boolean values. Lets implement it.
//We should use protocol <Equatable>
extension MyBool: Equatable{
    
}

//operator overloading '=='
if a == a {
    println("Objects are equals")
}
if a != a {
    println("Objects are NOT equals")
}

//Lets have some more opeartor overloading

func &(lhs: MyBool, rhs: MyBool) -> MyBool {
    if lhs {
        return rhs
    }
    return false
}

func |(lhs: MyBool, rhs: MyBool) -> MyBool {
    if lhs {
        return true
    }
    return rhs
}

func ^(lhs: MyBool, rhs: MyBool) -> MyBool {
    return MyBool(lhs != rhs)
}

prefix func !(a: MyBool) -> MyBool {
    return a ^ true
}

// Compound assignment (with bitwise and)
func &=(inout lhs: MyBool, rhs: MyBool) {
    lhs = lhs & rhs
}


/////////////////////////
//Some more features on 
// Optionals Case Study
//////////////////////////
/*The nil coalescing operator (a ?? b) unwraps an optional a if it contains a value, or returns a default value b if a is nil. The expression a is always of an optional type. The expression b must match the type that is stored inside a.

a != nil ? a! : b

This looks similar to ternary operator.

*/

let defaultColorName = "red"
var userDefinedColorName: String?   // defaults to nil”
var colorNameToUse = userDefinedColorName ?? defaultColorName
// userDefinedColorName is nil, so colorNameToUse is set to the default of "red

userDefinedColorName = "green"
colorNameToUse = userDefinedColorName ?? defaultColorName
// userDefinedColorName is not nil, so colorNameToUse is set to "green”


////////////////////////////////////////////////////////////////
/*
Lets hava a use case where we want to add an additional method to Dictionary class.
In Objective-C, NSDictionary has a method -objectsForKeys:notFoundMarker: that takes an NSArray of keys, and returns an NSArray of corresponding values. If key is not present, then, it will return "notFoundMaker" object.

Actually, in swift we don't need this method as we can use map functions. Lets implement it in swift for our case study.



*/


/*
extension Dictionary{
    func valueForKeys(keys:[Key], notFoundMarker: Value) -> [Value]{
        
    }
}
*/
//In Swift, the stronger typing restricts the resulting array to contain only a single type of element — we can’t put NSNull in an array of strings. However, Swift gives an even better option: we can return an array of optionals. All our values get wrapped in optionals, and instead of NSNull, we just use nil
//Hence optionals are strong types unlike objective-c

extension Dictionary{
    func valuesForKeys(keys: [Key]) -> [Value?]{
        var result = [Value?]()
        result.reserveCapacity(keys.count)
        for key in keys{
            result.append(self[key])
        }
        
        return result
    }
}
// Swift version and need to use map.
/*
extension Dictionary{
    func valueForKeys(keys: [Key]) -> [Value?]{
        return keys.map({
            self[$0]
        })
    }
}
*/

let dict = ["A": "Amir", "B": "Bertha", "C": "Ching"]

dict.valuesForKeys(["A", "C"])
// [Optional("Amir"), Optional("Ching")]

dict.valuesForKeys(["B", "D"])
// [Optional("Bertha"), nil]

dict.valuesForKeys([])
// [] - 0 element


dict.valuesForKeys(["A", "C"]).last
// Optional(Optional("Ching"))

dict.valuesForKeys(["B", "D"]).last
// Optional(nil). This is intresting. When we query for D, it returns optional nil - {nil}. But last method is implemented as 
/*
/// The last element, or `nil` if the array is empty
var last: T? { get }
*/
///Hence it is "nil coalescing operator" Nested Optionals

dict.valuesForKeys([]).last
// nil

///Providing the default
/*
extension Dictionary{
    func valuesForKeys(keys: [Key], notFoundMarker: Value) -> [Value]{
        var result = [Value]()
        result.reserveCapacity(keys.count)
        for key in keys{
            if(self[key] != nil)
            {
                result.append(self[key]!)
            }else{
                result.append(notFoundMarker)
            }
        }
        
        return result
    }
}

dict.valuesForKeys(["B", "D"], notFoundMarker: "Anonymous")

*/

//We can achieve it by map functions provided by swift
/*
extension Dictionary{
    func valuesForKeys(keys:[Key], notFoundMarker: Value) -> [Value]{
        return self.valuesForKeys(keys).map { $0 ?? notFoundMarker}
    }
}
*/
extension Dictionary{
    func valuesForKeys(keys:[Key], notFoundMarker: Value) -> [Value]{
        //return self.valuesForKeys(keys).map { $0 ?? notFoundMarker}
        return keys.map({
            self[$0] ?? notFoundMarker
        })
    }
}

dict.valuesForKeys(["B", "D"], notFoundMarker: "Anonymous")


/////////////////////////
//More on Pattern Matching Case Study
//
//////////////////////////

/*
Scenario: you count upwards from 1. If you reach a number that divides by 3, you say “Fizz!” instead of the number. If you reach a number that divides by 5, you say “Buzz!” instead of the number. If the number divides by 3 and 5, you say “FizzBuzz!.” So, starting from 1, you say “1, 2, Fizz!, 4, Buzz!,” and so on.

*/

func fizzBuzz(number: Int) -> String{
    switch (number % 3 , number % 5){ //tupple pattern
    case (0, 0):
        // number is divided by both 3 and 5
        return "FizzBuzz!"
    case (0, _):
        // number divides by 3
        return "Fizz!"
    case (_, 0):
        // number divides by 5
        return "Buzz!"
    case (_, _):
        // number does not divide by either 3 or 5
        return "\(number)"
    }
}

//Note: We need not to add default: as all conditions are met. If we comment one condition, then we will see the error.

for i in 1...100{
    println(fizzBuzz(i))
}


//Patterns can be used with enumerations and their associated values to match specific enumeration cases
//Lets have a case for train' live status
enum Status {
    case OnTime
    case Delayed(minutes: Int)
}

//Second case is having associated values. which stores an associated integer value to represent how many minutes late the train is running
let goodNews = Status.OnTime
let badNews = Status.Delayed(minutes: 90)

class Train {
    var status = Status.OnTime
}

//We can use pattern matching to match and extract the values associated with an enumeration case such as Status.Delayed(Int). The extension below extends the Train class to conform to Swift’s Printable protocol, which requires a conforming type to provide a readable string description property. This extension makes it easy to retrieve a String value that includes the number of minutes that the train is delayed.

extension Train /*:Printable*/ {
    
    var description: String {
        
        switch status {
            
        case .OnTime:
            // match against the OnTime enumeration case pattern
            return "On time"
            
        case .Delayed(let minutes) where 0...5 ~= minutes:
            // match against a pattern expression representing a range of values,
            // and use the "~=" operator to mean "where 'range' contains 'value'"
            return "Slight delay of \(minutes) min"
        
        case .Delayed(let minutes) where  minutes >= 60:
            return "Long delay of \(minutes) min"
            
        case .Delayed(_):
            // match against all remaining Delayed enumeration cases,
            // using a wildcard pattern to match any number of minutes
            return "Delayed"
            
            }
            
    }
    
}


let trainOne = Train()
let trainTwo = Train()
let trainThree = Train()
let trainFour = Train()

trainTwo.status = .Delayed(minutes: 2)
trainThree.status = .Delayed(minutes: 8)
trainFour.status = .Delayed(minutes: 61)

trainOne.description
trainTwo.description
trainThree.description
trainFour.description

//We do not need to have pattern matching of the Array and we can leverage of the features of map/reduce and filter functionality.

//Pattern Matching of sub-class and super class
extension Train {
    func cleanPassengerCars() -> String {
        return "Clean the passenger cars"
    }
}

class MaglevTrain: Train {
    func referToSpecialist() -> String {
        return "Refer the maglev to a specialist"
    }
}
class SteamTrain: Train {
    func increaseSpeed() -> String {
        return "Increase the speed of the train"
    }
}

let maglev = MaglevTrain()
let train = Train()

//is pattern matching - Upcasting
func trainDescription(train: Train) -> String {
    switch train {
    case is MaglevTrain:
        return "The fastest train on earth."
/* Always throws error - the case is always true
    case is Train:
        return "The fastest train on earth."
*/
    case is SteamTrain:
        return "Stream Train"
    default:
        return "Some other kind of train."
    }
}

trainDescription(maglev)
trainDescription(train)


//As Pattern: Down casting
func determineMaintenanceRequirements (train: Train) -> String {
    switch train {
    case let maglev as MaglevTrain:
        return maglev.referToSpecialist()
    case let stream as SteamTrain:
        return stream.increaseSpeed()
       
    default:
        return train.cleanPassengerCars()
    }
}

determineMaintenanceRequirements(train)
determineMaintenanceRequirements(maglev)

/////////////////////////
//Access Controll in Swift
//
//////////////////////////
/*
When designing access control levels in Swift, we considered two main use cases:

keep private details of a class hidden from the rest of the app
keep internal details of a framework hidden from the client app
These correspond to private and internal levels of access, respectively.

There is no Access Control as "Protected"

private entities are available only from within the source file where they are defined.
internal entities are available to the entire module that includes the definition (e.g. an app or framework target).
public entities are intended for use as API, and can be accessed by any file that imports the module, e.g. as a framework used in several of your projects.
*/

/////////////////////////
//Value type vs reference type
//
//////////////////////////
//Value type: struct, enum, or tuple
//Reference type: Class

/*
Value type is helpful in multithreaded environment
We can design a class to be completely immutable with immutable stored properties and avoiding exposing any APIs that can modify state. In fact, many common Cocoa classes, such as NSURL, are designed as immutable classes
However, Swift does not currently provide any language mechanism to enforce class immutability (e.g. on subclasses) the way it enforces immutability for struct and enum.

When you’re working with Cocoa/Cocoatouch, many APIs expect subclasses of NSObject, so you have to use a class. Here is a recomendation:
Use a value type when:

Comparing instance data with == makes sense
You want copies to have independent state
The data will be used in code across multiple threads

Use a reference type (e.g. use a class) when:

Comparing instance identity with === makes sense
You want to create shared, mutable state

In Swift, Array, String, and Dictionary are all value types. They behave much like a simple int value in C, acting as a unique instance of that data. You don’t need to do anything special — such as making an explicit copy — to prevent other code from modifying that data behind your back.

*/

/*

*/

/////////////////////////
//autoclosure and asserts
//
//////////////////////////

func someExpensiveComputation() -> Int{
    //println("Test")
    return 100
}


//An autoclosure function captures an implicit closure over the specified expression, instead of the expression itself
//Example:
/*
func f(pred: () -> Bool){
    if pred(){
        println("It is true");
    }
}

f({2 > 1})
f({2 < 1})
*/

//If we remove the curly braces then it will throw an error
// f(2 > 1)
// error: could not find an overload for '>' that accepts the supplied arguments

//@autoclosure creates an automatic closure around the expression. So when the caller writes an expression like 2 > 1, it's automatically wrapped into a closure to become {2 > 1} before it is passed to f. So if we apply this to the function f:


func f(pred: @autoclosure () -> Bool){
    if pred(){
        println("It is true");
    }
}

f(2 > 1)
f(2 < 1)
f(someExpensiveComputation() > 1)


func simpleAssert(condition: @autoclosure () -> Bool, message: String) {
    if !condition() {
        println(message)
    }
}

let testNumber = 6
simpleAssert(testNumber % 2 == 0, "testNumber isn't an even number.")

let testNumber1 = 5
simpleAssert(testNumber1 % 2 == 0, "testNumber isn't an even number.")

//In objective-c, we used to add macros to evaluate assertion. Bu in swift, we need to define a function.
//The below function is indended to work in debug version.
//The function will be called in release build and hence affects performance.
/*
func assert(x : Bool) {
    #if !NDEBUG
        
        /*noop*/
    #endif
}
*/

/*
//We can avoid it by adding a closure
func assert(predicate : () -> Bool) {
    #if !NDEBUG
        if !predicate() {
            abort()
        }
    #endif
}

//As explained earlier, it will be a lazy evaluation. But in this one we need to provide the function call with closure.
assert({ someExpensiveComputation() != 42 })
*/
//Lets use autoclosure
func assert(predicate : @autoclosure () -> Bool) {
    #if !NDEBUG
        if !predicate() {
            abort()
        }
    #endif
}
let x = someExpensiveComputation()
//assert(x != 42)

/*
func f(pred: @autoclosure () -> Bool){
    if pred(){
        println("It is true");
    }
}

f(2 > 1)
f(2 < 1)
*/

//1assert(someExpensiveComputation() > 1)































