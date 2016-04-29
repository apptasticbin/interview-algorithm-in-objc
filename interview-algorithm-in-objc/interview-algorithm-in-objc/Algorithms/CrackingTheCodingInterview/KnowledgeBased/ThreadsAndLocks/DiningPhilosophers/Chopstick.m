//
//  Chopstick.m
//  interview-algorithm-in-objc
//
//  Created by Bin Yu on 27/04/16.
//  Copyright © 2016 Bin Yu. All rights reserved.
//

#import "Chopstick.h"

@interface Chopstick ()

/**
 Difference between @synchronized and NSLock:
 http://stackoverflow.com/a/1215541/4269184
 */
@property(nonatomic, strong) NSLock *lock;

@end

@implementation Chopstick

- (BOOL)pickUp {
    return [self.lock tryLock];
}

- (void)putDown {
    [self.lock unlock];
}

@end
