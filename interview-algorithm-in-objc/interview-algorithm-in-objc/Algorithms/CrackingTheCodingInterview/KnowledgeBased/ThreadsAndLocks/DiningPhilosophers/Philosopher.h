//
//  Philosopher.h
//  interview-algorithm-in-objc
//
//  Created by Bin Yu on 27/04/16.
//  Copyright © 2016 Bin Yu. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Chopstick;

@interface Philosopher : NSThread

@property(nonatomic, strong) Chopstick *leftChopstick;
@property(nonatomic, strong) Chopstick *rightChopstick;
@property(nonatomic, assign) NSInteger bites;

- (instancetype)initWithChopsticksLeft:(Chopstick *)left right:(Chopstick *)right;

@end
