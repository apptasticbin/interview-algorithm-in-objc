//
//  Matrix.h
//  interview-algorithm-in-objc
//
//  Created by Bin Yu on 18/04/16.
//  Copyright © 2016 Bin Yu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Matrix : NSObject<NSCoding>

@property(nonatomic, assign, readonly) NSUInteger row;
@property(nonatomic, assign, readonly) NSUInteger column;

+ (instancetype)matrixWithRow:(NSUInteger)row column:(NSUInteger)column;
- (instancetype)initWithRow:(NSUInteger)row column:(NSUInteger)column;
- (NSInteger)itemAtRow:(NSUInteger)row column:(NSUInteger)column;
- (void)setItemAtRow:(NSUInteger)row column:(NSUInteger)column data:(NSInteger)data;
- (Matrix *)clone;

@end
