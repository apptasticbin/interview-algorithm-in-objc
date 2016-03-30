//
//  FixedSizeArrayStack.m
//  interview-algorithm-in-objc
//
//  Created by Bin Yu on 30/03/16.
//  Copyright © 2016 Bin Yu. All rights reserved.
//

#import "FixedSizeArrayThreesomeStack.h"

static const NSInteger AmountOfStacks = 3;

@interface FixedSizeArrayThreesomeStack ()

@property(nonatomic, readwrite, assign) NSInteger oneStackCapacity;
@property(nonatomic, strong) NSMutableArray *bufferArray;
@property(nonatomic, strong) NSMutableArray *topArray;

@end

@implementation FixedSizeArrayThreesomeStack

#pragma mark - Public

+ (FixedSizeArrayThreesomeStack *)stackWithOneStackCapacity:(NSInteger)oneStackCapacity {
    return [[FixedSizeArrayThreesomeStack alloc] initWithOneStackCapacity:oneStackCapacity];
}

- (void)pushData:(NSInteger)data toStack:(NSInteger)stackNumber {
    if (!data || stackNumber < 0 || stackNumber > AmountOfStacks - 1) {
        @throw [NSException exceptionWithName:@"FixedSizeArrayThreeSomeStackException"
                                       reason:@"push data errors"
                                     userInfo:nil];
    }
    NSInteger stackTop = [self.topArray[stackNumber] integerValue];
    if (stackTop + 1 >= self.oneStackCapacity) {
        @throw [NSException exceptionWithName:@"FixedSizeArrayThreeSomeStackException"
                                       reason:@"stack out of capacity"
                                     userInfo:nil];
    }
    stackTop++;
    self.topArray[stackNumber] = @(stackTop);
    self.bufferArray[stackTop + self.oneStackCapacity * stackNumber] = @(data);
}

- (NSInteger)popDataFromStack:(NSInteger)stackNumber {
    if (stackNumber < 0 || stackNumber > AmountOfStacks - 1) {
        @throw [NSException exceptionWithName:@"FixedSizeArrayThreeSomeStackException"
                                       reason:@"pop data errors"
                                     userInfo:nil];
    }
    NSInteger stackTop = [self.topArray[stackNumber] integerValue];
    if (stackTop == -1) {
        @throw [NSException exceptionWithName:@"FixedSizeArrayThreeSomeStackException"
                                       reason:@"pop empty stack"
                                     userInfo:nil];
    }
    NSInteger data = [self.bufferArray[stackTop + self.oneStackCapacity * stackNumber] integerValue];
    // clean buffer
    self.bufferArray[stackTop + self.oneStackCapacity * stackNumber] = [NSNull null];
    stackTop--;
    self.topArray[stackNumber] = @(stackTop);
    return data;
}

- (NSInteger)peekOfStack:(NSInteger)stackNumber {
    if (stackNumber < 0 || stackNumber > AmountOfStacks - 1) {
        @throw [NSException exceptionWithName:@"FixedSizeArrayThreeSomeStackException"
                                       reason:@"wrong stack number error"
                                     userInfo:nil];
    }
    NSInteger stackTop = [self.topArray[stackNumber] integerValue];
    return [self.bufferArray[stackTop + self.oneStackCapacity * stackNumber] integerValue];
}

- (BOOL)isStackEmpay:(NSInteger)stackNumber {
    if (stackNumber < 0 || stackNumber > AmountOfStacks - 1) {
        @throw [NSException exceptionWithName:@"FixedSizeArrayThreeSomeStackException"
                                       reason:@"wrong stack number error"
                                     userInfo:nil];
    }
    NSInteger stackTop = [self.topArray[stackNumber] integerValue];
    return stackTop == -1;
}

#pragma mark - Private

- (instancetype)initWithOneStackCapacity:(NSInteger)oneStackCapacity {
    self = [super init];
    if (self) {
        _oneStackCapacity = oneStackCapacity;
        _bufferArray = [NSMutableArray arrayWithCapacity:_oneStackCapacity * AmountOfStacks];
        _topArray = [NSMutableArray arrayWithObjects:@(-1), @(-1), @(-1), nil];
        [self initBufferArray];
    }
    return self;
}

/**
 - The capacity of NSMutableArray ONLY tells runtime the initial size of array,
 But the actually size of array is still '0' if you don't insert anything.
 - We need to mannually initialize the array with [NSNull null]
 */

- (void)initBufferArray {
    for (NSInteger i = 0; i < _oneStackCapacity * AmountOfStacks; i++) {
        [_bufferArray insertObject:[NSNull null] atIndex:i];
    }
}

@end
