//
//  MyObjcClass.m
//  Swift_Sample
//
//  Created by sumantar on 20/08/14.
//  Copyright (c) 2014 sumantar. All rights reserved.
//

#import "MyObjcClass.h"

//Umbrella header
#import "Swift_Sample-Swift.h"

@implementation MyObjcClass
- (void) someMethod {
    NSLog(@"SomeMethod Ran...");

    ViewController *ctrl = [[ViewController alloc] init];
    [ctrl display];
    
}
@end
