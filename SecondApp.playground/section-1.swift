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
// 2. Use weak references among objects with independent life time
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

var renters = ["Hari": PersonClass()]
var apts = [507: Apartement()]

renters["Hari"]!.moveIn(apts[507]!)

renters["Hari"] = nil

// weak references are optional values
// binding the optional produces a strong reference

if let tenant = apts[507]!.tenant{
    //tenant is the strong reference
}

//testing a weak reference does not produce a srong reference

var apt = apts[507]!

if apt.tenant{
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
    
    convenience init(color: Color) {
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

/*
let color = (1.0, 1.0, 1.0, 1.0)
switch color{
case (0.0, 0.5...1.0, let blue, _):
println("----")
case let (r, g, b, 1.0) where r == g && g == b:
println("----")
}
*/


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















