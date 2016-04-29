//
//  Philosopher.m
//  interview-algorithm-in-objc
//
//  Created by Bin Yu on 27/04/16.
//  Copyright © 2016 Bin Yu. All rights reserved.
//

#import "Philosopher.h"
#import "Chopstick.h"

@implementation Philosopher

- (instancetype)initWithChopsticksLeft:(Chopstick *)left right:(Chopstick *)right {
    self = [super init];
    if (self) {
        _leftChopstick = left;
        _rightChopstick = right;
        _bites = 10;
    }
    return self;
}

- (void)main {
    for (NSInteger i=0; i<self.bites; i++) {
        [self eat];
    }
}

#pragma mark - Private

- (void)eat {
    if ([self pickUp]) {
        [self chew];
        [self putDown];
    }
}

- (void)chew {
    
}

- (BOOL)pickUp {
    if (![self.leftChopstick pickUp]) {
        return NO;
    }
    if (![self.rightChopstick pickUp]) {
        [self.leftChopstick putDown];
        return NO;
    }
    return YES;
}

- (void)putDown {
    [self.leftChopstick putDown];
    [self.rightChopstick putDown];
}

@end
