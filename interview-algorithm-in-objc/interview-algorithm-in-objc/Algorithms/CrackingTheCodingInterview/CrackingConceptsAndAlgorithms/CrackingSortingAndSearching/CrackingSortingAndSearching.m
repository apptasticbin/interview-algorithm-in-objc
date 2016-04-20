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

+ (void)bubbleSort:(NSMutableArray *)integers {

}

+ (void)selectionSort:(NSMutableArray *)integers {

}

+ (void)mergeSort:(NSMutableArray *)integers {
    
}

+ (void)quickSort:(NSMutableArray *)integers {
    
}

+ (void)radixSort:(NSMutableArray *)integers {
    
}

#pragma mark - Search algorithms

+ (NSInteger)binarySearch:(NSArray *)integers value:(NSInteger)value {
    return 0;
}

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
