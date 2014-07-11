// Playground - noun: a place where people can play

import UIKit

/*
We can be in full screen to see file inspector menu in top toolbar

Otherwise, 

view-> Utilities -> "Show File Inspector"
In file inspector, we can perform below settings
1. platform: iOS or MAC - We can select depending on our need
2. Resource Path:
    a) Absolute Path: We need to tap to select the exact resource path
    b) Relative to playground - This is good if we checkin the playground and resource into source controll repository
    c) Inside playground: RMC to platground file in finder and select "Show Package Content". Create a folder as Resources

To show Timeline:
view-> "Assistant Editor" -> "Show Assistant Editor"
*/

/*
What is playground?
1. We can write code using swift language
2. We can specify resources in playground
3. We can specify timeline to view the results

Why to use playground?
1. Learning and prototyping
2. Algorithm development
3. Drawing code development
4. Processing code - value transforms, filters etc
5. Experimentation
*/

//Timeline
var string = "Hello" + " " + "World"
for i in 0..10{
    string += "\(i)"
}
string

for i in 0..20{
    var j = i % 4
}

/*
Many Values have quick looks
Below are the list of suppoted types in playground

1. Colors
2. Strings - plain and attributted
3. Images
4. Views
5. Arrays and Dictionaries
6. Points, rect and sizes
7. Bezier Path
8. URLs
9. Classes and Structs

*/
var str = "Hello, playground"
for k in 0..100{
    k * k
}

let color = UIColor.redColor()

//Static function can be defined as below
// class func method(arg)->return type
//In the above example, UIColor.redColor() is a static method

let attrStr = NSAttributedString(string: str, attributes: [NSForegroundColorAttributeName: color, NSFontAttributeName: UIFont.systemFontOfSize(42)])

var user:String = "1.png"

var image = UIImage(named:user)

//init(x: Int, y: Int, width: Int, height: Int)
var rect: CGRect = CGRect(x: 0, y: 0, width: 100, height:100)

var view:UIView = UIView(frame: rect)

var label: UILabel = UILabel(frame: CGRect(x: 0, y: 0, width: 100, height: 50))
label.text = "Hello World"
label.backgroundColor = UIColor.blueColor()
view.addSubview(label)

view

//class func URLWithString(URLString: String!) -> Self!
var url:NSURL = NSURL.URLWithString("http://www.apple.com")

/*
Algorithm Development
*/

/*
var data = Int[]()
for i in 0..20{
    data.append(Int(arc4random()) % 100)
}
data
*/
var data = [55, 29, 98, 24, 81, 73, 37, 73, 13, 78, 3, 92, 11, 87, 47, 53, 89, 53, 77, 73]
func exchange<T>(data: T[], i: Int, j: Int ){
    let temp = data[i]
    data[i] = data[j]
    data[j] = temp
}

exchange(data, 0, 2)
data

func swapLeft<T: Comparable>(data: T[], index: Int){
    for i in reverse(1...index){
        if data[i] < data[i-1]{
            exchange(data, i, i-1)
        }
        else{
            break
        }
    }
}

func iSort<T: Comparable>(data: T[]){
    for i in 1..data.count{
        swapLeft(data, i)
    }
}

iSort(data)

data


/*
XCPlayground
It contains utilities to work with playground for the following purpose:
1. Manually capturing values
2. Showing live views
3. Extending execution

We need to do import XCPlayground

It is not supporting for iOS. It is a good tool for MAC
We can provide Animations as well.
We can explore the folowing APIs

1. XCPCaptureValue
2. XCPShowView
3. XCPSetExecutionShouldContinueIndefinitely
4.

*/


/*
Other Considerations
1. Don't use playground for performance monitoring
2. Playground can't be used for the following purpose - Limitations
    a. User Interactions
    b. Entitelements
    c. On-device execution
    d. Your app or framework code
*/


/*

Playground Vs. REPL

1. Playground: Automatic code exection and rich experience, quick look, time line

*/










