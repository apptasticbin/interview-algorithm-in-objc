//
//  MyQueue.m
//  interview-algorithm-in-objc
//
//  Created by Bin Yu on 01/04/16.
//  Copyright © 2016 Bin Yu. All rights reserved.
//

#import "MyQueue.h"
#import "Stack.h"

@implementation MyQueue

- (instancetype)init
{
    self = [super init];
    if (self) {
        _enqueueStack = [Stack new];
        _dequeueStack = [Stack new];
    }
    return self;
}

- (void)enqueue:(NSInteger)data {
    [self.enqueueStack push:data];
}

- (NSInteger)dequeue {
    [self shiftStacks];
    return [self.dequeueStack pop];
}

- (NSInteger)peek {
    [self shiftStacks];
    return [self.dequeueStack peek];
}

#pragma mark - Private

- (void)shiftStacks {
    if ([self.dequeueStack isEmpty]) {
        while (![self.enqueueStack isEmpty]) {
            [self.dequeueStack push:[self.enqueueStack pop]];
        }
    }
}

@end
