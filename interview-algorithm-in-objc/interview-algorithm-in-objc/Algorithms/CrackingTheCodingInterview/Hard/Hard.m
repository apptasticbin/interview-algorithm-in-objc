//
//  Hard.m
//  interview-algorithm-in-objc
//
//  Created by Bin Yu on 06/05/16.
//  Copyright © 2016 Bin Yu. All rights reserved.
//

#import "Hard.h"
#import "Queue.h"
#import "SuffixTree.h"

@implementation Hard

/**
 Write a function that adds two numbers. You should not use + or any arithmetic operators.
*/

+ (NSInteger)addNumber:(NSInteger)a andNumber:(NSInteger)b {
    /**
     http://stackoverflow.com/questions/13282825/adding-binary-numbers-in-c
     if a and b are positive numbers:
     9 + 3 = 12
     1001 ^ 0011 = 1010
     1001 & 0011 = 0001
     
     1010 ^ 0010 = 1000
     1010 & 0010 = 0010
     
     1000 ^ 0100 = 1100
     1000 & 0100 = 0000
     
     1100 -> 12
     
     About negative numbers in system:
     http://www.allaboutcircuits.com/textbook/digital/chpt-2/negative-binary-numbers/
     - As simple as the sign-magnitude approach is, it is not very practical for arithmetic purposes
     - 'complementation' works well with arithmetic operation:
     - The leftmost bit is more than just a sign bit; rather, it possesses a negative place-weight value
     - e.g. 5 => 0101 => 8*0 + 4*1 + 2*0 + 1*1
           -5 => 1011 => -8*1 + 4*0 + 2*1 + 1+1
     
     二补数: https://zh.wikipedia.org/wiki/%E4%BA%8C%E8%A3%9C%E6%95%B8
     - The 'minus' sign actually turned nunmber to its complementation number
     */
    
    NSInteger sum = a ^ b;
    NSInteger carry = a & b;
    while (YES) {
        if (!carry) {
            break;
        }
        NSInteger xor = sum;
        sum = xor ^ (carry << 1);
        carry = xor & (carry << 1);
    }
    return sum;
}

+ (NSInteger)recursionAddNumber:(NSInteger)a andNumber:(NSInteger)b {
    if (!b) {
        return a;
    }
    NSInteger sum = a ^ b;
    NSInteger carry = (a & b) << 1;
    return [self recursionAddNumber:sum andNumber:carry];
}

+ (NSInteger)substractNumber:(NSInteger)a andNumber:(NSInteger)b {
    return [self recursionAddNumber:a andNumber:-b];
}

/**
 Write a method to shuffle a deck of cards. It must be a perfect shuffle — in other words,
 each of the 52! permutations of the deck has to be equally likely. Assume that you are given 
 a random number generator which is perfect.
 */

/**
 - This is a very well-known interview question, and a well-known algorithm
 - Using our Base Case and Build approach
 - We would first shuffle the first n - 1 elements. Then, we would take the 
 nth element and randomly swap it with an element in the array
 */

// my solution
+ (NSArray *)perfectShuffleOfDeck:(NSArray *)deck {
    NSMutableArray *origDeck = [NSMutableArray arrayWithArray:deck];
    NSMutableArray *shuffleDeck = [NSMutableArray array];
    for (u_int32_t upperBound = 52; upperBound != 0; upperBound--) {
        NSInteger index = [self perfectRandomNumberGenerator:upperBound];
        [shuffleDeck addObject:origDeck[index]];
        [origDeck removeObjectAtIndex:index];
    }
    return shuffleDeck;
}

+ (u_int32_t)perfectRandomNumberGenerator:(u_int32_t)upperBound {
    return arc4random_uniform(upperBound);
}

+ (NSArray *)recursivePerfectShuffleOfDeck:(NSMutableArray *)deck amount:(NSInteger)amount {
    if (!amount) {
        return deck;
    }
    
    [self recursivePerfectShuffleOfDeck:deck amount:amount-1];
    NSInteger randomIndex = [self perfectRandomBetween:0 upperBound:(u_int32_t)amount];
    
    id tmp = deck[amount];
    deck[amount] = deck[randomIndex];
    deck[randomIndex] = tmp;
    
    return deck;
}

/* Random number between lower and higher, INCLUSIVE */
+ (u_int32_t)perfectRandomBetween:(u_int32_t)lowerBound upperBound:(u_int32_t)upperBound {
    // arc4random_uniform(N): 0 to N-1
    return lowerBound + arc4random_uniform(upperBound - lowerBound + 1);
}

// The iterative approach is usually how we see this algorithm written.
+ (void)perfectShuffleOfDeckIteratively:(NSMutableArray *)cards {
    for (NSInteger i = 0; i < cards.count; i++) {
        NSInteger k = [self perfectRandomBetween:0 upperBound:(u_int32_t)i];
        id temp = cards[k];
        cards[k] = cards[i];
        cards[i] = temp;
    }
}

/**
 Write a method to randomly generates set of m integers from an array of size n. 
 Each element must have equal probability of being chosen.
 */

/**
 https://en.wikipedia.org/wiki/Fisher%E2%80%93Yates_shuffle
 
 Fisher-Yates shuffle
 
 - Suppose we have an algorithm that can pull a random set of m elements from an array of size n - 1.
 How can we use this algorithm to pull a random set of m elements from an array of size n
 - Suppose n >= m
 */

+ (NSArray *)recursivelyRandomSetFromArray:(NSArray *)array amount:(NSInteger)m index:(NSInteger)i {
    if (i < m) {
        return [array subarrayWithRange:NSMakeRange(0, m)];
    }
    // n > m
    if (i > 0) {
        NSMutableArray *subset = [[self recursivelyRandomSetFromArray:array amount:m index:i-1] mutableCopy];
        NSInteger k = [self perfectRandomBetween:0 upperBound:(u_int32_t)i];
        if (k < m) {
            subset[k] = array[i];
        }
        return subset;
    }
    // if n <= m
    return nil;
}

/**
 - Question: how about n < m ?
 */
+ (NSArray *)interativelyRandomSetFromArray:(NSArray *)array amount:(NSInteger)m {
    NSMutableArray *subset = [NSMutableArray array];
    for (NSInteger i=0; i<m; i++) {
        [subset addObject:array[i]];
    }
    for (NSInteger i=m; i<array.count; i++) {
        NSInteger k = [self perfectRandomBetween:0 upperBound:(u_int32_t)i];
        if (k < m) {
            subset[k] = array[i];
        }
    }
    return subset;
}

/**
 Write a method to count the number of 2s that appear in all the numbers between 0 and n (inclusive).

 EXAMPLE:
 Input: 25
 Output: 9 (2, 12, 20, 21, 22, 23, 24 and 25. Note that 22 counts for two 2s.)
*/

/**
 - Solution 1: iterate from 0 to n, and count each digit (brute force)
 */

+ (NSInteger)bruteForceCountNumberOf2sBetween0AndN:(NSInteger)n {
    NSInteger count = 0;
    for (NSInteger i=0; i<=n; i++) {
        count += [self countOf2:i];
    }
    return count;
}

+ (NSInteger)countOf2:(NSInteger)n {
    NSInteger count = 0;
    while (n) {
        if (n % 10 == 2) {
            count++;
        }
        n = n / 10;
    }
    return count;
}

+ (NSInteger)betterCountNumberOf2sBetween0AndN:(NSInteger)n {
    NSString *numberString = [NSString stringWithFormat:@"%ld", n];
    NSInteger digitCount = numberString.length;
    NSInteger count = 0;
    for (NSInteger i=0; i<digitCount; i++) {
        count += [self count2sOfNumber:n digit:i];
    }
    return count;
}

+ (NSInteger)count2sOfNumber:(NSInteger)number digit:(NSInteger)d {
    NSInteger powerOf10 = pow(10, d);
    NSInteger nextPowerOf10 = powerOf10 * 10;
    NSInteger right = number % powerOf10;
    
    NSInteger roundDown = number - number % nextPowerOf10;
    NSInteger roundUp = roundDown + nextPowerOf10;
    
    NSInteger digit = (number / powerOf10) % 10;
    if (digit < 2) {
        return roundDown / 10;
    } else if (digit == 2) {
        return roundDown / 10 + right + 1;
    } else { // digit > 2
        return roundUp / 10;
    }
}

/**
 You have a large text file containing words. Given any two words, find the shortest distance 
 (in terms of number of words) between them in the file. If the operation will be repeated many times for the same 
 file (but different pairs of words), can you optimize your solution?
 */

/**
 About cache improvement:
 - cache each word and the index it occurs
 - listA: { 1, 2, 9, 15, 25 }
   listB: { 4, 10, 19 }
 - merge these lists into one sorted list, but "tag" each number with the original list.
 Tagging can be done by wrapping each value in a class that has two member variables: data (to store
 the actual value) and listNumber.
 
 list: { 1a, 2a, 4b, 9a, 10b, 15a, 19b, 25a }
 */

+ (NSInteger)shortestDistanceBetween:(NSString *)word1 and:(NSString *)word2 inFile:(NSArray *)words {
    static NSMutableDictionary *cache = nil;
    cache = [NSMutableDictionary dictionary];
    return [self shortestDistanceBetween:word1 and:word2 inFile:words cache:cache];
}

+ (NSInteger)shortestDistanceBetween:(NSString *)word1 and:(NSString *)word2 inFile:(NSArray *)words cache:(NSMutableDictionary *)cache {
    NSString *combinedWord = [word1 stringByAppendingString:word2];
    NSString *reversedCombinedWord = [word2 stringByAppendingString:word1];
    if (cache[combinedWord]) {
        return [cache[combinedWord] integerValue];
    }
    if (cache[reversedCombinedWord]) {
        return [reversedCombinedWord integerValue];
    }
    
    NSString *curWord = nil;
    NSInteger curIndex = 0;
    NSInteger shortestDistance = 0;
    for (NSInteger i=0; i<words.count; i++) {
        if ([words[i] isEqualToString:word1] || [words[i] isEqualToString:word2]) {
            if (curWord && ![words[i] isEqualToString:curWord]) {
                if (shortestDistance > i-curIndex-1) {
                    shortestDistance = i-curIndex-1;
                }
            }
            curWord = words[i];
            curIndex = i;
        }
    }
    cache[combinedWord] = @(shortestDistance);
    return shortestDistance;
}

/**
 Describe an algorithm to find the smallest one million numbers in one billion numbers. 
 Assume that the computer memory can hold all one billion numbers
 */

/**
 Solutions:
 - sorting and take first one million numbers
 - min heap: create max heap with first one million numbers, then insert new ones
 and remove largest one
 - Selection Rank is a well-known algorithm in computer science to find the ith 
 smallest (or largest) element in an array in linear time.
 - Similar to 'Quick sorting'
 */

+ (NSInteger)selectionRank:(NSMutableArray *)oneBillionNumbers left:(NSInteger)left right:(NSInteger)right rank:(NSInteger)rank {
    NSInteger pivotIndex = [self perfectRandomBetween:(u_int32_t)left upperBound:(u_int32_t)right];
    NSInteger pivot = [oneBillionNumbers[pivotIndex] integerValue];
    
    NSInteger leftEnd = [self partition:oneBillionNumbers left:left right:right pivot:pivot];
    NSInteger leftSize = leftEnd - left + 1;
    if (leftSize == rank + 1 /* ith number -> index i-1 */) {
        return [self maxOfNumbers:oneBillionNumbers left:left right:leftEnd];
    } else if (leftSize > rank) {
        return [self selectionRank:oneBillionNumbers left:left right:leftEnd rank:rank];
    } else {
        return [self selectionRank:oneBillionNumbers left:leftEnd+1 right:right rank:rank-leftSize];
    }
}

+ (NSInteger)partition:(NSMutableArray *)oneBillionNumbers left:(NSInteger)left right:(NSInteger)right pivot:(NSInteger)pivot {
    while (YES) {
        while (left <= right && [oneBillionNumbers[left] integerValue] <= pivot ) {
            left++;
        }
        while (left <= right && [oneBillionNumbers[right] integerValue] > pivot) {
            right--;
        }
        if (left > right) {
            return left-1;
        }
        // swap
        id tmp = oneBillionNumbers[left];
        oneBillionNumbers[left] = oneBillionNumbers[right];
        oneBillionNumbers[right] = tmp;
    }
}

+ (NSInteger)maxOfNumbers:(NSArray *)numbers left:(NSInteger)left right:(NSInteger)right {
    return 0;
}

/**
 Given a list of words, write a program to find the longest word made of other words in the list.
 
 EXAMPLE:
 Input: cat, banana, dog, nana, walk, walker, dogwalker 
 Output: dogwalker
 */

+ (NSString *)findLongestWordMadeOfOtherWordsInList:(NSArray *)list {
    NSMutableDictionary *words = [NSMutableDictionary dictionary];
    for (NSString *word in list) {
        words[word] = @(YES);
    }
    NSArray *sortedList = [list sortedArrayUsingComparator:^NSComparisonResult(NSString *obj1, NSString * obj2) {
        if (obj1.length < obj2.length) {
            return NSOrderedDescending;
        }
        if (obj1.length > obj2.length) {
            return NSOrderedAscending;
        }
        return NSOrderedSame;
    }];
    for (NSInteger i=0; i<sortedList.count; i++) {
        if ([self canBuildWord:sortedList[i] fromWords:words original:YES]) {
            return sortedList[i];
        }
    }
    return @"";
}

+ (BOOL)canBuildWord:(NSString *)word fromWords:(NSMutableDictionary *)words original:(BOOL)original {
    if (words[word] && !original) {
        return [words[word] boolValue];
    }
    for (NSInteger i=1; i<word.length; i++) {
        // A new string containing the characters of the receiver up to, but not including, the one at anIndex.
        NSString *left = [word substringToIndex:i];
        NSString *right = [word substringFromIndex:i];
        if (words[left] && [words[left] boolValue]
            && [self canBuildWord:right fromWords:words original:NO]) {
            return YES;
        }
    }
    /**
     - cache non-original words with 'NO' as value
     - this is DP improvement
     */
    words[word] = @(NO);
    return NO;
}

/**
 Given a string s and an array of smaller strings T, design a method to search s for each 
 small string in T.
 */

+ (NSArray<NSNumber *> *)searchSmallString:(NSString *)smallString inString:(NSString *)string {
    SuffixTree *suffixTree = [[SuffixTree alloc] initWithString:string];
    return [suffixTree search:smallString];
}

/**
 Numbers are randomly generated and passed to a method. Write a program to find and 
 maintain the median value as new values are generated.
 */

/**
 Median (中位数):
 - 计算有限个数的数据的中位数的方法是：把所有的同类数据按照大小的顺序排列。
 如果数据的个数是奇数，则中间那个数据就是这群数据的中位数；
 如果数据的个数是偶数，则中间那2个数据的算术平均值就是这群数据的中位数
 */

/**
 Solution:
 - use two priority heaps: a max heap for the values below the median, and a min heap for the values above the median
 - When a new value arrives, it is placed in the maxHeap if the value is less than or equal to the median, 
 otherwise it is placed into the minHeap.
 - The heap sizes can be equal, or the maxHeap may have one extra element.
 - The median is available in constant time, by looking at the top element(s). Updates take 0(log(n)) time.
 - Page 484
 */

+ (NSInteger)findMedianOfNumbers:(NSArray *)numbers {
    return 0;
}

+ (void)addNewNumber:(NSInteger)number {
    
}

/**
 Given two words of equal length that are in a dictionary, write a method to transform one word into 
 another word by changing only one letter at a time. The new word you get in each step must be in the dictionary.
 
 EXAMPLE:
 Input:  DAMP, LIKE
 Output: DAMP -> LAMP -> LIMP -> LIME -> LIKE
 */

/**
 - Improvement: add error handling
 - Problem: Maybe path is DAMP -> CAMP -> CAME -> LAME -> LIME -> LIKE
 - We need to find possibilities for all character combinations in dictionary from A to Z for each character
 */
+ (NSString *)transformWord:(NSString *)fromWord toWord:(NSString *)toWord inDictionary:(NSArray<NSString *> *)dictionary {
    NSMutableArray *transformSteps = [NSMutableArray array];
    [self transformWord:fromWord toWord:toWord inDictionary:dictionary transformSteps:transformSteps];
    return [transformSteps componentsJoinedByString:@" -> "];
}

+ (void)transformWord:(NSString *)fromWord toWord:(NSString *)toWord inDictionary:(NSArray<NSString *> *)dictionary
       transformSteps:(NSMutableArray *)steps {
    if ([fromWord isEqualToString:toWord]) {
        [steps addObject:fromWord];
        return;
    }
    
    for (NSInteger i=0; i<fromWord.length; i++) {
        NSString *fromCharacter = [self characterOfWord:fromWord atIndex:i];
        NSString *toCharacter = [self characterOfWord:toWord atIndex:i];
        
        if (![fromCharacter isEqualToString:toCharacter]) {
            NSMutableString *mutableFromWord = [fromWord mutableCopy];
            [mutableFromWord replaceCharactersInRange:NSMakeRange(i, 1) withString:toCharacter];
            
            if ([self word:mutableFromWord inDictionary:dictionary]) {
                [steps addObject:fromWord];
                [self transformWord:mutableFromWord toWord:toWord inDictionary:dictionary transformSteps:steps];
            }
        }
    }
}

+ (NSString *)characterOfWord:(NSString *)word atIndex:(NSInteger)index {
    return [word substringWithRange:NSMakeRange(index, 1)];
}

+ (BOOL)word:(NSString *)word inDictionary:(NSArray *)dictionary {
    return [dictionary containsObject:word];
}

/**
 Better solution:
 - Breath first search and Graph issues
 - "backtrack map." In this backtrack map, if B[v] = w, then you know that you edited v to get w
 */

+ (NSString *)betterTransformWord:(NSString *)fromWord toWord:(NSString *)toWord inDictionary:(NSArray<NSString *> *)dictionary {
    Queue *wordsQueue = [Queue new];
    NSMutableSet *visitedSet = [NSMutableSet set];
    NSMutableDictionary *backtraceMap = [NSMutableDictionary dictionary];
    
    [wordsQueue enqueue:fromWord];
    [visitedSet addObject:fromWord];
    
    while (![wordsQueue isEmpty]) {
        NSString *word = [wordsQueue dequeue];
        // first check if we already get target word
        for (NSString *editWord in [self wordsByEditOneCharacter:word]) {
            if ([editWord isEqualToString:toWord]) {
                NSMutableArray *backtraceArray = [NSMutableArray array];
                [backtraceArray addObject:editWord];
                while (word) {
                    [backtraceArray insertObject:word atIndex:0];
                    word = backtraceMap[word];
                }
                return [backtraceArray componentsJoinedByString:@" -> "];
            }
            
            if ([dictionary containsObject:editWord]) {
                if (![visitedSet containsObject:editWord]) {
                    [visitedSet addObject:editWord];
                    [wordsQueue enqueue:editWord];
                    backtraceMap[editWord] = word;
                }
            }
        }
    }
    return nil;
}

+ (NSSet *)wordsByEditOneCharacter:(NSString *)origWord {
    NSMutableSet *wordsSet = [NSMutableSet set];
    for (NSInteger i=0; i<origWord.length; i++) {
        NSArray *alphabetas = [self alphabetaCharacters];
        for (NSInteger j=0; j<alphabetas.count; j++) {
            NSMutableString *newWord = [origWord mutableCopy];
            [newWord replaceCharactersInRange:NSMakeRange(i, 1) withString:alphabetas[j]];
            [wordsSet addObject:newWord];
        }
    }
    return wordsSet;
}

+ (NSArray *)alphabetaCharacters {
    return @[@"A", @"B", @"C", @"D", @"E", @"F", @"G", @"H", @"I", @"J", @"K", @"L",
             @"M", @"N", @"O", @"P", @"Q", @"R", @"S", @"T", @"U", @"V", @"W", @"X", @"Y", @"Z"];
}

/**
 Imagine you have a square matrix, where each cell (pixel) is either black or white.
 Design an algorithm to find the maximum subsquare such that all four borders are filled with black pixels.
 */

/**
 1 0 0 1 0
 0 1 1 1 1
 1 1 0 1 0
 1 1 1 1 1
 0 1 0 0 0
 
 - The "Simple" Solution: O(power(N, 4)) (My solution)
 - Pre-processing solution: O (power(N, 3)): rebuild the matrix into (ZerosRight, ZerosBelow) (inclusive)
 then, only check processedMatrix[row][col].ZerosRight >= size && processedMatrix[row][col].ZerosBelow >= size
 - Page 489
 */

+ (id)maximumSubsquareOfMatrix:(NSArray<NSArray *> *)squareMatrix {
    for (NSInteger i=squareMatrix.count; i>=1; i--) {
        id subsquare = [self findSubsquareOfMatrix:squareMatrix size:i];
        if (subsquare) {
            return subsquare;
        }
    }
    return nil;
}

+ (id)findSubsquareOfMatrix:(NSArray<NSArray *> *)squareMatrix size:(NSInteger)size {
    NSInteger count = squareMatrix.count - size + 1;
    for (NSInteger row=0; row<count; row++) {
        for (NSInteger col=0; col<count; col++) {
            if ([self isSquare:squareMatrix size:size row:row column:col]) {
                return nil;
            }
        }
    }
    return nil;
}

+ (BOOL)isSquare:(NSArray<NSArray *> *)squareMatrix size:(NSInteger)size row:(NSInteger)row column:(NSInteger)col {
    for (NSInteger i=0; i<size; i++) {
        if ([squareMatrix[row][col+i] integerValue] == 1) {
            return NO;
        }
        if ([squareMatrix[row+size-1][col+i] integerValue] == 1) {
            return NO;
        }
    }
    
    for (NSInteger i=0; i<size; i++) {
        if ([squareMatrix[row+i][col] integerValue] == 1) {
            return NO;
        }
        if ([squareMatrix[row+i][col+size-1] integerValue] == 1) {
            return NO;
        }
    }
    return YES;
}

/**
 Given an NxN matrix of positive and negative integers, write code to find the submatrix with the largest possible sum.
 */

/**
 Solutions:
 - Brute Force
 - Improvement: Dynamic Programming
 - Optimized Solution: O(power(N, 3)): sum all columns from start row to end row; then find maximum sum between start column and end column
 - Recall the solution to the maximum subarray problem: Given an array of integers, find the subarray with the largest sum
 */

+ (NSInteger)maxSubmatrix:(NSArray<NSArray *> *)matrix {
    NSInteger rowCount = matrix.count;
    NSInteger colCount = matrix[0].count;
    
    NSMutableArray *partialSum = [NSMutableArray array];
    NSInteger maxSum = 0;
    for (NSInteger rowStart=0; rowStart<rowCount; rowStart++) {
        // clean before next iteration
        [partialSum removeAllObjects];
        for (NSInteger rowEnd=rowStart+1; rowEnd<rowCount; rowEnd++) {
            for (NSInteger i=0; i<colCount; i++) {
                partialSum[i] = @([partialSum[i] integerValue] + [matrix[rowEnd][i] integerValue]);
            }
            NSInteger tempMax = [self maxSubarray:partialSum];
            maxSum = MAX(maxSum, tempMax);
        }
    }
    return maxSum;
}

+ (NSInteger)maxSubarray:(NSArray *)array {
    NSInteger max = 0;
    NSInteger runningMax = 0;
    for (NSInteger i=0; i<array.count; i++) {
        runningMax += [array[i] integerValue];
        max = MAX(max, runningMax);
        /**
         - this ALSO means that if the final max result is "0", then the whole matrix numbers are 'minus' numbers.
         */
        if (runningMax < 0) {
            runningMax = 0;
        }
    }
    return max;
}

/**
 Given a list of millions of words, design an algorithm to create the largest possible 
 rectangle of letters such that every row forms a word (reading left to right) and every column 
 forms a word (reading top to bottom). The words need not be chosen consecutively from the list,
 but all rows must be the same length and all columns must be the same height.
 */

/**
 IMPORTANT: Many problems involving a dictionary can be solved by doing some pre-processing.
 - group based on length
 - build 'trie' (前缀数) to check if columns are available row by row. If any column is not available, then we stop here.
 - WordGroup: use HashTable<String, bool> to quick check existance of word, and use Array<WordGroup> to group words
 */

@end
