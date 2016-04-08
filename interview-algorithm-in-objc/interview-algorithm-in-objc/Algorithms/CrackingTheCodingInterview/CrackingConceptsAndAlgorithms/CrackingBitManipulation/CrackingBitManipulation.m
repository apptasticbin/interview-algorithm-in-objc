//
//  CrackingBitManipulation.m
//  interview-algorithm-in-objc
//
//  Created by Bin Yu on 08/04/16.
//  Copyright © 2016 Bin Yu. All rights reserved.
//

#import "CrackingBitManipulation.h"

@implementation CrackingBitManipulation

#pragma mark - Basic Bit Operations

+ (BOOL)getBitOfNumber:(int32_t)number at:(NSInteger)pos {
    /**
     NOTICE: BOOL has 8-bits. Casting 256 to BOOL will return NO, not YES.
     */
    return (number & (1 << pos)) != 0;
}

+ (int32_t)setBitOfNumber:(int32_t)number at:(NSInteger)pos {
    return number | (1 << pos);
}

+ (int32_t)clearBitOfNumber:(int32_t)number at:(NSInteger)pos {
    int32_t mask = ~(1 << pos);
    return number & mask;
}

+ (int32_t)clearBitsOfNumber:(int32_t)number fromMostSignificantBitTo:(NSInteger)pos {
    int32_t mask = (1 << pos) - 1;
    return number & mask;
}

+ (int32_t)clearBitsOfNumber:(int32_t)number fromZeroBitTo:(NSInteger)pos {
    int32_t mask = (1 << (pos+1)) - 1;
    return number & ~mask;
}

+ (int32_t)updateBitsOfNumber:(int32_t)number at:(NSInteger)pos withValue:(int32_t)value {
    int32_t mask = ~(1 << pos);
    return (number & mask) | (value << pos);
}

#pragma mark - Questions

/**
 You are given two 32-bit numbers, N and M, and two bit positions, i and j.
 Write a method to insert M into N such that M starts at bit j and ends at bit i.
 You can assume that the bits j through i have enough space to fit all of M. 
 That is, if M = 10011, you can assume that there are at least 5 bits between j and i.
 You would not,for example, have j = 3 and i = 2, because M could not fully fit between bit 3 and bit 2.
 
 EXAMPLE
 
 Input:  N = 10000000000, M = 10011, i = 2, j = 6
 Output: N = 10001001100
 */

+ (int32_t)insertBitsOfM:(int32_t)m toN:(int32_t)n fromBit:(NSInteger)j toBit:(NSInteger)i {
    /**
     - bit index from 0
     */
    NSInteger bitLengthOfM = [self bitLengthOfNumber:m];
    if (bitLengthOfM > j-i+1 || j > 31 || i > 31) {
        return n;
    }
    /**
       00011111111
     & 11111111100
     = 00011111100
     ~ 11100000011
     */
    int32_t jMask = (1 << (j+1))-1;
    int32_t iMask = ~((1 << i)-1);
    int32_t mask = ~(jMask & iMask);
    return (n & mask) | (m << j);
}

+ (int32_t)cleanInsertBitsOfM:(int32_t)m toN:(int32_t)n fromBit:(NSInteger)j toBit:(NSInteger)i {
    int32_t allOnes = ~0;
    int32_t left = allOnes << (j+1);
    int32_t right = (1 << i) - 1;
    int32_t mask = left | right;
    int32_t nClear = n & mask;
    int32_t mShift = m << i;
    return nClear | mShift;
}

+ (NSInteger)bitLengthOfNumber:(int32_t)number {
    NSInteger counter = 0;
    while (counter < 32) {
        NSInteger pos = 32-counter-1;
        if ([self getBitOfNumber:number at:pos]) {
            break;
        }
        counter++;
    }
    return 32-counter;
}

/**
 Given a real number between 0 and 1 (e.g., 0.72) that is passed in as a double, 
 print the binary representation. If the number cannot be represented accurately 
 in binary with at most 32 characters, print "ERROR."
 */

/**
 Given a positive integer, print the next smallest and the next largest number 
 that have the same number of 1 bits in their binary representation
 */

/**
 Explainwhat the following code does: ((n & (n-1)) == 0).
 */

/**
 Write a function to determine the number of bits required to convert integer A to integer B.
 
 EXAMPLE 
 
 Input: 31,14 
 Output: 2
 */

/**
 Write a program to swap odd and even bits in an integer with asfew instructions 
 as possible (e.g., bit 0 and bit 1 are swapped, bit 2 and bit 3 are swapped, and soon).
 */

/**
 An array A contains all the integers from 0 to n, except for one number which is missing. 
 In this problem, we cannot access an entire integer in A with a single operation. The elements 
 of A are represented in binary, and the only operation we can use to access them is "fetch the jth bit of A[i]," 
 which takes constant time. Write code to find the missing integer. Can you do it in 0(n) time?
 */

/**
 A monochrome screen is stored as a single array of bytes, allowing eight consecutive pixels to be stored in one byte.
 The screen has width w, where w is divisible by 8 (that is,no byte will be split across rows).The height of the screen,
 of course, can be derived from the length of the array and the width. 
 
 Implement a function drawHorizontalline(byte[] screen, int width, int xl, int x2, int y) which draws ahorizontal line from (xl, y)to(x2, y).
 */

@end
