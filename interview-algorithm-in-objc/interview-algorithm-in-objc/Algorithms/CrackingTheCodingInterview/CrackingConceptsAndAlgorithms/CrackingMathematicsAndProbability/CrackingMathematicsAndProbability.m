//
//  CrackingMathematicsAndProbability.m
//  interview-algorithm-in-objc
//
//  Created by Bin Yu on 13/04/16.
//  Copyright © 2016 Bin Yu. All rights reserved.
//

#import "CrackingMathematicsAndProbability.h"
#import "Queue.h"

#pragma mark - Line

@implementation Line

- (instancetype)initWithSlope:(double)slope yIntersect:(double)yIntercept {
    self = [super init];
    if (self) {
        _slope = slope;
        _yIntercept = yIntercept;
    }
    return self;
}

@end

#pragma mark - CrackingMathematicsAndProbability

@implementation CrackingMathematicsAndProbability

/**
 Given two lines on a Cartesian plane, determine whether the two lines would intersect.
 */

/**
 In problems like these, be aware of the following:
 - Ask questions. This question has a lot of unknowns—ask questions to clarify them. 
 Many interviewers intentionally ask vague questions to see if you'll clarify your assumptions.
 - When possible, design and use data structures. It shows that you understand 
 and care about object-oriented design.
 - Think through which data structures you design to represent a line.
 There are a lot of options, with lots of trade-offs. Pick one, and explain 
 your choice. 
 - DON'T assume that the slope and y-intercept are integers.
 - Understand "limitations of floating point representations". Never check for equality
 with ==. Instead, check if the difference is less than an epsilon value.
 */

/**
 http://stackoverflow.com/questions/10334688/how-dangerous-is-it-to-compare-floating-point-values
 Objective-C can compare float numbers, but risk ?
 */

+ (BOOL)intersectOfLine:(Line *)line1 andLine:(Line *)line2 {
     return fabs(line1.slope - line2.slope) > DBL_EPSILON ||
    fabs(line1.yIntercept - line2.yIntercept) < DBL_EPSILON;
}

/**
 Write methods to implement the multiply, subtract, and divide operations for integers. 
 Use only the add operator
 */

/**
 In tackling this problem, you should be aware of the following:
 - A logical approach of going back to what exactly multiplication and division do comes in handy. 
 Remember that. All (good) interview problems can be approached in a logical, methodical way!
 - The interviewer is looking for this sort of logical work-your-way-through-it approach.
 - This is a great problem to demonstrate your ability to write clean code—specifically, 
 to show your ability to reuse code. Forexample, if you were writing this solution and didn't put 
 negate in its own method, you should move it into its own method once you see that you'll use it
 multiple times.
 - Be careful about making assumptions while coding. Don't assume that the numbers are all positive
 or that a is bigger than b.
 */

+ (NSInteger)multiply:(NSInteger)a and:(NSInteger)b {
    if (a < b) {
        return [self multiply:b and:a];
    }
    if (b < 0) {
        return [self negate:[self multiply:a and:[self negate:b]]];
    }
    NSInteger c = 0;
    for (NSInteger i=0; i<b; i=i+1) {
        c = c + a;
    }
    return c;
}

+ (NSInteger)substract:(NSInteger)a by:(NSInteger)b {
    return a + [self negate:b];
}

+ (NSInteger)divide:(NSInteger)a by:(NSInteger)b {
    if (!b) {
        @throw [NSException exceptionWithName:@"ZeroDivideException"
                                       reason:@"number divided by zero"
                                     userInfo:nil];
    }
    if (a < 0) {
        return [self divide:[self negate:a] by:[self negate:b]];
    }
    if (b < 0) {
        return [self negate:[self divide:a by:[self negate:b]]];
    }
    NSInteger c = 0;
    while (b <= a) {
        c = c + 1;
        b = b + b;
    }
    return c;
}

+ (NSInteger)negate:(NSInteger)number {
    NSInteger negateNumber = 0;
    NSInteger d = number < 0 ? 1 : -1;
    while (number) {
        negateNumber = negateNumber + d;
        number = number + d;
    }
    return negateNumber;
}

+ (NSInteger)abs:(NSInteger)number {
    if (number < 0) {
        return [self negate:number];
    }
    return number;
}

/**
 Given two squares on a two-dimensional plane, find a line that would cut these two squares in half. 
 Assume that the top and the bottom sides of the square run parallel to the x-axis.
 */

/**
 Given a two-dimensional graph with points on it, find a line which passes the most number of points.
 */

/**
 Design an algorithm to find the kth number such that the only prime factors are 3, 5, and 7.
 */

/**
 - Chances are that your interviewer will help you along when you get stuck. 
 Whatever you do, don't give up! Think out loud, wonder out loud, and explain your thought process. 
 Your interviewer will probably jump in to guide you.
 - Remember, perfection on this problem is not expected. Your performance isevaluated in comparison 
 to other candidates. Everyone struggles on a tricky proble
 */

+ (NSInteger)kthNumberMadeBy357:(NSInteger)k {
    /**
     3(i) + 5(j) + 7(k)
     */
    if (k < 0) {
        return 0;
    }
    NSInteger next = 0;
    Queue *queue3 = [Queue new];
    Queue *queue5 = [Queue new];
    Queue *queue7 = [Queue new];
    [queue3 enqueue:@(1)];
    for (NSInteger i=0; i<=k; i++) {
        NSInteger q3 = queue3.count > 0 ? [[queue3 peek] integerValue] : LONG_MAX;
        NSInteger q5 = queue5.count > 0 ? [[queue5 peek] integerValue] : LONG_MAX;
        NSInteger q7 = queue7.count > 0 ? [[queue7 peek] integerValue] : LONG_MAX;
        next = MIN(q3, MIN(q5, q7));
        if (next == q3) {
            [queue3 dequeue];
            [queue3 enqueue:@(3 * next)];
            [queue5 enqueue:@(5 * next)];
        } else if (next == q5) {
            [queue5 dequeue];
            [queue5 enqueue:@(5 * next)];
        } else if (next == q7) {
            [queue7 dequeue];
        }
        [queue7 enqueue:@(7 * next)];
    }
    return next;
}

@end
