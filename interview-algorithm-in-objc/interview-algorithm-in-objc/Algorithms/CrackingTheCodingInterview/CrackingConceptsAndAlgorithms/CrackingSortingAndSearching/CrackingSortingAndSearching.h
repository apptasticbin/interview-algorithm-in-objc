//
//  CrackingSortingAndSearching.h
//  interview-algorithm-in-objc
//
//  Created by Bin Yu on 20/04/16.
//  Copyright © 2016 Bin Yu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CrackingSortingAndSearching : NSObject

+ (void)bubbleSort:(NSMutableArray *)integers;
+ (void)selectionSort:(NSMutableArray *)integers;
+ (void)mergeSort:(NSMutableArray *)integers;
+ (void)quickSort:(NSMutableArray *)integers;
+ (void)radixSort:(NSMutableArray *)integers;
+ (NSInteger)binarySearch:(NSArray *)integers value:(NSInteger)value;
+ (void)mergeArrayB:(NSArray *)arrayB intoArrayA:(NSMutableArray *)arrayA;
+ (void)sortAnagramArray:(NSMutableArray *)anagramArray;
+ (void)hashSortAnagramArray:(NSMutableArray *)anagramArray;
+ (NSInteger)indexOfNumber:(NSInteger)number inRotatedSortedArray:(NSArray *)integers;
+ (NSInteger)anotherIndexOfNumber:(NSInteger)number inRotatedSortedArray:(NSArray *)integers;
+ (NSInteger)locationOfString:(NSString *)theString inSortedArrayWithEmptyStrings:(NSArray *)array;
+ (BOOL)findValue:(NSInteger)value inMatrix:(NSArray<NSArray *> *)matrix;
+ (NSArray *)longestPossibleSequenceOfPeopleInTower:(NSArray *)people;

@end
