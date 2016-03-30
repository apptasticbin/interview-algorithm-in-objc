//
//  FixedSizeArrayStack.h
//  interview-algorithm-in-objc
//
//  Created by Bin Yu on 30/03/16.
//  Copyright © 2016 Bin Yu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FixedSizeArrayThreesomeStack : NSObject

@property(nonatomic, readonly, assign) NSInteger oneStackCapacity;

+ (FixedSizeArrayThreesomeStack *)stackWithOneStackCapacity:(NSInteger)oneStackCapacity;

- (void)pushData:(NSInteger)data toStack:(NSInteger)stackNumber;
- (NSInteger)popDataFromStack:(NSInteger)stackNumber;
- (NSInteger)peekOfStack:(NSInteger)stackNumber;
- (BOOL)isStackEmpay:(NSInteger)stackNumber;

@end
