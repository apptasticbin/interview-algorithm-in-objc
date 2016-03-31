//
//  StackWithMinimum.m
//  interview-algorithm-in-objc
//
//  Created by Bin Yu on 31/03/16.
//  Copyright © 2016 Bin Yu. All rights reserved.
//

#import "StackWithMinimum.h"

@interface  StackWithMinimum ()

@property(nonatomic, strong) Stack *minimumStack;

@end

@implementation StackWithMinimum

- (NSInteger)min {
    return [self.minimumStack peek];
}

- (void)push:(NSInteger)data {
    [super push:data];
    [self pushMinStackIfNeeded:data];
}

- (NSInteger)pop {
    [self popMinStackIfNeeded:[self peek]];
    return [super pop];
}

#pragma mark Private

- (instancetype)init {
    self = [super init];
    if (self) {
        _minimumStack = [Stack new];
    }
    return self;
}

- (void)pushMinStackIfNeeded:(NSInteger)data {
    if ([self.minimumStack isEmpty] || data < [self min]) {
        [self.minimumStack push:data];
    }
}

- (void)popMinStackIfNeeded:(NSInteger)data {
    if ([self min] == data) {
        [self.minimumStack pop];
    }
}

@end
