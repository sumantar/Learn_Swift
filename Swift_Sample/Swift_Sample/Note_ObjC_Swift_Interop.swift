//
//  Notes.swift
//  Swift_Sample
//
//  Created by sumantar on 21/08/14.
//  Copyright (c) 2014 sumantar. All rights reserved.
//

import Foundation


/*
http://stackoverflow.com/questions/24002369/how-to-call-objective-c-code-from-swift/24005242#24005242
http://ios-blog.co.uk/tutorials/ios8-how-to-use-objective-c-classes-in-swift/
https://developer.apple.com/library/prerelease/ios/documentation/Swift/Conceptual/BuildingCocoaApps/Migration.html
https://developer.apple.com/library/prerelease/mac/documentation/Swift/Conceptual/BuildingCocoaApps/InteractingWithObjective-CAPIs.html#//apple_ref/doc/uid/TP40014216-CH4-XID_26



Bridging header: With this header, we can call objective-C code in swift project.
This file will be automatically called when we add objective-c code into swift project
It case it is deleted or we need to add a objective-c framework, then we need to add it manually.
=> Just add a header file and name it as "<projectName>-Bridging-Header.h". Once it is done, we need to mention this file name in project setting
==> Search "Objective-C Brid". Add this file name there


Umbrella Header:

When we import swift code into objective-c code, xcode generates a header file that declares swift interfaces in objective-c. It can be thought as an umbrella header for the objective-c code.
This is a hidden file. The name of the file - product module name followed by adding "-Swift.h"
In order this file to be generated, we need to ensure the following:
1) Go to project settings -> Package.
2) "Product Module Name": There should not be any space
3) Ensure that "Define Module" flag is YES

After these settings, XCode will generate umbrella headers that we can include in our objective-c code to access swift code.


@objc attribute, if we want any function, class and properties to be exposed to objective-c.


*/

/*
Swift Interoperability

id vs AnyObject
Bridging core cocoa types
Subclassing
CF interoperability
*/

/* 

Objective-C Vs Swift Data types
===============================

BOOL        ->  Bool
NSInteger   ->  Int
SEL         ->  Selector
id          ->  AnyObject!
Class       ->  AnyClass!
NSString *  ->  Sting!
NSArray *   -> [AnyObject]!

*/

/*
Properties
==========
@property NSDate *fileModificationDate;
=>
var fileModificationDate:NSDate!
implicit unwrapping of optional i.e. the property can be nil

@property(readonly) NSString *fileType;
=>
var fileType:String! { get }

*/

/*
Methods
========
-(NSString *)fileNameExtensionForType:(NSString *)typeName saveOperations:(UIDocumentOperation)saveOption;
=>
func fileNameExtensionForType(typeName: String!, saveOperations: UIDocumentOperation) -> String!

Ex:
let ext = document.fileNameExtensionForType("public.presentation", UIDocumentSaveOption.ForCreating)

Blocks & Closure
~~~~~~~~~~~~~~~~
-(void) saveToURL:(NSURL *)url
        forSaveOperation:(UIDocumentSaveOperation)saveOperation
        completionHandler:(void (^)(BOOL success))completionHandler;

=>
func saveToURL(url: NSURL!, saveOperation: UIDocumentSaveOperation!, completionHandler:((success: Bool) -> Void!);

Ex:
document.saveToURL(documentUrl, saveOperation: UIDocumentSaveOperation.ForCreating){sucess in 
                                                                                        if(success) {...} else {...}}
*/

/*
Creating Objects
================
-(instancetype)initWithFileURL:(NSURL *)url;
=>
init(fileURL: NSURL)

Factory Method
~~~~~~~~~~~~~~
+(UIColor *)colorWithRed:(CGFloat)red green:(CGFloat)green blue:(CGFloat)blue alpha:(CGFloat)alpha;
=>
class func colorWithRed(red: Float, green: Float, blue: Float, alpha: Float) -> UIColor!


*/

/*
Enum
=====
typedef NS_ENUM(NSInteger, UIDocumentSaveOperation){
    UIDocumentSaveForCreating,
    UIDocumentSaveForOverwriting

};

=>
enum UIDocumentSaveOperation: Int{
    case ForCreating
    case ForOverwriting
}

Ex:
let ext = document.fileNameExtensionForType("public.presentation", UIDocumentSaveOption.ForCreating)
*/

/*
NSError
=======
-(id)contentForType:(NSString *)typeName error:(NSError **)error;
=>
func contentForType(typeName: String!, error:NSErrorPointer) -> AnyObject!

Example:
var error: NSError?
if let contents = document.contentForType("public.presentation", error:&error){
    //Use the content
} else if let actualError = error{
    //Handle Error
}

*/

/*
Upcasting/Downcasting with id/AnyObject
=======================================
Upcasting
~~~~~~~~~
id object = [[NSURL alloc] initWithString:@"http://developer.apple.com"]
object = view.superview;

[object removeFromSuperView];

id date = object[@"date"];

=>

var object:AnyObject = NSURL(string: "http://developer.apple.com")
object = view.superview;

object.removeFromSuperView

let date = object["date"]

presence of a method
--------------------
if([object respondToSelector:@selector(removeFromSuperView)]){
    [object removeFromSuperView];
}

=> 

A method of any object is optional
object.removeFromSuperView?()

Here ? provides us the support of optional chaining

Downcasting
~~~~~~~~~~~
AnyObject does not implicitly downcast
let view: UIView = object // This will give error - "AnyObject can not be implicitly downcast"

We will use as operator to downcast

let view: UIView = object as UIView

as? conditional down cast
let view: UIView = object as? UIView{
    //view is a UIView
}

*/

/*
Protocol
========
@protocol UITableViewDataSource<NSObject>
@optional
- (NSInteger)numberOfSectionInTableView:(UITableView *)tableView

@required
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;
@end

=>

protocol UITableViewDataSource: NSObjectProtocol{
    func tableView(tableView: UITableView, numberOfRowsInSection: Int) -> Int
    @optional func numberOfSectionInTableView(tableView: UITableView) -> Int

}

Protocol type in class
~~~~~~~~~~~~~~~~~~~~~~
@proprty id<UITableViewDataSource> dataSource

=> 
var dataSource: UITableViewDataSource!

Exapmple:
if let dataSource = object as? UITableViewDataSource{
    var lastSection = 0;
    let numSections = dataSource.numberOfSectionInTableView(tableView) //This is optional

    lastSection = numSections - 1 // This will give us error
    
    let rowInLastSection = dataSource.tableView(tableView, numberOfSectonInTableView:lastSection)


}


if let dataSource = object as? UITableViewDataSource{
var lastSection = 0;
let numSections = dataSource.numberOfSectionInTableView?(tableView) //This is optional. We need to add a optional here

lastSection = numSections - 1

let rowInLastSection = dataSource.tableView(tableView, numberOfSectonInTableView:lastSection)


}


*/

/*
String
======
String in swift is unicode compliant and easy to iterate for character iteration

let dog = "Dog!"
for c in dog{
    println(c)
}

Character and Code Points
~~~~~~~~~~~~~~~~~~~~~~~~~
Low level operations (length, characterAtIndex) are not allowed in String
We can use countElements to identify number of characters

UTF-16 is avialable via a property
for codePoint in doc.UTF16{

}

We can also use UTF16 with countElements
ex: countElements(dog.UTF16)

NSString
~~~~~~~~~~
Foundation APIs are avialable in swift

let fruits = "apple;banana;cherry".componentSeparatedBy(":")
//This will inferred as [String]

We can cast as NSString to access property and category
("Hi How are you?" as NSString).myNSStringMethod()

extension String {
    func myNSStringMethod(){
        ...
    }
}

*/


/*
Array
=====
@property NSArray *toolBarItems;
=>
var toolBarItems: [AnyObjects]

Upcasting
~~~~~~~~~
[T] can be assingned to an [AnyObject]

let myToolBarItems:[UIToolbarItem] = [item1, item2, item3]
controller.toolbarItems = myToolBarItems

Downcasting
~~~~~~~~~~~
for object: AnyObject in viewController.toolBatItems{
    let item = object as UIBarButtonItem
    ...........
}

OR

for item in viewController.toolBatItems as [UIBarButtonItem]{
let item = item
...........
}


Returning an NSArray* from an objectve-c method to swift:
let items: [AnyObject] = viewController.toolbarItems

Passing a swift array to an objective-c method expecting an NSArray*
viewController.toolbarItems = myToolBarItems

*/


/*
Sub-classing
============
Swift class is similar to objective-c class. They share same runtime and memory management. Hence any class defined in objective-c can be overriden in swift calss using keyword "override"

We can override, methods & properties

If we explore swift class in Umbrella header, we can notice that

SWIFT_CLASS("_TtC12Swift_Sample14ViewController")
@interface ViewController : UIViewController
- (void)viewDidLoad;
- (void)didReceiveMemoryWarning;
- (void)display;
- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil OBJC_DESIGNATED_INITIALIZER;
- (instancetype)initWithCoder:(NSCoder *)aDecoder OBJC_DESIGNATED_INITIALIZER;
@end

Limitation of objective-C:
Tuples
Generics
Enum and Struct

@objc attribute, if we want any function, class and properties to be exposed to objective-c. In the above limitation will throw error, if we ant to expose it to objective-c

*/

/*
CF Interoperability
====================
void drawGradientRect(CGContextRef context, CGColorRef startColor, CGColorRef endColor, CGFloat width, CGFloat height){
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    NSArray *colors = @[(__bridge id)startColor, (__bridge id)endColor];
    CGFloat locations[2] = {0.0, 1.0};
    CGGradientRef gradient = CGGradientCreateWithColors(colorSpace, (CFArrayRef)colors, locations);
    CGPoint startPoint = CGPointMake(width/2, 0);
    CGPoint endPoint = CGPointMake(width/2, height);
    CGConextDrawLinearGradient(context, gradient, startPoint, endPoint, 0);
    CGColorSpaceRelease(colorSpace);
    CGGradientRelease(gradient);
}

=>
func drawGradientRect(context: CGContex, startColor: CGColor, endColor: CGColor, width:CGFloat, height: CGFloat){
    let colorSpace = CGColorSpaceCreateDeviceRGB();
    let gradient = CGGradientCreateWithColors(colorSpace, [startColor, endColor], [0.0, 1.0]);
    
    let startPoint = CGPoint(x:width/2, y:0)
    let endPoint = CGPoint(x:width/2, y:height)
    CGContextDrawLinearGradient(context, gradient, startPoint, endPoint, 0)
}


Some CF APIs have not been audited for implicit briding
e.g. CGColorRef CGColorGetRandomColor(void)

We will be using explicit briding. Swift uses Unmanaged<T> for this purpose.
e.g. func CGColorGetRandomColor() -> Unmanaged<CGColor>

Unmanaged<T>: This enabled manual memory management

struct Unmanged<T: AnyObject>{
    func takeUnretainedValue()->T
    func takeRetainedValue()->T
}

let color = CGColorGetRandomColor().takeUnretainedValue()

Note:
Swift uses Unmanged<T> when the ownership convention is unknown

func CGColorGetRandomColor() -> Unmanaged<CGColor>

We can use the macros: 
CF_IMPLICIT_BRIDGING_ENABLED
CF_IMPLICIT_BRIDGING_DISABLED
*/









































