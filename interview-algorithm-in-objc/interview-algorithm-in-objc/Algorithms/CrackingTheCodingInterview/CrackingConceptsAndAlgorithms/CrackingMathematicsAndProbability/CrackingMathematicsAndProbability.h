//
//  CrackingMathematicsAndProbability.h
//  interview-algorithm-in-objc
//
//  Created by Bin Yu on 13/04/16.
//  Copyright © 2016 Bin Yu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Line : NSObject

@property(nonatomic, assign) double slope;
@property(nonatomic, assign) double yIntercept;

- (instancetype)initWithSlope:(double)slope yIntersect:(double)yIntercept;

@end

@interface CrackingMathematicsAndProbability : NSObject

+ (BOOL)intersectOfLine:(Line *)line1 andLine:(Line *)line2;
+ (NSInteger)multiply:(NSInteger)a and:(NSInteger)b;
+ (NSInteger)substract:(NSInteger)a by:(NSInteger)b;
+ (NSInteger)divide:(NSInteger)a by:(NSInteger)b;
+ (NSInteger)kthNumberMadeBy357:(NSInteger)k;

@end
