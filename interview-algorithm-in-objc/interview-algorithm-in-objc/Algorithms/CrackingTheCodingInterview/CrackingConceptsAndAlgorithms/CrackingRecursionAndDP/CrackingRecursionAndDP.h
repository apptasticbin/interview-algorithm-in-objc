//
//  CrackingResursionAndDP.h
//  interview-algorithm-in-objc
//
//  Created by Bin Yu on 14/04/16.
//  Copyright © 2016 Bin Yu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CrackingRecursionAndDP : NSObject

+ (NSInteger)possibleWaysToRunUpStaircase:(NSInteger)steps;
+ (NSInteger)possiblePathsInGridBoard:(NSInteger)x y:(NSInteger)y;
+ (BOOL)pathFromTopLeftToBottomRightInGridBoard:(NSInteger)x y:(NSInteger)y
                                           path:(NSMutableArray *)path blockSpots:(NSArray *)spots;
+ (NSInteger)findMagicIndexIfExistsInSortedArray:(NSArray *)array;
+ (NSMutableArray<NSSet *> *)findAllSubsetsOfSet:(NSMutableSet *)set;
+ (NSArray *)allPermutationsOfString:(NSString *)string;
+ (NSArray *)nPairsOfParentheseCombinations:(NSUInteger)n;
+ (void)paintFillColor:(UIColor *)color atPoint:(CGPoint)point onScreen:(NSMutableArray<NSMutableArray *> *)screen;
+ (NSInteger)numberOfWaysToRepresentNCents:(NSInteger)nCents;
+ (NSInteger)betterNumberOfWaysToRepresentNCents:(NSInteger)nCents denom:(NSInteger)denom;
+ (NSArray *)queenCombinationOn8X8ChessBoard;
+ (NSUInteger)parenthesizingWaysOf:(NSString *)expression desiredResult:(BOOL)desiredResult;

@end
