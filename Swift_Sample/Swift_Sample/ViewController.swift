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
        
        let objCObject:MyObjcClass = MyObjcClass()
        objCObject.someProperty = "Hello World"
        println(objCObject.someProperty)
        objCObject.someMethod()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func display(){
        println("Hello display method!!!")
    }

}




































