//
//  CrackingSortingAndSearching.m
//  interview-algorithm-in-objc
//
//  Created by Bin Yu on 20/04/16.
//  Copyright © 2016 Bin Yu. All rights reserved.
//

#import "CrackingSortingAndSearching.h"

@implementation CrackingSortingAndSearching

#pragma mark - Common Sorting algorithms

// O(power(n, 2)
+ (void)bubbleSort:(NSMutableArray *)integers {
    for (NSUInteger i=integers.count-1; i != 0; i--) {
        for (NSUInteger j=0; j<i; j++) {
            if (integers[j] > integers[j+1]) {
                [self swap:j bIndex:j+1 inArray:integers];
            }
        }
    }
}

+ (void)selectionSort:(NSMutableArray *)integers {
    if (!integers.count) {
        return;
    }
    for (NSUInteger i=0; i<integers.count-1; i++) {
        NSUInteger minIndex = i;
        for (NSUInteger j=i; j<integers.count; j++) {
            if ([integers[minIndex] integerValue] > [integers[j] integerValue]) {
                minIndex = j;
            }
        }
        if (i != minIndex) {
            [self swap:i bIndex:minIndex inArray:integers];
        }
    }
}

// O(n Log(n)) average and worst case. Memory: Depends.
+ (void)mergeSort:(NSMutableArray *)integers {
    NSMutableArray *helper = [NSMutableArray array];
    for (NSUInteger i=0; i<integers.count; i++) {
        [helper addObject:[NSNull null]];
    }
    // n or n-1 are both fine, but need to CAREFULL
    [self mergeSort:integers helper:helper left:0 right:integers.count-1];
}

+ (void)mergeSort:(NSMutableArray *)integers helper:(NSMutableArray *)helper
             left:(NSUInteger)left right:(NSUInteger)right {
    if (left >= right) {
        return;
    }
    NSUInteger middle = (right + left) / 2;
    [self mergeSort:integers helper:helper left:left right:middle];
    [self mergeSort:integers helper:helper left:middle+1 right:right];
    [self merge:integers helper:helper left:left middle:middle right:right];
    [self copyArray:helper toArray:integers from:left to:right];
}

+ (void)merge:(NSMutableArray *)integers helper:(NSMutableArray *)helper
         left:(NSUInteger)left middle:(NSUInteger)middle right:(NSUInteger)right {
    NSUInteger l = left, r = middle + 1;
    for (NSUInteger i=left; i<=right; i++) {
        if (l <= middle && (r > right || integers[l] <= integers[r])) {
            helper[i] = integers[l];
            l++;
        }
        else {
            helper[i] = integers[r];
            r++;
        }
    }
}

+ (void)copyArray:(NSArray *)source toArray:(NSMutableArray *)target from:(NSUInteger)from to:(NSUInteger)to {
    if (source.count != target.count) {
        return;
    }
    // BE CAREFULL of i <= to
    for (NSUInteger i=from; i<=to; i++) {
        target[i] = source[i];
    }
}

// Runtime: O(n Log(n)) average, O(power(n, 2)) worst case. Memory: O(Log(n)).
+ (void)quickSort:(NSMutableArray *)integers {
    [self quickSort:integers left:0 right:integers.count-1];
}

+ (void)quickSort:(NSMutableArray *)integers left:(NSInteger)left right:(NSInteger)right {
    if (left >= right) {
        return;
    }
    NSInteger partitionIndex = [self partition:integers left:left right:right];
    [self quickSort:integers left:left right:partitionIndex-1];
    [self quickSort:integers left:partitionIndex+1 right:right];
}

+ (NSInteger)partition:(NSMutableArray *)integers left:(NSInteger)left right:(NSInteger)right {
    NSInteger pivot = [integers[(left+right)/2] integerValue];
    while (left < right) {
        while ([integers[left] integerValue] < pivot) {
            left++;
        }
        while ([integers[right] integerValue] > pivot) {
            right--;
        }
        if (left <= right) {
            [self swap:left bIndex:right inArray:integers];
        }
    }
    return left;
}

/**
 - Runtime: 0(kn)
 - Unlike comparison sorting algorithms, which can not perform better than 0(n log(n)) in the average case, 
 radix sort has a runtime of 0(kn), where n isthe number of elements and k is the number of passes of the 
 sorting algorithm.
 - LSD and MSD
 - A simple version of an LSD radix sort can be achieved using queues as buckets.
 */
+ (void)radixSort:(NSMutableArray *)integers {
    NSInteger maxBits = [self maxBits:integers];
    // we run N rounds of sorting from LSD to MSD
    for (NSUInteger round=0; round<maxBits; round++) {
        // buckets for 0 to 9
        NSMutableArray *groups = [self zeroMutableArray:10];
        // create temporary buckets for holding sorted integers
        NSMutableArray *buckets = [self zeroMutableArray:integers.count];
        NSInteger radix = pow(10, round);
        // count current significant digit
        for (NSInteger i=0; i<integers.count; i++) {
            NSInteger digit = ([integers[i] integerValue] / radix) % 10;
            groups[digit] = @([groups[digit] integerValue] + 1);
        }
        // map index with count
        for (NSInteger i=1; i<10; i++) {
            groups[i] = @([groups[i] integerValue] + [groups[i-1] integerValue]);
        }
        for (NSInteger i=integers.count-1; i>=0; i--) {
            NSInteger digit = ([integers[i] integerValue] / radix) % 10;
            buckets[[groups[digit] integerValue]-1] = integers[i];
            groups[digit] = @([groups[digit] integerValue] - 1);
        }
        for (NSInteger i=0; i<integers.count; i++) {
            integers[i] = buckets[i];
        }
    }
}

+ (NSInteger)maxBits:(NSArray *)integers {
    if (!integers.count) {
        return 0;
    }
    NSInteger maxInteger = [integers[0] integerValue];
    for (NSUInteger i=0; i<integers.count; i++) {
        if (maxInteger < [integers[i] integerValue]) {
            maxInteger = [integers[i] integerValue];
        }
    }
    NSInteger counter = 1;
    while (maxInteger / 10) {
        maxInteger /= 10;
        counter++;
    }
    return counter;
}

+ (NSMutableArray *)zeroMutableArray:(NSInteger)capability {
    NSMutableArray *array = [NSMutableArray array];
    for (NSUInteger i=0; i<capability; i++) {
        [array addObject:@(0)];
    }
    return array;
}

#pragma mark - Helper

+ (void)swap:(NSUInteger)aIndex bIndex:(NSUInteger)bIndex inArray:(NSMutableArray *)array {
    id tmp = array[aIndex];
    array[aIndex] = array[bIndex];
    array[bIndex] = tmp;
}

#pragma mark - Search algorithms

/**
 - binary search is ONLY for SORTED array
 */

+ (NSInteger)binarySearch:(NSArray *)integers value:(NSInteger)value {
    NSInteger left = 0;
    NSInteger right = integers.count-1;
    while (left <= right) {
        NSInteger middle = (left + right) / 2;
        NSInteger midValue = [integers[middle] integerValue];
        if (midValue == value) {
            return middle;
        } else if (midValue > value) {
            right = middle-1;
        } else {
            left = middle+1;
        }
    }
    return -1;
}

/**
 int binarySearchRecursive(int[] a, int x, int low, int high) {
    if (low> high) return -1; // Error
    int mid = (low+ high) / 2; 
    if (a[mid] < x) {
        return binarySearchRecursive(a, x., mid + 1, high); 
    } else if (a[mid]>x) {
        return binarySearchRecursive(a, x, low, mid - 1); 
    } else {
        return mid;
    }
 }
 */

/**
 You are given two sorted arrays, A and B, where A has a large enough
 buffer at the end to hold B. Write a method to merge B into A in sorted order.
 */

/**
 Write a method to sort an array of strings so that all the anagrams are 
 next to each other.
 */

/**
 Given a sorted array of n integers that has been rotated an unknown number of times,
 write code to find an element in the array. You may assume that the array was originally 
 sorted in increasing order.
 
 EXAMPLE
 Input: find 5 in {15, 16, 19, 20, 25, 1, 3, 4, 5, 7, 10, 14} 
 Output: 8 (the index of 5 in the array)
 */

/**
 Imagine you have a 20 GB file with one string per line. Explain how you would
 sort the file.
 */

/**
 Given a sorted array of strings which is interspersed with empty strings, 
 write a method to find the location of a given string.
 
 EXAMPLE
 Input: find "ball" in {"at", "", "", "", "ball", "", "", "car", "", "", "dad", "", ""}
 Output: 4
 */

/**
 Given an MxN matrix in which each row and each column is sorted in ascending order, 
 write a method to find an element
 */

/**
 A circus is designing a tower routine consisting of people standing atop one another's shoulders.
 For practical and aesthetic reasons, each person must be both shorter and lighter than the person below him or her. 
 Given the heights and weights of each person in the circus, write a method to compute the largest 
 possible number of people in such a tower.

 EXAMPLE:
 
 Input (ht,wt): (65, 100) (70, 150) (56, 90) (75, 190) (60, 95) (68, 110)
 Output: The longest tower is length 6 and includes from top to bottom:
 (56, 90) (60,95) (65,100) (68,110) (70,150) (75,190)
 */

/**
 Imagine you are reading in a stream of integers. Periodically, you wish to be able to look up 
 the rank of a number x (the number of values less than or equal tox). Implement the data structures 
 and algorithms to support these operations.That is,implement the method track(int x), 
 which iscalled when each number is generated, and the method getRankOfNumber(int x), 
 which returns the number of values less than or equal to x (not including x itself).

 EXAMPLE
 Stream (in order of appearance): 5, 1, 4, 4, 5, 9, 7, 13, 3
 getRankOfNumber(1) = 0
 getRankOfNumber(3) = 1 
 getRankOfNumber(4) = 3
 */

@end
