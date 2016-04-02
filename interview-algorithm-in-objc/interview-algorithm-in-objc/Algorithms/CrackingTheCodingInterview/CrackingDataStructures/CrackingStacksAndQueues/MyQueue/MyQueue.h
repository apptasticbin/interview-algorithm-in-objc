//
//  MyQueue.h
//  interview-algorithm-in-objc
//
//  Created by Bin Yu on 01/04/16.
//  Copyright © 2016 Bin Yu. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Stack;

@interface MyQueue : NSObject

@property(nonatomic, strong) Stack *enqueueStack;
@property(nonatomic, strong) Stack *dequeueStack;

- (void)enqueue:(NSInteger)data;
- (NSInteger)dequeue;
- (NSInteger)peek;

@end
