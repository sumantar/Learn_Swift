// Playground - noun: a place where people can play

import Cocoa
import Foundation
//import UIKit

//constants and variables

var languageName = "Swift" //type inference
var languageName1:String = "Swift"

let language = "Swift"
let language1:String = "Swift"

//var languageName1
[1, 2, 3]
let languageName2="Hello World"
let myVar = 10
//myVar = 20 //cannot assign to constants


println("Hello World")

//[1..5] |>
for number in 1...5{
    println("languageName2: \(languageName2)")
}

//Unicode variable name

let wiseWords = "\"Imagination is more important than knowledge\" - Einstein"
let dollarSign = "\u{24}"
let blackHeart = "\u{2665}"
let sparklingHeart = "\u{0001F496}"

let π = 3.14159
let 你好 = "你好世界"
let 🐶🐮 = "dogcow"

let 🐥 = "simile"

println(π)

//////////////////////////////////////////////////////
//Strings: It is similar to NSString. All NSString APIs are available for swift string
//It is a character set and we can iterate one by one

let dog:Character = "🐶"
let cow:Character = "🐮"
let dogCow = dog+cow

//////////////////////////////////////////////////////
//   Arrays and Dictionary

var names = ["Anna", "Alex", "Briyan", "Jack"]
var numberOfLegs = ["ant": 6, "snake": 0, "cheetah": 4]

for number in 1...5{
    println("\(number) times 4 is \(number * 4)")
}

for number in 1..<5{
    println("\(number) times 4 is \(number * 4)")
}

for (animalName, legCount) in numberOfLegs{
    println("\(animalName)s have \(legCount) legs")
}

var shoppingList = ["eggs", "milk"]
shoppingList += "flour"
shoppingList += ["cheese", "butter", "chocolate spread"]
shoppingList[0] = "six eggs"
shoppingList
shoppingList[3...5]=["bananas", "apple"]
shoppingList

//Modifying Dictionary
numberOfLegs["spider"] = 8

//These are the optionals - we will discuss it later
//Non-optional type can't be nil

let possibleLegCount: Int? = numberOfLegs["spider"]
if possibleLegCount == nil{
    println("spider was not found")
}
else{
    let legCount = possibleLegCount
    println("A spider has \(legCount) legs")
}

//We can use an if statement to find out whether an optional contains a value. If an optional does have a value, it evaluates to true; if it has no value at all, it evaluates to false.

//Once we’re sure that the optional does contain a value, you can access its underlying value by adding an exclamation mark (!) to the end of the optional’s name. The exclamation mark effectively says, “I know that this optional definitely has a value; please use it.” This is known as forced unwrapping of the optional’s value

var neighbors = ["Alex", "Anna", "Madission", "Dave"]
let index:Int? = 2 //findIndexOfString("Madission",neighbors)
if index{
    println("Hello, \(neighbors[index!])")
}
else{
    println("Must have moved away")
}

let possibleLegCount1: Int? = 0
let legCount = possibleLegCount1!
legCount
switch legCount{
case 0:
    
    println("")
case 1:
    println("")
//default:
//    println("")
    //switch must be exhaustive, consider adding a default clause
default:
    println("")
}

//With switch we can have a matching object
/*
let sender:AnyObject? = nil
let executeButton;? = nil
let firstNameTextField;

switch sender{
case executeButton:
    println("")
case firstNameTextField:
    println("")
default:
    println("")
}
*/

//In switch case, statement, we can have pattern matching as well
//case 1...5

///////////////////////////////////
//  Functions
// Variable Arguments
// Variable Return types
/////////////////////////////////////

func sayHello(){
    println("Say Hello")
}

func sayHello(name: String){
    println("Hello \(name)!")
}

func sayHello(name: String = "World"){
    println("Hello \(name)!")
}

func sayHello(name: String = "World", flag: String){
    println("Hello \(name) \(flag)")
}

//Function returns a value
func buildGreeting(name: String = "World")->String{
    return "Hello " + name
}

let greeting:String = buildGreeting(name:"Sumanta")
let greeting1:String = buildGreeting()

//returns multiple values - tuples
func refreshWebPage()->(Int, String){
    return (200, "Success")
}

let (statusCode, message) = refreshWebPage()

println("Received \(statusCode): \(message)")

//tuples
for (animalName, legCount) in numberOfLegs{
    println("\(animalName)s have \(legCount) legs")
}

//named value tuples
func refreshPage()->(code: Int, message: String){
    return (200, "Success")
}

let status = refreshPage()
println("Received \(status.code): \(status.message)")


///////////////////////////////////
//  Closure
//  It is similar to blocks in objective-c
/////////////////////////////////////

let greetingPrinter = {
    println("Hello World")
}

greetingPrinter()

// we can define an argument and return values
let greetingPrinter1:()->() = {
    println("Hello World")
}

greetingPrinter1()

func repeat(count: Int, task:()->()){
    for i in 0..<count{
        task()
    }
}

repeat(2, {
    println("Hello World**!!!!")
    })

//Trailing closure
repeat(2){
   println("Hello World!!!!")
}

///////////////////////////////////
//  Classes
// 1. properties, 2. methods and 3. initializers
// named and mutable values
// 1. stored and computed variables
// 2. stored variable and property observers, and static variable properties
// We can override the property in subclass with keyword - override
/////////////////////////////////////

class Vehicle{
    //Stored variable and property. 
    //When a variable declaration of this form is declared at global scope or the local scope of a function, it is referred to as a stored variable. When it is declared in the context of a class or structure declaration, it is referred to as a stored variable property
    
    var numberOfWheels = 0
    
    //computed variables and computed property
    var description:String{
        get{
           return "\(numberOfWheels) wheels"
        }
//        set{
//            newValue + " - Done" //newValue is implicit. If we want explicit, then we can “provide an explicit name in parentheses after set”
//        }
    }
    //This is not mandatory
    init(){
        numberOfWheels = 0
    }
    //This is not mandatory
    init(numberOfWheels: Int){
        self.numberOfWheels = numberOfWheels
    }
}

//No need to do alloc/init just we do in Objective-C
//It is automatic
let someVehicle = Vehicle()

//Lets use the class
println(someVehicle.description)
let des = someVehicle.description

someVehicle.numberOfWheels = 2
let des1 = someVehicle.description

//Initialize the class and constructor
let someVehicle1 = Vehicle(numberOfWheels: 4)
let des11 = someVehicle1.description

class Car: Vehicle{
    var speed:Double = 0.0
    init(){
        super.init()
        numberOfWheels = 4
    }
    //can't override mutable property with read-only property description. This error will appear if we have setter
    override var description: String{
        return super.description + ", \(speed) mph"
    }
}

//proprty observer
class ParentsCar:Car{
    //We can provide setter values to willSet/didSet in paranthesis. However it is optional. Default parameter name - newValue/oldValue
    override var speed:Double{
        willSet{
            if newValue > 65.0{
                println("Be Careful!!!")
            }
        }
        didSet{
            if oldValue == 65.0{
                println("Threshold is set")
            }
        }
    }
}
    
///////////////////////////////////
//  Structures. It can contain, data, method and properties
// Difference between structure and class in Swift???
// 1. Structure can not inherit from another structure
// 2. We can only pass it as values
/////////////////////////////////////

struct Point{
    var x, y: Double
    //mutating structure. We can change the structure data. Otherwise, we will get the below error
    // cound not find an overload for '+=' that accepts the supplie arguments
    mutating func moveToTheRightBy(dx: Double){
        x += dx
    }
}

struct Size{
    var width, height: Double
}

struct Rect{
    var origin: Point
    var size: Size
    
    var area:Double{
        return size.width * size.height
    }
    
    func isBiggerThanRect(other: Rect) -> Bool{
        return self.area > other.area
    }
}

var point = Point(x: 0.0, y: 0.0)
var size = Size(width: 640.0, height: 480.0)
var rect = Rect(origin: point, size: size)

///////////////////////////////////
//  Enumeration - 
//  This is very powerful feature comparions to Objective-C
/////////////////////////////////////

enum Planet: Int{
    case Mercury=1, Venus, Earth, Mars, Jupiter, Satrun, Uranus, Neptune
}

let earthNumber = Planet.Earth.toRaw()

enum ControlCharacter: Character{
    case Tab = "\t"
    case Linefeed = "\n"
    case CarriageReturn = "\r"
}

enum CompassPoint{
    case North, South, East, West
}

var directionToHead = CompassPoint.West //automatically inferred as enum
directionToHead = .East

/*
let label = UILabel()
label.textAlignment = .Right
*/

//enumeration associated values
enum TrainStatus{
    case OnTime
    case Delayed (Int)
}

var trainStatus = TrainStatus.OnTime
trainStatus = .Delayed(10)

//Lets modify
enum TrainStatus1{
    case OnTime
    case Delayed (Int)
    
    init(){
        self = OnTime
    }
    
    var description: String{
        switch self{
            case OnTime:
                return "on time"
            case Delayed(let minutes):
                return "delayed by \(minutes) minute(s)"
        }
    }
}

var trainStatus1 = TrainStatus1()
let statusOfTrain = "The train is \(trainStatus1.description)"
trainStatus1 = .Delayed(42)
let statusOfTrain1 = "The train is \(trainStatus1.description)"


//Nested Types
class Train{
    enum Status{
        case OnTime
        case Delayed (Int)
        
        init(){
            self = OnTime
        }
        
        var description: String{
        switch self{
        case OnTime:
            return "on time"
        case Delayed(let minutes):
            return "delayed by \(minutes) minute(s)"
            }
        }
    }
    
    var status = Status()
}

//Example
enum Rank: Int {
    case Ace = 1
    case Two, Three, Four, Five, Six, Seven, Eight, Nine, Ten
    case Jack, Queen, King
    func simpleDescription() -> String {
        switch self {
        case .Ace:
            return "ace"
        case .Jack:
            return "jack"
        case .Queen:
            return "queen"
        case .King:
            return "king"
        default:
            return String(self.toRaw())
        }
    }
}
let ace = Rank.Ace
let aceRawValue = ace.toRaw()

//“Use the toRaw and fromRaw functions to convert between the raw value and the enumeration value”
if let convertedRank = Rank.fromRaw(3) {
    let threeDescription = convertedRank.simpleDescription()
}


///////////////////////////////////
//  Extensions -
//  It is similar to Categories in Objective-C
/////////////////////////////////////
extension Size {
    mutating func increaseByFactor(factor: Double){
        width = factor
        height = factor
    }
}


///////////////////////////////////
//  Generics -
//
/////////////////////////////////////
class Stack<T>{
    var elements = [T]()
    func push(element: T){
        elements.append(element)
    }
    
    func pop()-> T{
        return elements.removeLast()
    }
}

var intStack = Stack<Int>()
intStack.push(50)
let lastIn = intStack.pop()

var stringStack = Stack<String>()
stringStack.push("Hello World")
let lastStrIn = stringStack.pop()



















