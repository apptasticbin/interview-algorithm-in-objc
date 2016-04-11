//
//  CrackingBitManipulation.h
//  interview-algorithm-in-objc
//
//  Created by Bin Yu on 08/04/16.
//  Copyright © 2016 Bin Yu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CrackingBitManipulation : NSObject

+ (BOOL)getBitOfNumber:(int32_t)number at:(NSInteger)pos;
+ (int32_t)setBitOfNumber:(int32_t)number at:(NSInteger)pos;
+ (int32_t)clearBitOfNumber:(int32_t)number at:(NSInteger)pos;
+ (int32_t)clearBitsOfNumber:(int32_t)number fromMostSignificantBitTo:(NSInteger)pos;
+ (int32_t)clearBitsOfNumber:(int32_t)number fromZeroBitTo:(NSInteger)pos;
+ (int32_t)updateBitsOfNumber:(int32_t)number at:(NSInteger)pos withValue:(int32_t)value;

+ (int32_t)insertBitsOfM:(int32_t)m toN:(int32_t)n fromBit:(NSInteger)j toBit:(NSInteger)i;
+ (int32_t)cleanInsertBitsOfM:(int32_t)m toN:(int32_t)n fromBit:(NSInteger)j toBit:(NSInteger)i;
+ (NSString *)binaryRepresentationOfFractionNumber:(double)number;
+ (NSUInteger)nextSmallestNumberWithSameAmountOfOne:(NSUInteger)number;
+ (NSUInteger)previousLargestNumberWithSameAmountOfOne:(NSUInteger)number;
+ (NSInteger)numberOfBitsToConvertIntegerA:(NSUInteger)a toIntegerB:(NSUInteger)b;
+ (int32_t)swapOddAndEventBitsOfNumber:(int32_t)number;
+ (NSInteger)findMissIntegerInArray:(NSArray *)array;
+ (void)drawHorizontalLingOnScreen:(NSMutableArray *)screen withWidth:(NSInteger)width
                            fromX1:(NSInteger)x1 toX2:(NSInteger)x2 withSameY:(NSInteger)y;

+ (NSString *)binaryStringFromInteger:(NSInteger)integer;

@end
