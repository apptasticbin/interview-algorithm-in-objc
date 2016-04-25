//
//  CrackingSortingAndSearching.m
//  interview-algorithm-in-objc
//
//  Created by Bin Yu on 20/04/16.
//  Copyright © 2016 Bin Yu. All rights reserved.
//

#import "CrackingSortingAndSearching.h"
#import <UIKit/UIKit.h>

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

/**
 https://en.wikipedia.org/wiki/Bucket_sort
 It is a distribution sort, and is a cousin of radix sort in the "most" to "least" significant digit flavour
 */
+ (void)bucketSort:(NSMutableArray *)integers {
    /**
     function bucketSort(array, n) is
        buckets ← new array of n empty lists
        for i = 0 to (length(array)-1) do
        insert array[i] into buckets[msbits(array[i], k)]
        for i = 0 to n - 1 do
            nextSort(buckets[i]);
        return the concatenation of buckets[0], ...., buckets[n-1]
     */
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
 - this is WRONG binary search implementation, because the return index is WRONG
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

int binarySearchRecursive(int* a, int x, int low, int high) {
    if (low > high) return -1; // Error
    int mid = (low + high) / 2;
    if (a[mid] < x) {
        return binarySearchRecursive(a, x, mid + 1, high);
    } else if (a[mid]>x) {
        return binarySearchRecursive(a, x, low, mid - 1);
    } else {
        return mid;
    }
}

#pragma mark - Questions

/**
 You are given two sorted arrays, A and B, where A has a large enough
 buffer at the end to hold B. Write a method to merge B into A in sorted order.
 */

/**
 - assume both array A and B are in ascend order
 */

+ (void)mergeArrayB:(NSArray *)arrayB intoArrayA:(NSMutableArray *)arrayA {
    if (!arrayA.count || !arrayB.count) {
        return;
    }
    // find the real count of arrayA
    NSInteger realCountA = 0;
    while (arrayA[realCountA] != [NSNull null]) {
        realCountA++;
    }
    NSInteger countAB = realCountA + arrayB.count - 1;
    NSInteger ia = realCountA-1;
    NSInteger ib = arrayB.count-1;
    for (; ib>=0 && ia>=0; countAB--) {
        if ([arrayA[ia] integerValue] > [arrayB[ib] integerValue]) {
            arrayA[countAB] = arrayA[ia];
            ia--;
        } else {
            arrayA[countAB] = arrayB[ib];
            ib--;
        }
    }
    for (; ib >= 0 && countAB >=0; ib--, countAB--) {
        arrayA[countAB] = arrayB[ib];
    }
}

/**
 Write a method to sort an array of strings so that all the anagrams are 
 next to each other.
 */

/**
 What's the easiest way of checking if two words are anagrams? 
 - We could count the occurrences of the distinct characters in each string and return true if they match.
 - Or, we could just sort the string. After all, two words which are anagrams will look the same once they're sorted.
 */

+ (void)sortAnagramArray:(NSMutableArray *)anagramArray {
    if (anagramArray.count < 2) {
        return;
    }
    NSInteger current = 0;
    while (current < anagramArray.count) {
        for (NSInteger next=current+1; next<anagramArray.count; next++) {
            NSString *currentString = anagramArray[current];
            NSString *nextString = anagramArray[next];
            if ([self checkAnagramBetweenString:currentString andString:nextString]
                && current+1 != next) {
                NSString *tmp = anagramArray[++current];
                anagramArray[current] = anagramArray[next];
                anagramArray[next] = tmp;
            }
        }
        current++;
    }
}

+ (NSCountedSet *)patternOfString:(NSString *)string {
    NSCountedSet *counter = [NSCountedSet set];
    for (NSInteger i=0; i<string.length; i++) {
        NSString *character = [string substringWithRange:NSMakeRange(i, 1)];
        [counter addObject:character];
    }
    return counter;
}

+ (BOOL)checkAnagramBetweenString:(NSString *)thisString andString:(NSString *)thatString {
    return [[self patternOfString:thisString] isEqualToSet:[self patternOfString:thatString]];
}

/**
 You may notice that the algorithm above is a modification of "bucket sort"
 */
+ (void)hashSortAnagramArray:(NSMutableArray *)anagramArray {
    if (anagramArray.count < 2) {
        return;
    }
    // use Dictionary (Hash Map) to group anagram strings
    NSMutableDictionary *anagramDict = [NSMutableDictionary dictionary];
    for (NSUInteger i=0; i<anagramArray.count; i++) {
        NSString *sortedString = [self sortString:anagramArray[i]];
        if (anagramDict[sortedString]) {
            NSMutableArray *group = anagramDict[sortedString];
            [group addObject:anagramArray[i]];
        } else {
            anagramDict[sortedString] = [NSMutableArray array];
            [anagramDict[sortedString] addObject:anagramArray[i]];
        }
    }
    // copy grouped strings back
    NSInteger counter = 0;
    for (NSString *key in anagramDict.allKeys) {
        NSArray *group = anagramDict[key];
        for (NSInteger i=0; i<group.count; i++) {
            anagramArray[counter] = group[i];
            counter++;
        }
    }
}

+ (NSString *)sortString:(NSString *)string {
    NSMutableArray *characters = [NSMutableArray array];
    for (NSInteger i=0; i<string.length; i++) {
        [characters addObject:[string substringWithRange:NSMakeRange(i, 1)]];
    }
    [characters sortUsingComparator:^NSComparisonResult(NSString *str1, NSString *str2) {
        unichar c1, c2;
        [str1 getCharacters:&c1];
        [str2 getCharacters:&c2];
        if (c1 < c2) {
            return NSOrderedAscending;
        } else if (c1 > c2) {
            return NSOrderedDescending;
        }
        return NSOrderedSame;
    }];
    return [characters componentsJoinedByString:@""];
}

/**
 Given a sorted array of n integers that has been rotated an unknown number of times,
 write code to find an element in the array. You may assume that the array was originally 
 sorted in increasing order.
 
 EXAMPLE
 Input: find 5 in {15, 16, 19, 20, 25, 1, 3, 4, 5, 7, 10, 14} 
 Output: 8 (the index of 5 in the array)
 */

/**
 The tricky condition is if the left and the middle are identical, 
 as in the example array {2, 2, 2, 3, 4, 2}. In this case, we can check if the right most element is different.
 If it is,we can search just the right side. Otherwise, we have no choice but to search both halves.
 */

/**
 BUG: hard to figure out duplicated numbers
 */

+ (NSInteger)indexOfNumber:(NSInteger)number inRotatedSortedArray:(NSArray *)integers {
    if (!integers || !integers.count) {
        return -1;
    }
    if (integers.count < 2) {
        return 0;
    }
    NSInteger head = 0;
    NSInteger end = 0;
    for (NSInteger i=1; i<integers.count; i++) {
        if ([integers[i] integerValue] < [integers[end] integerValue]) {
            head = i;
            break;
        }
        end = i;
    }
    /**
     array before head and array after head are sorted sub-arrays
     use binary search
     */
    if (number <= [integers.lastObject integerValue]) {
        return [self binarySearch:integers value:number from:head to:integers.count-1];
    } else {
        return [self binarySearch:integers value:number from:0 to:end];
    }
}

+ (NSInteger)binarySearch:(NSArray *)integers value:(NSInteger)value from:(NSInteger)from to:(NSInteger)to {
    if (from > to) {
        return -1;
    }
    NSInteger mid = (from + to) / 2;
    if ([integers[mid] integerValue] == value) {
        return mid;
    } else if ([integers[mid] integerValue] > value) {
        return [self binarySearch:integers value:value from:from to:mid-1];
    } else {
        return [self binarySearch:integers value:value from:mid+1 to:to];

    }
}

/**
 better but complex solution
 */
+ (NSInteger)anotherIndexOfNumber:(NSInteger)number inRotatedSortedArray:(NSArray *)integers {
    return [self search:integers value:number left:0 right:integers.count-1];
}

+ (NSInteger)search:(NSArray *)integers value:(NSInteger)value left:(NSInteger)left right:(NSInteger)right {
    NSInteger mid = (left + right) / 2;
    if ([integers[mid] integerValue] == value) {
        return mid;
    }
    if (left > right) {
        return -1;
    }
    // left is sorted
    if ([integers[left] integerValue] < [integers[mid] integerValue]) {
        if (value >= [integers[left] integerValue] && value <= [integers[mid] integerValue]) {
            return [self search:integers value:value left:left right:mid-1];
        } else {
            return [self search:integers value:value left:mid+1 right:right];
        }
    } else if ([integers[left] integerValue] > [integers[mid] integerValue]) {
        if (value >= [integers[mid] integerValue] && value <= [integers[right] integerValue]) {
            return [self search:integers value:value left:mid+1 right:right];
        } else {
            return [self search:integers value:value left:left right:mid-1];
        }
    } else if ([integers[left] integerValue] == [integers[mid] integerValue]) {
        /**
         tricky part to check duplicated values on the left
         */
        if ([integers[mid] integerValue] != [integers[right] integerValue]) {
            return [self search:integers value:value left:mid+1 right:right];
        } else {
            NSInteger result = [self search:integers value:value left:left right:mid-1];
            if (result == -1) {
                return [self search:integers value:value left:mid+1 right:right];
            } else {
                return result;
            }
        }
    }
    return -1;
}

/**
 Imagine you have a 20 GB file with one string per line. Explain how you would
 sort the file.
 */

+ (void)sortBigFileStrings:(NSArray *)strings {
    /**
     - split big file into small files
     - radix sort strings in small file from most significant character to least significant character
     - merge sort small file results into bigger file
     - This algorithm is known as external sort. ( https://en.wikipedia.org/wiki/External_sorting )
     */
}

/**
 Given a sorted array of strings which is interspersed with empty strings,
 write a method to find the location of a given string.
 
 EXAMPLE
 Input: find "ball" in {"at", "", "", "", "ball", "", "", "car", "", "", "dad", "", ""}
 Output: 4
 */

+ (NSInteger)locationOfString:(NSString *)theString inSortedArrayWithEmptyStrings:(NSArray *)array {
    if (!array || !array.count || !theString.length) {
        return -1;
    }
    return [self modifiedBinarySearch:array value:theString left:0 right:array.count-1];
}

+ (NSInteger)modifiedBinarySearch:(NSArray *)array value:(NSString *)value left:(NSInteger)left right:(NSInteger)right {
    if (!array || !array.count) {
        return -1;
    }
    if (left > right) {
        return -1;
    }
    NSInteger mid = (left + right) / 2;
    if (![array[mid] length]) { // array[mid] is empty string
        NSInteger midLeft = mid-1;
        NSInteger midRight = mid+1;
        while (YES) {
            if (midLeft < left && midRight > right) {
                return -1;
            } else if (midRight <= right && [array[midRight] length]) {
                mid = midRight;
                break;
            } else if (midLeft >= left && [array[midLeft] length]) {
                mid = midLeft;
                break;
            }
            midLeft--;
            midRight++;
        }
    }
        
    if ([array[mid] isEqualToString:value]) {
        return mid;
    } else if ([array[mid] compare:value] == NSOrderedAscending) {
        return [self modifiedBinarySearch:array value:value left:mid+1 right:right];
    } else {
        return [self modifiedBinarySearch:array value:value left:left right:mid-1];
    }
}

+ (NSInteger)binaryStringSearch:(NSArray *)array value:(NSString *)value left:(NSInteger)left right:(NSInteger)right {
    if (!array || !array.count) {
        return -1;
    }
    if (left > right) {
        return -1;
    }
    NSInteger mid = (left + right) / 2;
    if ([array[mid] isEqualToString:value]) {
        return mid;
    }
    if ([array[mid] compare:value] == NSOrderedAscending) {
        return [self binaryStringSearch:array value:value left:mid+1 right:right];
    } else {
        return [self binaryStringSearch:array value:value left:left right:mid-1];
    }
}

/**
 Given an MxN matrix in which each row and each column is sorted in ascending order, 
 write a method to find an element
 */

/**
 - Using 'diagonal' to section matrix
 1  3  5  7
 4  6  12 14
 8  10 13 18
 9  11 15 23
 - Solution 1: binary searching each row, O(Mlog(N))
 - Solution 2: minimize scope (as below)
 */
+ (BOOL)findValue:(NSInteger)value inMatrix:(NSArray<NSArray *> *)matrix {
    if (!matrix || !matrix.count) {
        return NO;
    }
    NSInteger row = 0;
    NSInteger col = matrix[0].count - 1;
    while (row < matrix.count && col >= 0) {
        NSInteger element = [[[matrix objectAtIndex:row] objectAtIndex:col] integerValue];
        if (element == value) {
            return YES;
        } else if (element > value) {
            col--;
        } else {
            row++;
        }
    }
    return NO;
}

// Solution 3: binary search matrix (using diagonal)
+ (BOOL)betterFindValue:(NSInteger)value inMatrix:(NSArray<NSArray *> *)matrix {
    // p369 - p370
    return NO;
}

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
 - Similar question as "Boxes" question in 'Recursion and DP' part
 - We have a list of pairs of items. Find the longest sequence such that both the 
 first and second items are in non-decreasing order.
 - We simply sort the list of people by their heights, and then apply the longest increasing 
 subsequence algorithm on just their weights.
 - DP
 */

+ (NSArray *)longestPossibleSequenceOfPeopleInTower:(NSArray *)people {
    // sort height
    NSArray *sortedHeightPeople =
    [people sortedArrayUsingComparator:^NSComparisonResult(NSValue* obj1, NSValue *obj2) {
        CGPoint p1 = [obj1 CGPointValue];
        CGPoint p2 = [obj2 CGPointValue];
        if (p1.y < p2.y) {
            return NSOrderedAscending;
        } else if (p1.y > p2.y) {
            return NSOrderedDescending;
        }
        return NSOrderedSame;
    }];
    return [self longestPossibleSequenceOfPeople:sortedHeightPeople];
}

+ (NSArray *)longestPossibleSequenceOfPeople:(NSArray *)people {
    NSMutableArray *solutions = [NSMutableArray array];
    [self longestPossibleSequenceOfPeople:people solutions:solutions currentIndex:0];
    NSArray *bestSequence = nil;
    for (NSInteger i=0; i<solutions.count; i++) {
        bestSequence = [self longerSequenceBetween:bestSequence thatSequence:solutions[i]];
    }
    return bestSequence;
}

+ (void)longestPossibleSequenceOfPeople:(NSArray *)people solutions:(NSMutableArray *)solutions
                           currentIndex:(NSInteger)currentIndex {
    if (currentIndex >= people.count || currentIndex < 0) {
        return;
    }
    CGPoint currentPerson = [people[currentIndex] CGPointValue];
    NSArray *bestSequence = nil;
    for (NSInteger i=0; i<currentIndex; i++) {
        if ([self person:[people[i] CGPointValue] abovePerson:currentPerson]) {
            NSArray *solution = i < solutions.count ? solutions[i] : nil;
            bestSequence = [self longerSequenceBetween:bestSequence thatSequence:solution];
        }
    }
    NSMutableArray *newSolution = [NSMutableArray array];
    if (bestSequence) {
        [newSolution addObjectsFromArray:bestSequence];
    }
    [newSolution addObject:people[currentIndex]];
    [solutions addObject:newSolution];
    [self longestPossibleSequenceOfPeople:people solutions:solutions currentIndex:currentIndex+1];
}

+ (BOOL)person:(CGPoint)thisPerson abovePerson:(CGPoint)thatPerson {
    if ((thisPerson.x < thatPerson.x) && (thisPerson.y < thatPerson.y)) {
        return YES;
    }
    return NO;
}

+ (NSArray *)longerSequenceBetween:(NSArray *)thisSequence thatSequence:(NSArray *)thatSequence {
    if (!thisSequence) {
        return thatSequence;
    }
    if (!thatSequence) {
        return thisSequence;
    }
    return thisSequence.count > thatSequence.count ? thisSequence : thatSequence;
}

/**
 Imagine you are reading in a stream of integers. Periodically, you wish to be able to look up 
 the rank of a number x (the number of values less than or equal to x). Implement the data structures
 and algorithms to support these operations. That is, implement the method track(int x),
 which is called when each number is generated, and the method getRankOfNumber(int x),
 which returns the number of values less than or equal to x (not including x itself).

 EXAMPLE:
 
 Stream (in order of appearance): 5, 1, 4, 4, 5, 9, 7, 13, 3
 getRankOfNumber(1) = 0
 getRankOfNumber(3) = 1 
 getRankOfNumber(4) = 3
 */

+ (void)rankNumbers {
    // check 'RankingNumbers' implementation
}

@end
