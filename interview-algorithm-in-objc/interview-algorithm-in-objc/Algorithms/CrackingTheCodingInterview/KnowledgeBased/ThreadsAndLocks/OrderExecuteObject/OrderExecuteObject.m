//
//  OrderExecuteObject.m
//  interview-algorithm-in-objc
//
//  Created by Bin Yu on 29/04/16.
//  Copyright © 2016 Bin Yu. All rights reserved.
//

#import "OrderExecuteObject.h"

/**
 - difference between lock, mutex and semaphore:
 http://stackoverflow.com/questions/2332765/lock-mutex-semaphore-whats-the-difference
 - ios dispatch semaphore:
 http://www.g8production.com/post/76942348764/wait-for-blocks-execution-using-a-dispatch
 - Semaphore:
 https://developer.apple.com/library/mac/documentation/Performance/Reference/GCD_libdispatch_Ref/index.html#//apple_ref/c/func/dispatch_semaphore_create
 - dispatch_semaphore_create:
 Passing zero for the value is useful for when two threads need to reconcile the completion of a particular event. 
 Passing a value greater than zero is useful for managing a finite pool of resources, where the pool size is equal to the value
 */
@interface OrderExecuteObject ()

@property(nonatomic, retain) dispatch_semaphore_t semaphore1;
@property(nonatomic, retain) dispatch_semaphore_t semaphore2;

@end

@implementation OrderExecuteObject

- (instancetype)init
{
    self = [super init];
    if (self) {
        _semaphore1 = dispatch_semaphore_create(0);
        _semaphore2 = dispatch_semaphore_create(0);
    }
    return self;
}

- (void)methed1 {
    dispatch_semaphore_signal(self.semaphore1);
}

- (void)method2 {
    dispatch_semaphore_wait(self.semaphore1, DISPATCH_TIME_FOREVER);
    dispatch_semaphore_signal(self.semaphore2);
}

- (void)method3 {
    dispatch_semaphore_wait(self.semaphore2, DISPATCH_TIME_FOREVER);
}

@end
