// Playground - noun: a place where people can play

import UIKit
import Swift

var str = "Hello, playground"

let x = "Hi"
/********************************************
Subscripts
*********************************************/

/*
Classes, structures, and enumerations can define subscripts, which are shortcuts for accessing the member elements of a collection, list, or sequence

Syntax:
subscript(index: Int) -> Int {
    get {
    // return an appropriate subscript value here
    }
    set(newValue) {
    // perform a suitable setting action here
    }
}

*/
//Similar to computed property
//For this exa,ple it doesnot make sense to have a setter for it.
struct TimeTable{
    let multiplier: Int
    subscript(index: Int) -> Int{
        get{
            return multiplier * index
        }
    }
}

let table = TimeTable(multiplier: 3)
println("Six time 3 is : \(table[6])");

/*
Usage: Swift’s Dictionary type implements a subscript to set and retrieve the values stored in a Dictionary instance

var numberOfLegs = ["spider": 8, "ant": 6, "cat": 4]
numberOfLegs["bird"] = 2

*/
var numberOfLegs = ["spider": 8, "ant": 6, "cat": 4]
numberOfLegs["bird"] = 2

/*
Subscripts can take any number of input parameters, and these input parameters can be of any type

Sucript can aso returns any type

*/

struct Matrix {
    let rows: Int, columns: Int
    var grid: [Double]
    
    init(rows: Int, columns: Int) {
        self.rows = rows
        self.columns = columns
        grid = Array(count: rows * columns, repeatedValue: 0.0)
    }
    
    func indexIsValidForRow(row: Int, column: Int) -> Bool {
        return row >= 0 && row < rows && column >= 0 && column < columns
    }
    
    subscript(row: Int, column: Int) -> Double {
        get {
            assert(indexIsValidForRow(row, column: column), "Index out of range")
            return grid[(row * columns) + column]
        }
        set {
            assert(indexIsValidForRow(row, column: column), "Index out of range")
            grid[(row * columns) + column] = newValue
        }
    }
   
}

var matrix = Matrix(rows: 2, columns: 2)
matrix[0, 1] = 1.5

matrix[1, 0] = 3.2

extension String {
    subscript(pattern: String) -> Bool {
        get {
            let range = self.rangeOfString(pattern)
            
            return (range?.isEmpty != nil)
        }
    }
}

var aString = "We ❤ Swift"
aString["❤"] // true
aString["Hello World"] // false

/********************************************
Protocols and Generics
*********************************************/

//Protocol and generic
func findStringIndex(array: [String], valueToFind:String) -> Int?{
    for (index, value) in enumerate(array){
        if value == valueToFind{
            return index
        }
    }
    
    return nil
}

func findStringIndexGeneric<T: Equatable>(array: [T], valueToFind:T) -> Int?{
    for (index, value) in enumerate(array){
        if value == valueToFind{
            return index
        }
    }
    
    return nil
}

let doubleIndex = findStringIndexGeneric([3.14159, 0.1, 0.25], 9.3)
let stringIndex = findStringIndexGeneric(["Mike", "Malcolm", "Andrea"], "Andrea")


/********************************************
Associated Types in protocol
*********************************************/
//Associated Types in protocol
//We can define generics in protocol

protocol Container{
    typealias ItemType //This is not required as Swift can automatic type inference
    mutating func append(item: ItemType)
    var count :Int{get}
    subscript(i: Int) -> ItemType {get}
    
}

//Lets define a Integer stack that should implement this Container
struct IntStack: Container{
    var items = [Int]()
    
    mutating func push (item: Int){
        items.append(item)
        
    }
    
    mutating func pop() -> Int{
        return items.removeLast()
    }
    
    //MARK: Protocol implementation
    /*
    typealias ItemType = Int
    mutating func append(item: ItemType){
        self.push(item)
    }
    */
    mutating func append(item: Int){ //Automatic type inference
        self.push(item)
    }
    
    var count:Int{
        return items.count
    }
    
    subscript(i: Int) -> Int {
        return items[i]
    }
    
}

var MyIntStack = IntStack()

MyIntStack.push(5)
MyIntStack.append(10)
MyIntStack.append(20)
MyIntStack.append(30)

let value = MyIntStack[1]

let value1 = MyIntStack[3]

//Let have the generic implementation
struct Stack<T>: Container{
    var items = [T]()
    
    mutating func push(item: T){
        items.append(item)
    }
    mutating func pop() -> T{
        return items.removeLast()
    }
    
    //MARK: protocol implementation
    mutating func append(item: T){ //Automatic type inference
        self.push(item)
    }
    
    var count:Int{
        return items.count
    }
    
    subscript(i: Int) -> T {
        return items[i]
    }
}

//Protocol Constraints

func allItemsMatch<T1: Container, T2: Container where T1.ItemType == T2.ItemType, T1.ItemType: Equatable> (someContainer: T1, anotherContainer: T2) -> Bool {
    
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

if allItemsMatch(stackOfStrings, arrayOfStrings) {
    println("All items match.")
    let res = "All items match."
} else {
    println("Not all items match.")
    let res = "Not All items match."
}

//Other protocols
/********************************************
Other System Level Protocols
*********************************************/
//Iterations - Sequence protocol

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

//Lets have our collection class
class Items : SequenceType{
    var items: [MyItem] = []
    func addItem(item: MyItem){
        items.append(item)
    }
    
    //Now we need to implement generate method
    func generate()-> GeneratorOf<MyItem> {
        var i = 0
        return GeneratorOf<MyItem> {
            return i >= self.items.count ? .None : self.items[i++]
            //.None => nil i.e. end of the iterator
        }
    }

}

//Add items to collection class
let items = Items()
items.addItem(item1)
items.addItem(item2)

//Lets iterate

for item in items{
    println("item: \(item.name), \(item.priority)")
}

//Error: Items does not confirm to protocol SequenceType. Lets confirm to the protocol
//Next Error: items does not confirm to protocol _Sequence_Type. Lets add method, GeneratorOf

//Lets have a generic implementation
struct GenericGenerator<T>: GeneratorType {
    var items: [T]
    mutating func next() -> T? {
        return items.isEmpty ? .None : items.removeAtIndex(0)
    }
}

////Generic Collection Class
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


//Boolean
//Lets discuss our model class
enum MyBool{
    case MyTrue, MyFalse
}

extension MyBool{
    init(){
        self = .MyFalse
    }
}

//Override == operator
func == (lhs: MyBool, rhs: MyBool) -> Bool{
    switch(lhs,rhs){
    case (.MyTrue, .MyTrue), (.MyFalse, .MyFalse):
        return true
    default:
        return false
    }
}

extension MyBool: BooleanLiteralConvertible{
    init(booleanLiteral value: Bool){
        self = value ? MyTrue : MyFalse
    }
}

extension MyBool : BooleanType{
    var boolValue: Bool{
        switch self{
        case .MyTrue: return true
        case .MyFalse: return false
        }
    }
}
//Lets assign a premitive type to our boolean type
let a : MyBool = true
//Error: MyBool does not confirm to protocol 'BooleanLiteralConvertiable'

if a{
    println("TRUE")
}

//Error: MyBool does not confirm to protocol BooleanType


var basicBool: Bool = true
let b = MyBool(booleanLiteral: basicBool)



if a == a{
    println("Objects are equals")
}

//It is already confirms to protocol Equatable

//Protocol Equatable
struct MyStruct: Equatable{
    var name = "Untitled"
}

func == (lhs: MyStruct, rhs: MyStruct) -> Bool {
    return lhs.name == rhs.name
}

var var1 = MyStruct()
var var2 = MyStruct()
let firstcheck = var1 == var2


//Similar for printable and comparable

/********************************************
Optional: nil coalescing operator
*********************************************/

//a??b. It is similar to ternary operator. If a present, then it will return value of a elaee value of b
let defaultColorName = "red"
var userDefinedColorName: String?   // defaults to nil”
var colorNameToUse = userDefinedColorName ?? defaultColorName

userDefinedColorName = "green"
colorNameToUse = userDefinedColorName ?? defaultColorName


/********************************************
Auto Closure and Asserts
*********************************************/
//Automatically closures will be added to the expressions

func f(pred: ()->Bool){
    if pred(){
        println("It is true")
    }
}


f({2 > 1})

f({2 < 1})

//f(2 > 1)
//Error: Cound not find overloaded operator >
//For convenient, it will be better to use in this form.
//Solution: autoclosure


func f1(pred: @autoclosure()->Bool){
    if pred(){
        println("It is true")
    }
}

f1(2 > 1)
f1(2 < 1)
f1(5 > 3)

func someExpensiveComputation() -> Int{
    return 100
}

//It takes a cloure that only returns a boolean value.
f1 (someExpensiveComputation() > 1)


//Lets discuss about asserts
func simpleAssert(condition: @autoclosure () -> Bool, message: String){
    if condition(){
        println(message)
    }
}

let testNumber = 6
simpleAssert(testNumber % 2 == 0, "testNumber isn't an even number.")

let testNumber1 = 5
simpleAssert(testNumber1 % 2 == 0, "testNumber isn't an even number.")

//Lets discuss about another function
func assert(x: Bool){
    #if DEBUG
       println("This is a debug statement")
    #endif
        
}
//But this function will be called in release build. Hence will affect the performance.
//We can avoid it by lazy evaluation by adding autoclosure

func assert1(predicate: @autoclosure () -> Bool){
    #if DEBUG
        if !predicate(){
            println("assertion failed at \(__FILE__):\(__LINE__)")
            abort()
        }
        //println("This is a debug statement")
    #endif
    
}

//assert1(someExpensiveComputation() != 42 )
assert1(testNumber != 42 )
//
//func assert(condition: @autoclosure () -> Bool, _ message: String = "",
//    file: String = __FILE__, line: Int = __LINE__) {
//        #if DEBUG
//            if !condition() {
//            println("assertion failed at \(file):\(line): \(message)")
//            abort()
//            }
//        #endif
//}
//
//func logAndAssert(condition: @autoclosure () -> Bool, _ message: StaticString = "",
//    file: StaticString = __FILE__, line: UWord = __LINE__) {
//        
//      //  logMessage(message)
//      //  assert(condition, message, file: file, line: line)
//}















