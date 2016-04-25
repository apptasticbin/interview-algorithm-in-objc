//
//  CrackingResursionAndDP.m
//  interview-algorithm-in-objc
//
//  Created by Bin Yu on 14/04/16.
//  Copyright © 2016 Bin Yu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CrackingRecursionAndDP.h"
#import "Matrix.h"

@implementation CrackingRecursionAndDP

/**
 A child is running up a staircase with n steps, and can hop either 1 step, 2 steps, or 3 steps at a time. 
 Implement a method to count how many possible ways the child can run up the stairs.
 */

+ (NSInteger)possibleWaysToRunUpStaircase:(NSInteger)steps {
    NSMutableDictionary *possibleWaysOfSteps = [NSMutableDictionary dictionary];
    return [self possibleWaysToRunUpStaircase:steps possibleWaysOfSteps:possibleWaysOfSteps];
}

+ (NSInteger)possibleWaysToRunUpStaircase:(NSInteger)steps possibleWaysOfSteps:(NSMutableDictionary *)possibleWays {
    /**
     - O(power(3, n))
     - Regardless of whether or not you use dynamic programming, 
     note that the number of ways will quickly overflow the bounds of an integer. TOO MUCH possibilities.
     */
    if (steps < 0) {
        return 0;
    } else if (steps == 0) {
        return 1;
    } else if (possibleWays[@(steps)]) {
        return [possibleWays[@(steps)] unsignedIntegerValue];
    }
    return [self possibleWaysToRunUpStaircase:steps-1 possibleWaysOfSteps:possibleWays] +
    [self possibleWaysToRunUpStaircase:steps-2 possibleWaysOfSteps:possibleWays] +
    [self possibleWaysToRunUpStaircase:steps-3 possibleWaysOfSteps:possibleWays];
}

/**
 Imagine a robot sitting on the upper left corner of an X by Y grid. 
 The robot can only move in two directions: right and down. 
 How many possible paths are there for the robot to go from (0, 0) to (X, Y) ?
 
 FOLLOW UP:
 
 Imagine certain spots are "off limits," such that the robot cannot step on them. 
 Design an algorithm to find a path for the robot from the top left to the bottom right.
 */

/**
 - X! 阶乘 (factorial)
 - binomial expression
 - Think about each path as a string of length X+Y consisting X 'R's and Y 'D's.
 We know that the number of strings we can make with X+Y unique characters is (X+Y)!. 
 However, in this case, X of the characters are 'R's and Y are 'D's.
 Since the 'R's can be rearranged in X! ways, each of which is identical,
 and we can do an equivalent thing with the 'D's, we need to divide out by X! and Y!
 - (X + Y)! / X! * Y!
 */

+ (NSInteger)possiblePathsInGridBoard:(NSInteger)x y:(NSInteger)y {
    if (!x && !y) {
        return 1;
    }
    NSInteger possiblePath = 0;
    if (x >= 1) {
        possiblePath += [self possiblePathsInGridBoard:x-1 y:y];
    }
    if (y >= 1) {
        possiblePath += [self possiblePathsInGridBoard:x y:y-1];
    }
    return possiblePath;
}

/**
 - furture improvement: cache points which have already been visited.
 if point is visited, return YES;
 */

+ (BOOL)pathFromTopLeftToBottomRightInGridBoard:(NSInteger)x y:(NSInteger)y
                                           path:(NSMutableArray *)path
                                     blockSpots:(NSArray *)blockSpots {
    CGPoint point = CGPointMake(x, y);
    if (!x && !y) {
        [path addObject:[NSValue valueWithCGPoint:point]];
        return YES;
    }
    BOOL canMoveNext = NO;
    if (x >= 1 && [self canMoveTo:x-1 y:y blockSpots:blockSpots]) {
        canMoveNext = [self pathFromTopLeftToBottomRightInGridBoard:x-1 y:y path:path blockSpots:blockSpots];
    }
    if (!canMoveNext && y >= 1 && [self canMoveTo:x y:y-1 blockSpots:blockSpots]) {
        canMoveNext = [self pathFromTopLeftToBottomRightInGridBoard:x y:y-1 path:path blockSpots:blockSpots];
    }
    if (canMoveNext) {
        [path addObject:[NSValue valueWithCGPoint:point]];
    }
    return canMoveNext;
}

+ (BOOL)canMoveTo:(NSInteger)x y:(NSInteger)y blockSpots:(NSArray *)blockSpots {
    CGPoint nextPoint = CGPointMake(x, y);
    return ![blockSpots containsObject:[NSValue valueWithCGPoint:nextPoint]];
}

/**
 A magic index in an array A[0...n-1] is defined to be an index such that A[i] = i. 
 Given a sorted array of distinct integers, write a method to find a magic index, if one exists, 
 in array A.
 
 FOLLOW UP:
 
 What if the values are not distinct?
 
 Solution:
 - with traditional binary search, we can not use A[i] > i or A[i] < i to decide go left or right
 - In fact, when we see that A[5] = 3, we'll need to recursively search the right side as before. 
 But, to search the left side, we can skip a bunch of elements and only recursively search elements A[0] through A[3].
 A[3] isthe first element that could be a magic index.
 */

+ (NSInteger)findMagicIndexIfExistsInSortedArray:(NSArray *)array {
    return [self binarySearchArrayWithDuplicates:array start:0 end:array.count-1];
}

+ (NSInteger)binarySearchArray:(NSArray *)array start:(NSInteger)start end:(NSInteger)end{
    if (start > end || start < 0 || end >= array.count) {
        return -1;
    }
    NSInteger mid = (end - start) / 2 + start;
    NSInteger midValue = [array[mid] integerValue];
    if (midValue == mid) {
        return mid;
    }
    
    if (midValue > mid) {
        return [self binarySearchArray:array start:start end:mid-1];
    } else {
        return [self binarySearchArray:array start:mid+1 end:end];
    }
}

+ (NSInteger)binarySearchArrayWithDuplicates:(NSArray *)array start:(NSInteger)start end:(NSInteger)end{
    if (start > end || start < 0 || end >= array.count) {
        return -1;
    }
    NSInteger mid = (end - start) / 2 + start;
    NSInteger midValue = [array[mid] integerValue];
    if (midValue == mid) {
        return mid;
    }
    
    NSInteger leftIndex = MIN(midValue, mid-1);
    NSInteger left = [self binarySearchArrayWithDuplicates:array start:start end:leftIndex];
    if (left >= 0) {
        return left;
    }
    
    NSInteger rightIndex = MAX(midValue, mid+1);
    NSInteger right = [self binarySearchArrayWithDuplicates:array start:rightIndex end:end];
    // includes right >= 0 or -1
    return right;
}

/**
 Write a method to return all subsets of a set.
 */

/**
 - This solution will be 0(power(2, n)) in time and space, which is the best we can do.
 - amount of subset increates like: 1, 2, 4, 8, 16 ... => power(2, n)
 - Potential Bug: forgot 'empty' set is subset of any set.
 */

+ (NSMutableArray<NSSet *> *)findAllSubsetsOfSet:(NSMutableSet *)set {
    if (!set.count) {
        // add empty set -> empty set is subset of any set
        return [NSMutableArray arrayWithObject:[NSSet set]];
    }
    id anyObject = [set anyObject];
    [set removeObject:anyObject];
    NSMutableArray<NSSet *> *subsets = [self findAllSubsetsOfSet:set];
    
    NSSet *anySet = [NSSet setWithObject:anyObject];
    NSMutableArray<NSSet *> *newSubsets = [NSMutableArray array];
    for (NSInteger i=0; i<subsets.count; i++) {
        NSSet *newSet = [subsets[i] setByAddingObjectsFromSet:anySet];
        [newSubsets addObject:newSet];
    }
    [subsets addObjectsFromArray:newSubsets];
    return subsets;
}

/**
 Solution #2: Combinatorics
 - Recall that when we're generating a set, we have two choices for each element:
 - (1) the element is in the set (the "yes" state)
 - or (2) the element is not in the set (the "no" state).
 - This means that each subset is a secuence of yeses / no:s — e.g., "yes, yes, no, no, yes, no"
 */

/**
ArrayList<ArrayList<Integer> > getSubsets2(ArrayList<Integer> set){
    ArrayList<ArrayList<Integer> > allsubsets = new ArrayList<ArrayList<Integer> >();
    int max = 1 << set.size();
    for (int k=0; k<max; k++) {
        ArrayList<Integer> subset = convertIntToSet(k, set);
        allsubsets.add(subset);
    }
    return allsubsets;
}

ArrayList<Integer> convert!ntToSet(int x, ArrayList<Integer> set){
    ArrayList<Integer> subset = new ArrayList<Integer>();
    int index = 0;
    for(int k=x; k>0; k >>= 1) {
        if((k & 1) == 1) {
            subset.add(set.get(index);
        }
        index++;
    }
    return subset;
}
 */

/**
 Write a method to compute all permutations of a string.
 － This solution takes 0(n!) time, since there are n! permutations. We cannot do better than this.
 */

+ (NSArray *)allPermutationsOfString:(NSString *)string {
    if (!string) {
        return [NSArray array];
    }
    /**
     substringFromIndex
    - A new string containing the characters of the receiver from the one at anIndex to the end. 
    - If anIndex is equal to the length of the string, returns an empty string.
     */
    NSString *substring = nil;
    NSString *characterString = nil;
    if (string.length > 1) {
        characterString = [string substringToIndex:1];
        substring = [string substringFromIndex:1];
    } else {
        characterString = string;
    }
    NSArray *array = [self allPermutationsOfString:substring];
    if (!array.count) {
        return [NSArray arrayWithObject:characterString];
    } else {
        return [self insertCharacterString:characterString toSubstrings:array];
    }
}

/**
 better insert method
 */
+ (NSArray *)insertCharacterString:(NSString *)characterString toSubstrings:(NSArray *)substrings {
    NSMutableArray *newSubstrings = [NSMutableArray array];
    for (NSInteger i=0; i<substrings.count; i++) {
        NSString *substring = substrings[i];
        for (NSInteger j=0; j<=substring.length; j++) {
            NSString *before = [substring substringToIndex:j];
            NSString *after = [substring substringFromIndex:j];
            [newSubstrings addObject:[NSString stringWithFormat:@"%@%@%@", before, characterString, after]];
        }
    }
    return newSubstrings;
}

/**
 my insert method
 */
+ (NSArray *)combineSubstrings:(NSArray *)substrings andCharacterString:(NSString *)characterString {
    NSMutableArray *newSubstrings = [NSMutableArray array];
    for (NSInteger i=0; i<substrings.count; i++) {
        NSString *substring = substrings[i];
        for (NSInteger j=0; j<substring.length; j++) {
            NSMutableString *newSubstring = [NSMutableString stringWithString:substring];
            [newSubstring insertString:characterString atIndex:j];
            [newSubstrings addObject:newSubstring];
        }
        // append character to the end of substring is missing from previous loop
        NSString *newSubstring = [substring stringByAppendingString:characterString];
        [newSubstrings addObject:newSubstring];
    }
    return newSubstrings;
}

/**
 Implement an algorithm to print all valid (e.g., properly opened and closed) combinations of n-pairs of parentheses.
 
 EXAMPLE
 
 Input: 3
 Output: ((())), (()()), (())(), ()(()), ()()()
 */

+ (NSArray *)nPairsOfParentheseCombinations:(NSUInteger)n {
    /*
     - most left MUST be '(' and most right MUST be ')'
     n = 1 -> ()
     n = 2 -> (()), ()()
     n = 3 -> ((())), (()()), (())(), ()(()), ()()()
     */
    NSMutableArray *combinations = [NSMutableArray array];
    [self addCompbinationsTo:combinations leftParentheseRemain:n rightParentheseRemain:n
               patternString:[self mutableStringWithCapability:n*2] counter:0];
    return combinations;
}

+ (void)addCompbinationsTo:(NSMutableArray *)combinations leftParentheseRemain:(NSInteger)leftRemain
     rightParentheseRemain:(NSInteger)rightRemain patternString:(NSMutableString *)patternString
                   counter:(NSInteger)counter{
    if (leftRemain < 0 || rightRemain < leftRemain) {
        return;
    }
    if (leftRemain == 0 && rightRemain == 0) {
        [combinations addObject:[patternString copy]];
        return;
    }
    if (leftRemain > 0) {
        [patternString replaceCharactersInRange:NSMakeRange(counter, 1) withString:@"("];
        [self addCompbinationsTo:combinations leftParentheseRemain:leftRemain-1
           rightParentheseRemain:rightRemain patternString:patternString counter:counter+1];
    }
    if (rightRemain > leftRemain) {
        [patternString replaceCharactersInRange:NSMakeRange(counter, 1) withString:@")"];
        [self addCompbinationsTo:combinations leftParentheseRemain:leftRemain
           rightParentheseRemain:rightRemain-1 patternString:patternString counter:counter+1];
    }
}

+ (NSMutableString *)mutableStringWithCapability:(NSInteger)capability {
    NSMutableString *mutableString = [NSMutableString string];
    for (NSInteger i=0; i<capability; i++) {
        [mutableString appendString:@" "];
    }
    return mutableString;
}

/**
 Implement the "paint fill" function that one might see on many image editing programs. 
 That is, given a screen (represented by a two-dimensional array of colors), a point, and a new color, 
 fill in the surrounding area until the color changes from the original color.
 */

+ (void)paintFillColor:(UIColor *)color atPoint:(CGPoint)point onScreen:(NSMutableArray<NSMutableArray *> *)screen {
    UIColor *oldColor = [self getColorAtPoint:point onScreen:screen];
    if ([oldColor isEqual:color]) {
        return;
    }
    [self paintFillColor:color atPoint:point withOldColor:oldColor onScreen:screen];
}

+ (void)paintFillColor:(UIColor *)color atPoint:(CGPoint)point withOldColor:(UIColor *)oldColor
              onScreen:(NSMutableArray<NSMutableArray *> *)screen {
    if (point.x < 0 || point.x > [self screenWidth:screen]-1 ||
        point.y < 0 || point.y > [self screenHeight:screen]-1) {
        return;
    }
    UIColor *colorAtPoint = [self getColorAtPoint:point onScreen:screen];
    if (![colorAtPoint isEqual:oldColor]) {
        return;
    }
    [self setColorAtPoint:point onScreen:screen color:color];
    
    CGPoint nextPoint = CGPointMake(point.x, point.y-1);
    [self paintFillColor:color atPoint:nextPoint withOldColor:oldColor onScreen:screen];
    
    nextPoint = CGPointMake(point.x-1, point.y);
    [self paintFillColor:color atPoint:nextPoint withOldColor:oldColor onScreen:screen];
    
    nextPoint = CGPointMake(point.x, point.y+1);
    [self paintFillColor:color atPoint:nextPoint withOldColor:oldColor onScreen:screen];
    
    nextPoint = CGPointMake(point.x+1, point.y);
    [self paintFillColor:color atPoint:nextPoint withOldColor:oldColor onScreen:screen];
}

+ (UIColor *)getColorAtPoint:(CGPoint)point onScreen:(NSMutableArray<NSMutableArray *> *)screen {
    NSArray *screenRow = screen[(NSInteger)point.y];
    UIColor *pointColor = screenRow[(NSInteger)point.x];
    return pointColor;
}

+ (void)setColorAtPoint:(CGPoint)point onScreen:(NSMutableArray<NSMutableArray *> *)screen color:(UIColor *)color {
    NSMutableArray *screenRow = screen[(NSInteger)point.y];
    screenRow[(NSInteger)point.x] = color;
}

+ (NSInteger)screenWidth:(NSMutableArray<NSMutableArray *> *)screen {
    NSArray *screenRow = screen[0];
    return screenRow.count;
}

+ (NSInteger)screenHeight:(NSMutableArray<NSMutableArray *> *)screen {
    return screen.count;
}

/**
 Given an infinite number of quarters (25 cents), dimes (10 cents), nickels (5 cents) 
 and pennies (1 cent), write code to calculate the number of ways of representing n cents.
 */

+ (NSInteger)numberOfWaysToRepresentNCents:(NSInteger)nCents {
    return [self numberOfWaysToRepresentNCents:nCents baseCent:25];
}

+ (NSInteger)numberOfWaysToRepresentNCents:(NSInteger)nCents baseCent:(NSInteger)baseCent {
    if (nCents < 0) {
        return 0;
    }
    if (nCents == 0) {
        return 1;
    }
    NSInteger sum = 0;
    switch (baseCent) {
        case 25:
            sum += [self numberOfWaysToRepresentNCents:nCents-25 baseCent:25];
        case 10:
            sum += [self numberOfWaysToRepresentNCents:nCents-10 baseCent:10];
        case 5:
            sum += [self numberOfWaysToRepresentNCents:nCents-5 baseCent:5];
        default:
            sum += 1;
    }
    return sum;
}

+ (NSInteger)betterNumberOfWaysToRepresentNCents:(NSInteger)nCents denom:(NSInteger)denom {
    NSInteger nextDenom = 0;
    switch (denom) {
        case 25:
            nextDenom = 10;
            break;
        case 10:
            nextDenom = 5;
            break;
        case 5:
            nextDenom = 1;
            break;
        case 1:
            return 1;
    }
    NSInteger sumOfWays = 0;
    for (NSInteger i=0; i*denom <= nCents; i++) {
        sumOfWays += [self betterNumberOfWaysToRepresentNCents:nCents-i*denom denom:nextDenom];
    }
    return sumOfWays;
}

/**
 Write an algorithm to print ALL ways of arranging eight queens on an 8x8 chess board
 so that none of them share the same row, column or diagonal. In this case, "diagonal" 
 means all diagonals, not just the two that bisect the board
 */

+ (NSArray *)queenCombinationOn8X8ChessBoard {
    NSMutableArray *columns = [NSMutableArray arrayWithArray:@[@"-1", @"-1", @"-1", @"-1", @"-1", @"-1", @"-1", @"-1"]];
    NSMutableArray<Matrix *> *results = [NSMutableArray array];
    [self queenCombinationRow:0 columns:columns results:results];
    return results;
}

+ (void)queenCombinationRow:(NSUInteger)row columns:(NSMutableArray *)columns results:(NSMutableArray<Matrix *> *)results {
    /**
     - Observe that since each row can only have one queen, we don't need to store our board as a full 8x8 matrix. 
     We only need a single array where column [row] = c indicates that row r has a queen at column c.
     - This is the part I didn't figure out correctly, which leads the whole solution goes to wrong direction.
     */
    if (row == 8) {
        [results addObject:[self matrixFromColumns:columns]];
        return;
    }
    for (NSUInteger col=0; col<8; col++) {
        if ([self checkValidForRow:row column:col columns:columns]) {
            columns[row] = @(col);
            [self queenCombinationRow:row+1 columns:columns results:results];
        }
    }
}

+ (BOOL)checkValidForRow:(NSUInteger)row column:(NSUInteger)column columns:(NSArray *)columns {
    for (NSUInteger r=0; r<row; r++) {
        NSUInteger c = [columns[r] integerValue];
        if (c == column) {
            return NO;
        }
        NSUInteger columnDistance = ABS(c - column);
        NSUInteger rowDistance = row - r;
        if (rowDistance == columnDistance) {
            return NO;
        }
    }
    return YES;
}

+ (Matrix *)matrixFromColumns:(NSArray *)columns {
    Matrix *matrix = [Matrix matrixWithRow:8 column:8];
    for (NSUInteger row=0; row<columns.count; row++) {
        [matrix setItemAtRow:row column:[columns[row] integerValue] data:1];
    }
    return matrix;
}

/**
 You have a stack of n boxes, with widths w1, heights h1 and depths d1. 
 The boxes cannot be rotated and can only be stacked on top of one another 
 if each box in the stack is strictly larger than the box above it in width, height, and depth. 
 Implement a method to build the tallest stack possible, 
 where the height of a stack is the sum of the heights of each box.
 */

+ (NSArray *)stackBoxesWithTallestHeight:(NSArray *)boxes {
    /**
     - p333 to p334
     */
    NSMutableDictionary *cache = [NSMutableDictionary dictionary];
    return [self stackBoxes:boxes onBottomBox:nil cache:cache];
}

+ (NSMutableArray *)stackBoxes:(NSArray *)boxes onBottomBox:(id)bottomBox cache:(NSMutableDictionary *)cache {
    if (!bottomBox && cache[bottomBox]) {
        return cache[bottomBox];
    }
    NSUInteger maxHeight = 0;
    NSMutableArray *maxStack = nil;
    for (NSUInteger i=0; i<boxes.count; i++) {
        if ([self canBox:boxes[i] beAbove:bottomBox]) {
            NSMutableArray *newStack = [self stackBoxes:boxes onBottomBox:boxes[i] cache:cache];
            NSUInteger newHeight = [self heightOfStack:newStack];
            if (newHeight > maxHeight) {
                maxHeight = newHeight;
                maxStack = newStack;
            }
        }
    }
    
    if (!maxStack) {
        maxStack = [NSMutableArray array];
    }
    if (bottomBox) {
        [maxStack insertObject:bottomBox atIndex:0];
    }
    cache[bottomBox] = maxStack;
    /**
     - because we cache each stack result, so we need to make a new copy for each stack
     - should do 'deepCopy' instead of 'copy'
     */
    return [maxStack copy];
}

+ (BOOL)canBox:(id)box beAbove:(id)bottomBox {
    return YES;
}

+ (NSUInteger)heightOfStack:(NSArray *)boxStack {
    return 0;
}

/**
 Given a boolean expression consisting of the symbols 0, 1, &, |, and ^, and a desired boolean result value result,
 implement a function to count the number of ways of parenthesizing the expression such that it evaluates to result.
 
 EXAMPLE:
 
 Expression: 1^0|0|1
 Desired result: false(0)
 Output: 2 ways. 1^((0|0)|1) and 1^(0|(0|1)).
 */

+ (NSUInteger)parenthesizingWaysOf:(NSString *)expression desiredResult:(BOOL)desiredResult {
    NSMutableDictionary *cache = [NSMutableDictionary dictionary];
    NSUInteger ways = [self parenthesizingWaysOf:expression desiredResult:desiredResult cache:cache];
    NSLog(@"%@", cache);
    return ways;
}

+ (NSUInteger)parenthesizingWaysOf:(NSString *)expression desiredResult:(BOOL)desiredResult
                             cache:(NSMutableDictionary *)cache {
    if ([cache.allKeys containsObject:expression]) {
        return [cache[expression] integerValue];
    }
    if ([self checkIfExpressionEvaluatable:expression]) {
        return [self evaluateExpression:expression] == desiredResult ? 1 : 0;
    }
    NSInteger counter = 0;
    NSInteger ptr = 0;
    if (desiredResult) {
        while (ptr < expression.length) {
            NSString *characterAtIndex = [expression substringWithRange:NSMakeRange(ptr, 1)];
            if ([characterAtIndex isEqualToString:@"&"]) {
                /**
                 [NSString substringToIndex]
                 A new string containing the characters of the receiver up to, but not including, the one at anIndex
                 */
                NSString *left = [expression substringToIndex:ptr];
                NSString *right = [expression substringFromIndex:ptr+1];
                counter += [self parenthesizingWaysOf:left desiredResult:YES cache:cache] *
                [self parenthesizingWaysOf:right desiredResult:YES cache:cache];
            }
            if ([characterAtIndex isEqualToString:@"|"]) {
                NSString *left = [expression substringToIndex:ptr];
                NSString *right = [expression substringFromIndex:ptr+1];
                counter += [self parenthesizingWaysOf:left desiredResult:YES cache:cache] *
                [self parenthesizingWaysOf:right desiredResult:YES cache:cache];
                counter += [self parenthesizingWaysOf:left desiredResult:YES cache:cache] *
                [self parenthesizingWaysOf:right desiredResult:NO cache:cache];
                counter += [self parenthesizingWaysOf:left desiredResult:NO cache:cache] *
                [self parenthesizingWaysOf:right desiredResult:YES cache:cache];
            }
            if ([characterAtIndex isEqualToString:@"^"]) {
                NSString *left = [expression substringToIndex:ptr];
                NSString *right = [expression substringFromIndex:ptr+1];
                counter += [self parenthesizingWaysOf:left desiredResult:YES cache:cache] *
                [self parenthesizingWaysOf:right desiredResult:NO cache:cache];
                counter += [self parenthesizingWaysOf:left desiredResult:NO cache:cache] *
                [self parenthesizingWaysOf:right desiredResult:YES cache:cache];
            }
            ptr++;
        }
    } else {
        while (ptr < expression.length) {
            NSString *characterAtIndex = [expression substringWithRange:NSMakeRange(ptr, 1)];
            if ([characterAtIndex isEqualToString:@"&"]) {
                /**
                 [NSString substringToIndex]
                 A new string containing the characters of the receiver up to, but not including, the one at anIndex
                 */
                NSString *left = [expression substringToIndex:ptr];
                NSString *right = [expression substringFromIndex:ptr+1];
                counter += [self parenthesizingWaysOf:left desiredResult:NO cache:cache] *
                [self parenthesizingWaysOf:right desiredResult:NO cache:cache];
                counter += [self parenthesizingWaysOf:left desiredResult:YES cache:cache] *
                [self parenthesizingWaysOf:right desiredResult:NO cache:cache];
                counter += [self parenthesizingWaysOf:left desiredResult:NO cache:cache] *
                [self parenthesizingWaysOf:right desiredResult:YES cache:cache];
            }
            if ([characterAtIndex isEqualToString:@"|"]) {
                NSString *left = [expression substringToIndex:ptr];
                NSString *right = [expression substringFromIndex:ptr+1];
                counter += [self parenthesizingWaysOf:left desiredResult:NO cache:cache] *
                [self parenthesizingWaysOf:right desiredResult:NO cache:cache];
            }
            if ([characterAtIndex isEqualToString:@"^"]) {
                NSString *left = [expression substringToIndex:ptr];
                NSString *right = [expression substringFromIndex:ptr+1];
                counter += [self parenthesizingWaysOf:left desiredResult:YES cache:cache] *
                [self parenthesizingWaysOf:right desiredResult:YES cache:cache];
                counter += [self parenthesizingWaysOf:left desiredResult:NO cache:cache] *
                [self parenthesizingWaysOf:right desiredResult:NO cache:cache];
            }
            ptr++;
        }
    }
    cache[expression] = @(counter);
    return counter;
}

+ (BOOL)checkIfExpressionEvaluatable:(NSString *)expression {
    if (expression.length == 1 ||
        expression.length == 3) {
        return YES;
    }
    return NO;
}

+ (BOOL)evaluateExpression:(NSString *)expression {
    if (expression.length == 1) {
        return [expression boolValue];
    }
    NSScanner *scanner = [NSScanner scannerWithString:expression];
    NSInteger leftInteger, rightInteger;
    NSString *operator;
    [self scannerGuard:[scanner scanInteger:&leftInteger]];
    [self scannerGuard:[scanner scanCharactersFromSet:[NSCharacterSet characterSetWithCharactersInString:@"&|^"] intoString:&operator]];
    [self scannerGuard:[scanner scanInteger:&rightInteger]];
    
    if ([operator isEqualToString:@"&"]) {
        return leftInteger & rightInteger;
    }
    if ([operator isEqualToString:@"|"]) {
        return leftInteger | rightInteger;
    }
    if ([operator isEqualToString:@"^"]) {
        return leftInteger ^ rightInteger;
    }
    @throw [NSException exceptionWithName:@"UnknownOperatorException"
                                   reason:@"Using unkown operation in expression"
                                 userInfo:nil];
}

+ (void)scannerGuard:(BOOL)scanResult {
    if (!scanResult) {
        @throw [NSException exceptionWithName:@"WrongExpressionFormat" reason:@"Expression has wrong format" userInfo:nil];
    }
}

@end
