//
//  SetOfStacks.h
//  interview-algorithm-in-objc
//
//  Created by Bin Yu on 31/03/16.
//  Copyright © 2016 Bin Yu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SetOfStacks : NSObject

@property(nonatomic, strong) NSMutableArray *stackBuffer;
@property(nonatomic, assign) NSInteger threshold;
@property(nonatomic, assign) NSInteger itemCount;

- (instancetype)initWithThreshold:(NSInteger)threshold;
- (void)push:(NSInteger)data;
- (NSInteger)pop;
- (NSInteger)popAtIndex:(NSInteger)stackIndex;
- (NSInteger)popAtIndexRecursively:(NSInteger)stackIndex;

@end
