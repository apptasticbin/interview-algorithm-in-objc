//
//  ModerateQuestions.h
//  interview-algorithm-in-objc
//
//  Created by Bin Yu on 02/05/16.
//  Copyright © 2016 Bin Yu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ModerateQuestions : NSObject

+ (void)swapA:(NSInteger *)a b:(NSInteger *)b;
+ (void)bitOperationSwapA:(NSInteger *)a b:(NSInteger *)b;
+ (NSNumber *)checkWonOfNxNTicTacToe:(NSArray <NSArray *> *)board;
+ (NSInteger)trailingZerosInNFactorial:(NSInteger)n;
+ (NSInteger)betterTrailingZerosInNFractorial:(NSInteger)n;
+ (NSArray *)numberOfHisAndPseudoHitsOfGuess:(NSArray *)guess solution:(NSArray *)solution;
+ (NSArray *)minimizeRangeToSort:(NSArray *)integers;
+ (NSString *)englishPhraseOfInteger:(NSInteger)integer;
+ (NSInteger)contiguousSequenceWithLargestSumOfIntegers:(NSArray *)integers;
+ (NSSet<NSArray *> *)allPairsOfIntegers:(NSArray *)integers withSumOf:(NSInteger)sum;
+ (NSSet *)hashFindPairsFrom:(NSArray *)integers sum:(NSInteger)sum;
+ (NSInteger)unconcatenatingSentence:(NSString *)sentence byDictionary:(NSArray<NSString *> *)words;

@end
