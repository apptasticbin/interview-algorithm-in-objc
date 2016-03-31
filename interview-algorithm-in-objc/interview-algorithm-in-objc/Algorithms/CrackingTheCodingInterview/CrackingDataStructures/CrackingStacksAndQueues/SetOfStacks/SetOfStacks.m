//
//  SetOfStacks.m
//  interview-algorithm-in-objc
//
//  Created by Bin Yu on 31/03/16.
//  Copyright © 2016 Bin Yu. All rights reserved.
//

#import "SetOfStacks.h"
#import "Stack.h"

@implementation SetOfStacks

#pragma mark - Public

- (instancetype)initWithThreshold:(NSInteger)threshold {
    self = [super init];
    if (self) {
        // threshdol MUST greater than 0
        _threshold = threshold;
        _itemCount = 0;
        _stackBuffer = [NSMutableArray array];
    }
    return self;
}

- (void)push:(NSInteger)data {
    self.itemCount++;
    if (self.itemCount % self.threshold == 1) {
        [self.stackBuffer addObject:[[Stack alloc] initWithCapacity:self.threshold]];
    }
    Stack *currentStack = [self.stackBuffer lastObject];
    [currentStack push:data];
}

- (NSInteger)pop {
    return [self popAtIndex:self.stackBuffer.count-1];
}

- (NSInteger)popAtIndex:(NSInteger)stackIndex {
    if (!self.itemCount) {
        @throw [NSException exceptionWithName:@"EmptyStackException" reason:@"Stack is empty" userInfo:nil];
    }
    if (stackIndex >= self.stackBuffer.count) {
        @throw [NSException exceptionWithName:@"OutOfStackIndexException" reason:@"Out of stack index" userInfo:nil];
    }
    Stack *stack = [self.stackBuffer objectAtIndex:stackIndex];
    NSInteger data = [stack pop];
    self.itemCount--;
    /** 
     if the stack is not last stack, then we need to shift following items LEFT to fill the empty space in this stack
     */
    for (NSInteger idx=stackIndex+1; idx<self.stackBuffer.count; idx++) {
        Stack *thisStack = self.stackBuffer[idx-1];
        Stack *thatStack = self.stackBuffer[idx];
        while (![thisStack isFull] && ![thatStack isEmpty]) {
            [thisStack push:[thatStack popFromBottom]];
        }
    }
    /**
     - now check if last stack is empty or not
     - if empty, remove it
     */
    stack = [self.stackBuffer lastObject];
    if ([stack isEmpty]) {
        [self.stackBuffer removeObject:stack];
    }
    return data;
}

- (NSInteger)popAtIndexRecursively:(NSInteger)stackIndex {
    return [self leftShiftAtIndex:stackIndex popTop:YES];
}

- (NSInteger)leftShiftAtIndex:(NSInteger)index popTop:(BOOL)popTop {
    Stack *stack = [self.stackBuffer objectAtIndex:index];
    NSInteger popData = 0;
    if (popTop) {
        popData = [stack pop];
    } else {
        popData = [stack popFromBottom];
    }
    if ([stack isEmpty]) {
        [self.stackBuffer removeObject:stack];
    } else if (index + 1 < self.stackBuffer.count) {
        NSInteger leftShiftData = [self leftShiftAtIndex:index+1 popTop:NO];
        [stack push:leftShiftData];
    }
    return popData;
}

@end
