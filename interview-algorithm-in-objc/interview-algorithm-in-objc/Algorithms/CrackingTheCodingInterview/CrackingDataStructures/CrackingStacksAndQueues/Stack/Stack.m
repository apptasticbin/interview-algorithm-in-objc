//
//  Stack.m
//  interview-algorithm-in-objc
//
//  Created by Bin Yu on 29/03/16.
//  Copyright © 2016 Bin Yu. All rights reserved.
//

#import "Stack.h"
#import "LinkedListNode.h"

@implementation Stack

- (instancetype)initWithCapacity:(NSInteger)capacity {
    self = [super init];
    if (self) {
        _capacity = capacity;
        _count = 0;
    }
    return self;
}

- (instancetype)init
{
    // no capacity limit by default
    return [self initWithCapacity:-1];
}

- (void)push:(NSInteger)data {
    LinkedListNode *newTop = [LinkedListNode nodeWithData:data];
    newTop.next = self.top;
    self.top = newTop;
    self.count++;
}

- (NSInteger)pop {
    [self emptyGuard];
    NSInteger topData = self.top.data;
    self.top = self.top.next;
    self.count--;
    return topData;
}

- (NSInteger)popFromBottom {
    [self emptyGuard];
    if (!self.top.next) {
        return [self pop];
    }
    LinkedListNode *runner = self.top.next;
    LinkedListNode *previous = self.top;
    while (runner.next) {
        previous = runner;
        runner = runner.next;
    }
    previous.next = nil;
    self.count--;
    return runner.data;
}

- (NSInteger)peek {
    [self emptyGuard];
    return self.top.data;
}

- (BOOL)isEmpty {
    return !self.top;
}

- (BOOL)isFull {
    return [self count] == self.capacity;
}

#pragma mark - Private

- (void)emptyGuard {
    if ([self isEmpty]) {
        @throw [NSException exceptionWithName:@"EmptyStackException"
                                       reason:@"Stack is empty"
                                     userInfo:nil];
    }
}

@end
