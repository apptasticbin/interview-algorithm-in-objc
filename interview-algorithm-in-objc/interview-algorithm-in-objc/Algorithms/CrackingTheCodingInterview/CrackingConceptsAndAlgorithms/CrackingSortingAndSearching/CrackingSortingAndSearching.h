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

@end
