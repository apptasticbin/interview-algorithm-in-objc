//
//  CrackingDataStructures.h
//  interview-algorithm-in-objc
//
//  Created by Bin Yu on 23/03/16.
//  Copyright © 2016 Bin Yu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CrackingArraysAndStrings : NSObject

+ (BOOL)stringHasAllUniqueCharacters:(NSString *)theString;
+ (BOOL)stringHasAllUniqueCharactersBetter:(NSString *)theString;
+ (void)reverse:(char *)str;
+ (void)reverseBetter:(char *)str;
+ (BOOL)string:(NSString *)permutationString isPermutationOfString:(NSString *)theString;
+ (BOOL)simpleString:(NSString *)permutationString isPermutationOfString:(NSString *)theString;
+ (BOOL)countedString:(NSString *)permutationString isPermutationOfString:(NSString *)theString;
+ (void)escapeSpacesInString:(char *)theString withLength:(int)length;
+ (char *)compressString:(char *)theString;
+ (void)rotateImageMatrix:(int **)imageMatrix withN:(int)N;
+ (void)setRelativeRowAndColumnOfMatrix:(int **)matrix toZeroWithRow:(int)M andColumn:(int)N;
+ (BOOL)isString:(NSString *)thisString rotationOfString:(NSString *)thatString;

@end
