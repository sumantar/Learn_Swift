//
//  ViewController.swift
//  Swift_Sample
//
//  Created by sumantar on 23/06/14.
//  Copyright (c) 2014 sumantar. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
                            
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        sample()
        
        sayHello(name: "Sumanta", flag: "!!!")
        sayHello(flag: "!!!")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func sample(){
        
        let possibleLegCount1: Int? = nil
        let legCount = possibleLegCount1!
        //legCount
        switch legCount{
        case 0:
            
            println("0")
        case 1:
            println("1")
            //default:
            //    println("")
            //switch must be exhaustive, consider adding a default clause
        default:
            println("default")
        }

//        println("sample method")
//        NSLog("sample method - NSLog")
//        let wiseWords = "\"Imagination is more important than knowledge\" - Einstein"
//        let dollarSign = "\x24"
//        let blackHeart = "\u2665"
//        let sparklingHeart = "\U0001F496"
//        
//        NSLog(wiseWords)
//        NSLog(dollarSign)
//        NSLog(blackHeart)
//        NSLog(sparklingHeart)
//        
//        let π = 3.14159
//        let 你好 = "你好世界"
//        let 🐶🐮 = "dogcow"
//        
//        println(π)
//        
//        let dog:Character = "🐶"
//        let cow:Character = "🐮"
//        
//        let dogCow = dog+cow
//        
//        println(dogCow)
//        
//        var names = ["Anna", "Alex", "Briyan", "Jack"]
//        var numberOfLegs = ["ant": 6, "snake": 0, "cheetah": 4]
//        
//        for number in 1...5{
//            println("\(number) times 4 is \(number * 4)")
//        }
//        
//        println("=================")
//        
//        for number in 0..5{
//            println("\(number) times 4 is \(number * 4)")
//        }
//        
//        println("=================")
//        
//        for (animalName, legCount) in numberOfLegs{
//            println("\(animalName)s have \(legCount) legs")
//        }
//        
//        println("=================")
//        
//        let possibleLegCount: Int? = numberOfLegs["spider"]
//        if possibleLegCount == nil{
//            println("spider was not found")
//        }
//        else{
//            let legCount = possibleLegCount
//            println("A spider has \(legCount) legs")
//        }
//        
//        println("=================")
//        
//        let possibleLegCount1: Int? = numberOfLegs["cheetah"]
//        if possibleLegCount1 == nil{
//            println("cheetah was not found")
//        }
//        else{
//            let legCount = possibleLegCount1!
//            println("A cheetah has \(legCount) legs")
//        }
//        
//        println("=================")
//        var neighbors = ["Alex", "Anna", "Madission", "Dave"]
//        let index:Int? = 2 //findIndexOfString("Madission",neighbors)
//        if index{
//            println("Hello, \(neighbors[index!])")
//        }
//        else{
//            println("Must have moved away")
//        }
//        
//        println("=================")
//        
//        let greetingPrinter1:()->() = {
//            println("Hello Buddy")
//        }
//        
//        greetingPrinter1()
//        
//        func repeat(count: Int, task:()->()){
//            for i in 0..count{
//                task()
//            }
//        }
//        
//        repeat(2, {
//            println("Hello World->->!!!!")
//            })
        
    }

    func sayHello(name: String = "World", flag: String){
        println("Hello \(name) \(flag)")
        UILabel()
    }
    
    

}

