// Playground - noun: a place where people can play

import UIKit

//Singleton

class Singleton1{
    class var sharedInstance: Singleton1{
        return _SingletonASharedInstance
    }
}

private let _SingletonASharedInstance = Singleton1()




class Singleton {
    class var sharedInstance : Singleton {
        struct Static {
            static var onceToken : dispatch_once_t = 0
            static var instance : Singleton? = nil
        }
        dispatch_once(&Static.onceToken) {
            Static.instance = Singleton()
        }
        return Static.instance!
    }
}

class x{
    class var x:Int{
        return 0
    }
    
}


/////////////////////////////////////////////////////


var str = "Hello, playground"

//Function for quare of a number
func square(a: Float) -> Float{
    return a * a
}

//Function for cube of a number
func cube(a: Float) -> Float{
    return a * a * a
}

//Lets write function to give average of cube and square numbers
func averageSumOfSquares(a: Float, b: Float) -> Float{
    return (square(a) + square(b))/2
}


func averageSumOfCube(a: Float, b: Float) -> Float{
    return (cube(a) + cube(b))/2
}

//Here, we will see the difference between function - cube or square. 
//What is the best way??
//Closure

func averageFunction(a: Float, b: Float, f: (Float -> Float)) -> Float{
    return (f(a) + f(b))/2
}

averageFunction(4.0, 3.0, square)
averageFunction(4.0, 3.0, cube)


//Currying
//Currying is when you break down a function that takes multiple arguments into a series of functions that take part of the arguments.

func averageCurriedFunction(f: (Float -> Float))(a: Float, b: Float) ->Float{
    
    return (f(a)+f(b))/2
}

let squareFunction = averageCurriedFunction(square)
let cubeFunction = averageCurriedFunction(cube)

let sqAvg = squareFunction(a: 4.0, b: 3.0)
let cubAvg = cubeFunction(a: 4.0, b: 3.0)

/********************************/
/* Higher Order Function ********/
/********************************/

//Map functions
var moneyArray = [10, 20, 32, 45]
var stringArray = [String]()
for money in moneyArray{
    stringArray.append("\(money)$")
}

//Is this the best??
//Here is the another approch
let moneyArray1 = moneyArray.map ({
    money in "\(money)$"
})

let moneyArray2 = moneyArray.map({
      "\($0)$"
})

var numberArray = [20, 30, 40, 50]
//Lets multiply 4 in each number
numberArray.map({
    $0 * 4
})

//Revisit the closure
numberArray.map({
    (number: Int) -> Int in
    let result = number * 4
    return result
})

//Since Swift does the type inferer, we can reduce it as follows
numberArray.map({
    number in number * 4
})

//Filter
//In our earlier money array lets find values greater than 30 and result also an array

let filterArray = numberArray.filter({
    $0 > 30
})

// Lets find values greater than 100, which does not exist
let filterArray1 = numberArray.filter({
    $0 > 100
})

//Reduce
//We often call it as fold or aggregate

//Lets add all the numbers in number array
let initialValue = 0
let aggregate = numberArray.reduce(initialValue, {
    $0 + $1
})

//Let multiply each members
let aggregate1 = numberArray.reduce(1, {
    $0 * $1
})

//Use Case for Map-Reduce-Filter
let words = ["Cat", "Chicken", "fish", "Dog",
    "Mouse", "Guinea Pig", "monkey"]

let words_repeat = ["Cat", "Chicken", "fish", "Dog",
    "Mouse", "Guinea Pig", "monkey"]

//1. Lets join each string of first arry with every string of second array
let result1 = words.map({
    (word) -> [String] in
    return words_repeat.map({
        word + "&" + $0
    })
})

let result2 = words.map({
    (word) in
    words_repeat.map({
        (repeat) in
        word + "&" + repeat
    })
})

//2. Lets join each element of first array with first element of second array
let result3 = words.map({
    (word) -> String in
    var index = find(words, word)
    var secondValue = words_repeat[index!]
    
    return word + "->" + secondValue
})


/********************************/
/** Other Highorder Functions ***/
/********************************/

//1. abs(signedNumber)
abs(-1) == 1
abs(-42) == 42
abs(42) == 42

//2. contains(sequence, element): Returns true if a given sequence (such as an array) contains the specified element
var languages = ["Swift", "Objective-C"]
contains(languages, "Swift") == true
contains(languages, "Java") == false
contains([29, 85, 42, 96, 75], 42) == true

//3. dropFirst(sequence): Returns a new sequence (such as an array) without the first element of the sequence.
var oldLanguages = dropFirst(languages)
equal(oldLanguages, ["Objective-C"]) == true

//4. dropLast(sequence): Returns a new sequence (such as an array) without the last element of the sequence passed as argument to the function
languages = ["Swift", "Objective-C"]
var newLanguages = dropLast(languages)
equal(newLanguages, ["Swift"]) == true

//5. dump(object): Dumps the contents of an object to standard output.
languages = ["Swift", "Objective-C"]
dump(languages)

//6. equal(sequence1, sequence2): Returns true if sequence1 and sequence2 contain the same elements.
languages = ["Swift", "Objective-C"]
equal(languages, ["Swift", "Objective-C"]) == true
oldLanguages = dropFirst(languages)
equal(oldLanguages, ["Objective-C"]) == true

//7. filter(sequence, includeElementClosure): Returns a the elements from sequence that evaluate to true by includeElementClosure.
for i in filter(1...100, { $0 % 10 == 0 }) {
    // 10, 20, 30, ...
    println(i)
    assert(contains([10, 20, 30, 40, 50, 60, 70, 80, 90, 100], i))
}

//8. find(sequence, element): Return the index of a specified element in the given sequence. Or nil if the element is not found in the sequence.
languages = ["Swift", "Objective-C"]
find(languages, "Objective-C") == 1
find(languages, "Java") == nil
find([29, 85, 42, 96, 75], 42) == 2

//9. indices(sequence): Returns the indices (zero indexed) of the elements in the given sequence.
equal(indices([29, 85, 42]), [0, 1, 2])
for i in indices([29, 85, 42]) {
    // 0, 1, 2
    println(i)
}

//10. join(separator, sequence): Returns the elements of the supplied sequence separated by the given separator
join(":", ["A", "B", "C"]) == "A:B:C"
languages = ["Swift", "Objective-C"]
join("/", languages) == "Swift/Objective-C"

//11. map(sequence, transformClosure): Returns a new sequence with the transformClosure applied to all elements in the supplied sequence.
equal(map(1...3, { $0 * 5 }), [5, 10, 15])
for i in map(1...10, { $0 * 10 }) {
    // 10, 20, 30, ...
    println(i)
    assert(contains([10, 20, 30, 40, 50, 60, 70, 80, 90, 100], i))
}

//12. max(comparable1, comparable2, etc.): Returns the largest of the arguments given to the function
max(0, 1) == 1
max(8, 2, 3) == 8

//13. maxElement(sequence): Returns the largest element in a supplied sequence of comparable elements.
maxElement(1...10) == 10
languages = ["Swift", "Objective-C"]
maxElement(languages) == "Swift"

//14. minElements(sequence): Returns the smallest element in a supplied sequence of comparable elements.
minElement(1...10) == 1
languages = ["Swift", "Objective-C"]
minElement(languages) == "Objective-C"

//15. reduce(sequence, initial, combineClosure): Recursively reduce the elements in sequence into one value by running the combineClosure on them with starting value of initial.
languages = ["Swift", "Objective-C"]
reduce(languages, "", { $0 + $1 }) == "SwiftObjective-C"
reduce([10, 20, 5], 1, { $0 * $1 }) == 1000

//16. reverse(sequence): Returns the elements of the given sequence reversed.
equal(reverse([1, 2, 3]), [3, 2, 1])
for i in reverse([1, 2, 3]) {
    // 3, 2, 1
    println(i)
}

//17. startsWith(sequence1, sequence2): Return true if the starting elements sequence1 are equal to the of sequence2.
startsWith("foobar", "foo") == true
startsWith(10..<100, 10..<15) == true
languages = ["Swift", "Objective-C"]
startsWith(languages, ["Swift"]) == true



/********************************/
/***** Tail Recursion    ********/
/********************************/

//Recursion and tail recursion
//Standard recursion:
//Factorial
func factorial (n: Int) -> Int{
    if n == 1{
        return 1
    }
    else{
        return n * factorial(n-1)
    }
    
}

let factorialRes = factorial(4)

//Tail recursion

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


//With tail recursion, we will add additional parameter - aggregator or result
//Lets modify the above function to understand tail recursion
func factorialWithToc(n: Int, result: Int = 1) -> Int{
    
    if n == 1{
        return result
    }
    else{
        return factorialWithToc(n-1, result: n * result)
    }
}

let factorialToc = factorialWithToc(4)

//Lets have another example - Fibonaci series
func fibonaci(n: Int) -> Int{
    if n < 2{
        return n
    }
    else{
        return fibonaci(n-1) + fibonaci(n-2)
    }
}

let fibRes = fibonaci(3)

func fibonaciWithToc(n: Int, previous: Int = 0, result: Int = 1) -> Int{
    if n < 2{
        return result
    }
    else{
        return fibonaciWithToc(n-1, previous: result, result: result + previous)
    }
    
}

let fibResWithToc = fibonaciWithToc(3)

/********************************/
/***** Swift Memoization ********/
/********************************/

//memoize in swift
//Swift Memoization
//Memoization is an optimisation technique where the return values of a function are cached to avoid repeating the same computation
/*
func memoize<T: Hashable, U>( fn: (T->U, T)->U ) -> T->U {
    var cache = [T : U]()
    var result: ((T)->U)!
    result = { x in
        if let q = cache[x] { return q }
        let r = fn(result, x)
        cache[x] = r
        return r
    }
    
    return result
}

let fibonacci: (Int -> Double) = memoize {
    fibonacci, n in
    return (n < 2) ? Double(n) : fibonacci(n - 1) + fibonacci(n - 2)
}

let ret = fibonacci(45) / fibonacci(44)
println(ret)

let factorial = memoize { factorial, x in x == 0 ? 1 : x * factorial(x - 1) }
let res = factorial(3)

*/



























