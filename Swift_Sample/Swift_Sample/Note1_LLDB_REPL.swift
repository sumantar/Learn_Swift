//
//  Note1_LLDB_REPL.swift
//  Swift_Sample
//
//  Created by sumantar on 21/08/14.
//  Copyright (c) 2014 sumantar. All rights reserved.
//

import Foundation

/*
LLDB is more powerful with Swift
-> Stack diagnosis as a stopped app
-> Break points to stop app when ever it is needed
-> expr: Expression command to inspect data

REPL: Read-eval-print-loop
~~~~~~~~~~~~~~~~~~~~~~~~~~
Powerful debugging tool

> (lldb) repl

sudo xcode-select -s /Applications/Xcode6-Beta.app/Contents/Developer/

$ xcrun swift
This will run repl in command prompt

:help		=> prints all required help for repl
:quit		=> quit repl

Example:
var my_variable = "this is a swift string"
my_variable
$R0: String = "this is a swift string"

my_var: String = "Hello"
my_var
$R1: String = "Hello"

var may_var1="Hello1"
may_var1
$R2: String = "Hello1"

my_var
$R3: String = "Hello"

*/

/*
LLDB
=====
break foo.m:12
=> It will break on file foo.m with line number 12

break foo
=> It will break at function foo

=> To set break point
breakpoint set --name foo
breakpoint set -n foo
breakpoint set --name foo --name bar

watchpoint
=> Gives us all help related to command ‘watchpoint'
watchpoint list

process launch
run
r
=> It will run the app

thread
~~~~~~
(lldb) thread
=> It will print all the help for the thread

thread until 100
=> This command will run the thread in the current frame till it reaches line 100 in this frame or stops if it leaves the current frame

thread list
thread backtrace
thread info
thread backtrace all
thread select 2

Examining Stack Frame
~~~~~~~~~~~~~~~~~~~~~
frame variable
=> It will print the stack and all local variables
frame variable self
frame variable self.isa
frame variable *self
frame select 9 	
=> We can select another frame


Expression Command
~~~~~~~~~~~~~~~~~~
=> evaluates it in the scope of the currently selected frame.
(lldb) expr self
$0 = (SKTGraphicView *) 0x0000000100135430
(lldb) expr self = 0x00
$1 = (SKTGraphicView *) 0x0000000000000000
(lldb) frame var self
(SKTGraphicView *) self = 0x0000000000000000

Print and PrintObject
~~~~~~~~~~~~~~~~~~~~~
p = print
po = print object

po [self view]
po self.view

=> to get the number of subviews contained by our view controller’s view, we can use p not po
p (int)[[[self view] subviews] count]
p ((self.view).subviews).count

po [[response filteredArrayUsingPredicate:(NSPredicate*)[NSPredicate
    predicateWithFormat:@"retweet_count > 0 and retweeted_status.entities.urls.@count > 0"]]
    valueForKeyPath:@"retweeted_status”]

=> Formatted String
po [[NSString alloc] initWithFormat:@"Item index is: %d", index]

*/

/*
Debugging Servival Skill
========================
We need to ask following questions:
1) What is the stop reason?
2) How did this code gets called?
    a) Lookup the stack trace
    b) Find where things went bad
3) What are the failure condition?
    a) Find problematic function
    b) Inspect variables to find bad data

*/

/*
Reading a stopped App
=====================
To find out the stop reason, we can print thread info
-> thread info
(ti)
OR
-> thread list


It will provide us the "stop reason"
We will also find out, if it is from standard library code or ouw own written code

EXEC_BAD_INSTRUCTION
It is usually used in assertion i.e. assertion failed

How did this code gets called?
==============================
-> thread backtrace
(bt)

look into the stack frames and "top_level_code"

Identify the failure condition
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Once we have back trace, we can examine stack frame to identify local data hold by stack

-> f 1

or
-> f 17

etc.. depending on the findings

once we have variables/methods in stack trace, we can print them using "p" OR "po" command
-> p foo
-> p viewDidLoad
-> p MyObjcClass()

Note:
EXE_BAD_INSTRUCTION => Assertion failed
SIGABRT             => Exception
EXE_BAD_ACCESS      => Memory issue

*/

/*
Stopping at the right time
==========================
We can add exception break point, Symbolic break point etc...

However, we can edit (RMC on break ponit and select 'edit') any break point and and instruct to break for the following condition:
=> Specification where to stop
=> Location, matching the specification
=> Condition, stop if true
=> Actions, to perform when hit


Symbolic break point: if you have 3 methods with name, timestwo but takes 3 different input - int, float, string
With symbolic one, we can put break point to any one function. Similarly, we can add break points on regular expression etc...

Smart break point: break point will be triggered with a specific condition

Note:

We can filter  based on:

source location     =>  --file --line

function name       =>  --name

module or class     =>  --func-regex

variable values     =>  breakpoint modify --condition

*/

/*
repl:
====
> : 
break into lldb from repl

> :help


We can execute code snippet such as methods etc.. in repl

With repl, we can enable debugging feature.
Stack variable (with expression command, it will be more useful), Global Variable, Classes, Functions


Optional
~~~~~~~~
var optional:String? = nil
var doubleOptional:String?? = optional.some(nil)
=> by default, it propagates upwords

frame variable -R <objCObject>

OR

fr -R doubleOptional

*/
/*
Similarly, we can monitor protocols

frame variable -d run-target creature

OR

fr v -d r creature
(where creature is a protocol)


*/

/*
Suppose, we have a structure, then we can print the object of the structure as

-> po myobject


-> expr -l objc++

//Swift provides uniqueness 
Lets say a framework have a className. The same class name is also there in another framework.
Swift identifies it through Mangled Name concept

*/




func hello3(){
    
}

func hello4(){
    
}




































