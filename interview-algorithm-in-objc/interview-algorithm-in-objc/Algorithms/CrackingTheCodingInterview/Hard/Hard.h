//
//  Hard.h
//  interview-algorithm-in-objc
//
//  Created by Bin Yu on 06/05/16.
//  Copyright © 2016 Bin Yu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Hard : NSObject

+ (NSInteger)addNumber:(NSInteger)a andNumber:(NSInteger)b;
+ (NSInteger)recursionAddNumber:(NSInteger)a andNumber:(NSInteger)b;
+ (void)perfectShuffleOfDeckIteratively:(NSMutableArray *)cards;
+ (NSArray *)interativelyRandomSetFromArray:(NSArray *)array amount:(NSInteger)m;
+ (NSInteger)bruteForceCountNumberOf2sBetween0AndN:(NSInteger)n;
+ (NSInteger)betterCountNumberOf2sBetween0AndN:(NSInteger)n;
+ (NSString *)findLongestWordMadeOfOtherWordsInList:(NSArray *)list;
+ (NSArray<NSNumber *> *)searchSmallString:(NSString *)smallString inString:(NSString *)string;
+ (NSString *)transformWord:(NSString *)fromWord toWord:(NSString *)toWord inDictionary:(NSArray<NSString *> *)dictionary;
+ (NSString *)betterTransformWord:(NSString *)fromWord toWord:(NSString *)toWord inDictionary:(NSArray<NSString *> *)dictionary;

@end
