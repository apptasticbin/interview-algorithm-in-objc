//
//  ModerateQuestions.m
//  interview-algorithm-in-objc
//
//  Created by Bin Yu on 02/05/16.
//  Copyright © 2016 Bin Yu. All rights reserved.
//

#import "ModerateQuestions.h"
#import "BiNode.h"
#import "XML.h"

@implementation ModerateQuestions

/** 
 Write a function to swap a number in place (that is, without temporary variables).
 */

+ (void)swapA:(NSInteger *)a b:(NSInteger *)b {
    if (*a == *b) {
        return;
    }
    
    *b = *a - *b;
    *a = *a - *b;
    *b = *a + *b;
}

// NOTICE: this only support integers
+ (void)bitOperationSwapA:(NSInteger *)a b:(NSInteger *)b {
    if (*a == *b) {
        return;
    }
    // find out which bits equal, and which not
    *a = *a ^ *b;
    // keep equal bits, flip non-equal bits, then we assign a to b
    *b = *a ^ *b;
    // keep equal bits and flip non-equal bits again, then we assign b to a
    *a = *a ^ *b;
}

/**
 Design an algorithm to figure out if someone has won a game of tic-tac-toe.
 */

/**
 Example:
 
 O X O
 X X O
 O O X
 
 - Solution 1: check each row, each column, and each diagonal -> support 3x3 and NxN
 - Solution 2: if 3x3 board, each cell has 3 status (0, 1, or 2). So we have maximum power(3, 9) board possibilities.
 using hash table to map all board possibilities with who wins
 */

+ (NSNumber *)checkWonOfNxNTicTacToe:(NSArray <NSArray *> *)board {
    NSInteger N = board.count;
    NSInteger row = 0;
    NSInteger col = 0;
    // check each row
    for (row=0; row<N; row++) {
        if (board[row][0] != [NSNull null]) {
            for (col=1; col<N; col++) {
                if (![board[row][col] isEqual:board[row][col-1]]) {
                    break;
                }
            }
            if (col == N) {
                return board[row][0];
            }
        }
    }
    
    // check each column
    for (col=0; col<N; col++) {
        if (board[0][col] != [NSNull null]) {
            for (row=1; row<N; row++) {
                if (![board[row][col] isEqual:board[row-1][col]]) {
                    break;
                }
            }
            if (row == N) {
                return board[0][col];
            }
        }
    }
    
    // check diagonal from top-left to bottom-right
    if (board[0][0] != [NSNull null]) {
        for (col=1; col<N; col++) {
            if (![board[col][col] isEqual:board[col-1][col-1]]) {
                break;
            }
        }
        if (col == N) {
            return board[0][0];
        }
    }
    
    // check diagonal from bottom-left to top-right
    if (board[N-1][0] != [NSNull null]) {
        for (col=1; col<N; col++) {
            if (![board[N-1-col][col] isEqual:board[N-col][col-1]]) {
                break;
            }
        }
        if (col == N) {
            return board[N-1][0];
        }
    }
    
    return nil;
}

/**
 Write an algorithm which computes the number of trailing zeros in n factorial.
 */

/**
 Problem for this solution:
 - will exceed bound of 'int' soon when 'n' is big number
 */
+ (NSInteger)trailingZerosInNFactorial:(NSInteger)n {
    NSInteger fractorial = 1;
    for (NSInteger i=1; i<=n; i++) {
        fractorial *= i;
    }
    
    NSInteger counter = 0;
    while (fractorial % 10 == 0) {
        counter++;
        fractorial /= 10;
    }
    return counter;
}

+ (NSInteger)betterTrailingZerosInNFractorial:(NSInteger)n {
    /**
     My Assumption:
     10! = 1 * 2 * 3 * 4 * 5 * 6 * 7 * 8 * 9 * 10
     - amount of '2' is ALWAYS more than amount of '5'
     - amount of '5' equals to amount of trailing zeros
     */
    NSInteger counter = 0;
    for (NSInteger i=1; i<=n; i++) {
        NSInteger cur = i;
        while (cur % 5 == 0) {
            counter++;
            cur = cur / 5;
        }
    }
    return counter;
}

int countFactZeros(int num) {
    int count = 0;
    if (num < 0) {
        return -1;
    }
    for (int i=5; num / i > 0; i *= 5) {
        count += num / i;
    }
    return count;
}

/**
 Write a method which finds the maximum of two numbers. You should not use if-else or any other comparison operator.
 */

+ (NSInteger)maximumBetweenA:(NSInteger)a andB:(NSInteger)b {
    /**
     - bit manipulation to get sign of a-b
     - int k = sign(a - b);
       int q = flip(k);
       return a * k + b * q;
     - book page p163
     */
    return 0;
}

/** 
 The Game of Master Mind is played as follows:
 
 The computer has four slots, and each slot will contain a ball that is red (R), yellow (Y), green (G) or blue (B). 
 For example, the computer might have RGGB (Slot #1 is red, Slots #2 and #3 are green, Slot #4 is blue).
 
 You, the user, are trying to guess the solution. You might, for example, guess YRGB.
 
 When you guess the correct color for the correct slot, you get a "hit." 
 If you guess a color that exists but is in the wrong slot, you get a "pseudo-hit." 
 Note that a slot that is a hit can never count as a pseudo-hit.

 For example, if the actual solution is RGBY and you guess GGRR, you have one hit and one pseudo-hit.
 
 Write a method that, given a guess and a solution, returns the number of hits and pseudo-hits.
 */

+ (NSArray *)numberOfHisAndPseudoHitsOfGuess:(NSArray *)guess solution:(NSArray *)solution {
    static NSInteger GAME_LENGTH = 4;
    /**
     Improvement: 
     - use one frequency array instead of two sets
     - count non-hit characters
     - then check hit non-hit characters count
     - use 'code' method to turn characters into integers (array index)
     */
    NSCountedSet *solutionCounterSet = [NSCountedSet set];
    NSCountedSet *guessCounterSet = [NSCountedSet set];
    NSInteger hitsCounter = 0;
    NSInteger pseudoHitsCounter = 0;
    
    if (guess.count != solution.count) {
        return nil;
    }
    
    // count solution and guess characters
    for (NSInteger i=0; i<GAME_LENGTH; i++) {
        [guessCounterSet addObject:guess[i]];
        [solutionCounterSet addObject:solution[i]];
    }
    // find out hits
    for (NSInteger i=0; i<GAME_LENGTH; i++) {
        if ([guess[i] isEqualToString:solution[i]]) {
            hitsCounter++;
            [solutionCounterSet removeObject:solution[i]];
            [guessCounterSet removeObject:guess[i]];
        }
    }
    
    [guessCounterSet intersectSet:solutionCounterSet];
    pseudoHitsCounter = guessCounterSet.count;
    
    return @[@(hitsCounter), @(pseudoHitsCounter)];
}

/**
 Given an array of integers, write a method to find indices m and n such that if you sorted elements m through n, 
 the entire array would be sorted. Minimize n - m (that is, find the smallest such sequence).
 
 EXAMPLE
 
 Input: 1, 2, 4, 7, 10, 11, 7, 12, 6, 7, 16, 18, 19
 Output: (3, 9)
 
 Input: 1, 2, 10, 12, 4, 11, 12, 13, 14, 15, 16, 18, 19
 Output: (2, 4)

 */

+ (NSArray *)minimizeRangeToSort:(NSArray *)integers {
    NSInteger leftEnd = [self findEndOfLeftSequence:integers];
    NSInteger rightStart = [self findStartOfRightSequence:integers];
    
    NSInteger midMin = leftEnd+1;
    if (midMin >= integers.count) {
        return nil;
    }
    NSInteger midMax = rightStart-1;
    for (NSInteger i=leftEnd; i<=rightStart; i++) {
        if ([integers[i] integerValue] < [integers[midMin] integerValue]) {
            midMin = i;
        }
        if ([integers[i] integerValue] > [integers[midMax] integerValue]) {
            midMax = i;
        }
    }
    
    NSInteger leftIndex = [self shrinkLeft:integers minIndex:midMin leftEnd:leftEnd];
    NSInteger rightIndex = [self shrinkRight:integers maxIndex:midMax rightStart:rightStart];
    
    return @[@(leftIndex), @(rightIndex)];
}

+ (NSInteger)findEndOfLeftSequence:(NSArray *)integers {
    for (NSInteger i=1; i<integers.count; i++) {
        if ([integers[i] integerValue] < [integers[i-1] integerValue]) {
            return i-1;
        }
    }
    return integers.count-1;
}

+ (NSInteger)findStartOfRightSequence:(NSArray *)integers {
    for (NSInteger i=integers.count-2; i>=0; i--) {
        if ([integers[i] integerValue] > [integers[i+1] integerValue]) {
            return i+1;
        }
    }
    return 0;
}

+ (NSInteger)shrinkLeft:(NSArray *)integers minIndex:(NSInteger)minIndex leftEnd:(NSInteger)leftEnd {
    for (NSInteger i=leftEnd-1; i>=0; i--) {
        if ([integers[i] integerValue] <= [integers[minIndex] integerValue]) {
            return i+1;
        }
    }
    return 0;
}

+ (NSInteger)shrinkRight:(NSArray *)integers maxIndex:(NSInteger)maxIndex rightStart:(NSInteger)rightStart {
    for (NSInteger i=rightStart; i<integers.count; i++) {
        if ([integers[i] integerValue] >= [integers[maxIndex] integerValue]) {
            return i-1;
        }
    }
    return integers.count-1;
}

/**
 Given any integer, print an English phrase that describes the integer 
 (e.g., "One Thousand, Two Hundred Thirty Four").
 */

/**
 Hint:
 convert(19,323,984) = convert(19) + "million" + convert(323) + "thousand" + convert(984)
 
 Improvement: 
 - Add "And"
 - Use N * 1000, instead of 1000 and 1000000 for "Thousand" and "Million" checking
 - Add "Negative"
 - Replace 'type' by enum or others
 
 - Page 451
 */

+ (NSString *)englishPhraseOfInteger:(NSInteger)integer {
    if (integer < 20) {
        return [self phraseOfUnits:integer];
    }
    
    NSMutableArray *phraseParts = [NSMutableArray array];
    if (integer < 0) {
        [phraseParts addObject:@"Negative"];
        integer = ABS(integer);
    }
    
    NSInteger type = -1;
    
    NSInteger integerBits = [self bitsOfInteger:integer];
    if (integerBits == 2) {
        type = 10;
    } else if (integerBits == 3) {
        type = 100;
    } else if (integerBits > 3 && integerBits < 7) {
        type = 1000;
    } else if (integerBits >= 7 && integerBits < 10) {
        type = 1000000;
    } else {
        // let's only support to Million
        return nil;
    }
    
    switch (type) {
        case 1000000: {
            NSInteger amountOfMillions = integer / 1000000;
            if (amountOfMillions > 0) {
                [phraseParts addObject:[self englishPhraseOfInteger:amountOfMillions]];
                [phraseParts addObject:[self phraseOfMillion:amountOfMillions]];
                integer -= amountOfMillions * 1000000;
            }
        }
        case 1000: {
            NSInteger amountOfThousands = integer / 1000;
            if (amountOfThousands) {
                [phraseParts addObject:[self englishPhraseOfInteger:amountOfThousands]];
                [phraseParts addObject:[self phraseOfThousands:amountOfThousands]];
                integer -= amountOfThousands * 1000;
            }
        }
        case 100: {
            NSInteger amountOfHundreds = integer / 100;
            if (amountOfHundreds > 0) {
                [phraseParts addObject:[self englishPhraseOfInteger:amountOfHundreds]];
                [phraseParts addObject:[self phraseOfHundreds:amountOfHundreds]];
                integer -= amountOfHundreds * 100;
            }
        }
        case 10: {
            NSInteger amountOfTens = integer / 10;
            if (amountOfTens > 0) {
                [phraseParts addObject:[self phraseOfTens:amountOfTens]];
                integer -= amountOfTens * 10;
            }
        }
        case 1: {
            if (integer > 0) {
                [phraseParts addObject:[self englishPhraseOfInteger:integer]];
            }
        }
    }
    
    return [phraseParts componentsJoinedByString:@" "];
}

+ (NSInteger)bitsOfInteger:(NSInteger)integer {
    NSInteger counter = 1;
    while (integer / 10 != 0) {
        integer /= 10;
        counter++;
    }
    return counter;
}

+ (NSString *)phraseOfUnits:(NSInteger)units {
    NSArray *unitsPhrase = @[@"Zero", @"One", @"Two", @"Three", @"Four", @"Five", @"Six", @"Seven", @"Eight", @"Nine",
                             @"Ten", @"Eleven", @"Twelve", @"Thirteen", @"Fourteen", @"Fifteen", @"Sixteen", @"Seventeen", @"Eighteen", @"Nineteen"];
    return unitsPhrase[units];
}

+ (NSString *)phraseOfTens:(NSInteger)tens {
    NSArray *tensPhrase = @[@"", @"", @"Twenty", @"Thirty", @"Fourty", @"Fifty", @"Sixty", @"Seventy", @"Eighty", @"Ninety"];
    return tensPhrase[tens];
}

+ (NSString *)phraseOfHundreds:(NSInteger)hundreds {
    return hundreds > 1 ? @"Hundreds" : @"Hundred";
}

+ (NSString *)phraseOfThousands:(NSInteger)thousands {
    return thousands > 1 ? @"Thousands" : @"Thousand";
}

+ (NSString *)phraseOfMillion:(NSInteger)millions {
    return millions > 1 ? @"Millions" : @"Million";
}

/**
 You are given an array of integers (both positive and negative). Find the contiguous sequence with the largest sum. 
 Return the sum.
 
 EXAMPLE
 
 Input: 2, -8, 3, -2, 4, -10 
 Outputs: 5 (i.e., {3, -2, 4})
 */

/**
 Weird solution: Page 454
 */

+ (NSInteger)contiguousSequenceWithLargestSumOfIntegers:(NSArray *)integers {
    NSInteger max = -LONG_MAX;
    [self contiguousSequenceWithLargestSumOfIntegers:integers left:0 right:integers.count-1 max:&max];
    return max;
}

+ (void)contiguousSequenceWithLargestSumOfIntegers:(NSArray *)integers left:(NSInteger)left right:(NSInteger)right max:(NSInteger *)max {
    if (left > right) {
        return;
    }
    
    NSInteger leftPositive = [self indexOfFirstPositiveIntegerOfIntegers:integers left:left right:right];
    if (leftPositive == -1) {
        *max = [self findMaxNegativeIntegerOfIntegers:integers];
        return;
    }
    
    NSInteger rightPositive = [self indexOfLastPositiveIntegerOfIntegers:integers left:left right:right];
    NSInteger sum = [self sumOfIntegers:integers left:leftPositive right:rightPositive];
    if (sum > *max) {
        *max = sum;
    }
    [self contiguousSequenceWithLargestSumOfIntegers:integers left:leftPositive right:rightPositive-1 max:max];
    [self contiguousSequenceWithLargestSumOfIntegers:integers left:leftPositive+1 right:rightPositive max:max];
}

+ (NSInteger)indexOfFirstPositiveIntegerOfIntegers:(NSArray *)integers left:(NSInteger)left right:(NSInteger)right {
    for (NSInteger i=left; i<=right; i++) {
        if ([integers[i] integerValue] > 0) {
            return i;
        }
    }
    return -1;
}

+ (NSInteger)indexOfLastPositiveIntegerOfIntegers:(NSArray *)integers left:(NSInteger)left right:(NSInteger)right {
    for (NSInteger i=right; i>=left; i--) {
        if ([integers[i] integerValue] > 0) {
            return i;
        }
    }
    return -1;
}

+ (NSInteger)findMaxNegativeIntegerOfIntegers:(NSArray *)integers {
    NSInteger maxNegativeInteger = [integers[0] integerValue];
    for (NSInteger i=1; i<integers.count; i++) {
        if ([integers[i] integerValue] > maxNegativeInteger) {
            maxNegativeInteger = [integers[i] integerValue];
        }
    }
    return maxNegativeInteger;
}

+ (NSInteger)sumOfIntegers:(NSArray *)integers left:(NSInteger)left right:(NSInteger)right {
    NSInteger sum = 0;
    for (NSInteger i=left; i<=right; i++) {
        sum += [integers[i] integerValue];
    }
    return sum;
}

/**
 Design a method to find the frequency of occurrences of any given word in a book.
 */

+ (NSInteger)frequencyOfOccurrencesOfWord:(NSString *)word inBook:(NSArray<NSString *> *)book {
    NSMutableDictionary *wordFrequencies = [NSMutableDictionary dictionary];
    for (NSString *bookWord in book) {
        NSString *lowerCaseWord = bookWord.lowercaseString;
        if ([lowerCaseWord stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]].length) {
            if (!wordFrequencies[lowerCaseWord]) {
                wordFrequencies[lowerCaseWord] = @(0);
            }
            wordFrequencies[lowerCaseWord] = @([wordFrequencies[lowerCaseWord] integerValue] + 1);
        }
    }
    
    return [wordFrequencies[word.lowercaseString] integerValue];
}

/**
 Since XML is very verbose, you are given a way of encoding it where each tag gets mapped to 
 a pre-defined integer value.
 
 The language / grammarisas follows:
 
 Element    --> Tag Attributes END Children END
 Attribute  --> Tag Value
 END        --> 0
 Tag        --> some predefined mapping to int
 Value      --> string value END
 
 For example, the following XML might be converted into the compressed string 
 below (assuming a mapping of family -> 1, person ->2, firstName -> 3, lastName -> 4, state -> 5).
 
 <family lastName="McDowell" state="CA">
    <person firstName="Gayle">Some Message</person>
 </family> 
 
 Becomes:
    1 4 McDowell 5 CA 0 2 3 Gayle 0 Some Message 0 0.
 
 Write code to print the encoded version of an XML element (passed in Element and Attribute objects).
 */

/**
 - tree solution
 - Page 456
 */

+ (NSString *)encodeXML:(Element *)root {
    NSMutableArray *buffer = [NSMutableArray array];
    [self encode:root buffer:buffer];
    return [buffer componentsJoinedByString:@" "];
}

+ (void)encode:(Element *)root buffer:(NSMutableArray *)buffer {
    
}

+ (void)encodeCode:(NSString *)code buffer:(NSMutableArray *)buffer {
    
}

+ (void)encodeAttribute:(Attribute *)attr buffer:(NSMutableArray *)buffer {
    
}

/**
 Implement a method rand7() given rand5(). That is, given a method that generates a random number 
 between 0 and 4 (inclusive), write a method that generates a random number between 0 and 6 
 (inclusive).
 */

/**
 - return 0 to 6 with 1/7 possibility for each number => equally distributed
 - ( rand5() + rand5() ) % 7 doesn't work
 - 'while loop' helps to discard the elements greater than the previous multiple of 7
 - In fact, there is an infinite number of ranges we can use. 
 The key is to make sure that the range is big enough and that all values are equally likely.
 */

+ (NSInteger)rand7 {
    while (YES) {
        NSInteger number = 5 * [self rand5] + [self rand5];
        // elimate (21, 22, 23, 24 25) % 7 -> 0, 1, 2, 3, 4 => balance the possibility
        if (number < 21) {
            return number % 7;
        }
    }
}

+ (NSInteger)rand5 {
    /**
     arc4random_uniform() will return a uniformly distributed random number less than upper_bound
     */
    return arc4random_uniform(5);
}

/**
 Design an algorithm to find all pairs of integers within an array which sum to a specified value.
 */

/**
 Simple Solution
 
 One easy and (time) efficient solution involves a hash map from integers to integers. 
 This algorithm works by iterating through the array. On each element x, look up sum - x in the hash table and, 
 if it exists, print (x, sum - x). Add x to the hash table, and go to the next element.
 
 Alternative Solution
 
 - Sort integers
 - if 'first' + 'last' < sum, then move 'first' forwards; elst, move 'last' backwards
 - if 'first' + 'last' == sum, move both 'first' and 'last'
 */

+ (NSSet<NSArray *> *)allPairsOfIntegers:(NSArray *)integers withSumOf:(NSInteger)sum {
    NSMutableSet<NSArray *> *pairs = [NSMutableSet set];
    [self findPairsFrom:integers sum:sum left:0 right:integers.count-1 pairs:pairs];
    return pairs;
}

// Drawback: many redundent recursions
+ (void)findPairsFrom:(NSArray *)integers sum:(NSInteger)sum left:(NSInteger)left right:(NSInteger)right pairs:(NSMutableSet<NSArray *> *)pairs {
    if (left >= right) {
        return;
    }
    NSInteger leftValue = [integers[left] integerValue];
    NSInteger rightValue = [integers[right] integerValue];
    if (leftValue + rightValue == sum) {
        [pairs addObject:@[@(MIN([integers[left] integerValue], [integers[right] integerValue])),
                           @(MAX([integers[left] integerValue], [integers[right] integerValue]))]];
    }
    [self findPairsFrom:integers sum:sum left:left+1 right:right pairs:pairs];
    [self findPairsFrom:integers sum:sum left:left right:right-1 pairs:pairs];
}

+ (NSSet *)hashFindPairsFrom:(NSArray *)integers sum:(NSInteger)sum {
    NSDictionary *hashTable = [NSDictionary dictionaryWithObjects:integers forKeys:integers];
    NSMutableSet<NSArray *> *pairs = [NSMutableSet set];
    for (NSInteger i=0; i<integers.count; i++) {
        if (hashTable[@(sum-[integers[i] integerValue])]) {
            [pairs addObject:@[@(MIN([integers[i] integerValue], [hashTable[@(sum-[integers[i] integerValue])] integerValue])),
                               @(MAX([integers[i] integerValue], [hashTable[@(sum-[integers[i] integerValue])] integerValue]))]];
        }
    }
    return pairs;
}

/**
 Consider a simple node-like data structure called BiNode, which has pointers to two other nodes.
 
 1  public class BiNode {
 2      public BiNode node1, node2;
 3      public int data;
 4  }
 The data structure BiNode could be used to represent both a binary tree (where node1 is the left node
 and node2 is the right node) or a doubly linked list (where node1 is the previous node and node2 is
 the next node). Implement a method to convert a binary search tree (implemented with BiNode) into a 
 doubly linked list. The values should be kept in order and the operation should be performed in place 
 (that is, on the original data structure).
 */

/**
 - post-order Depth First Search
 - not very efficient
 - Circle linked list solution: Page 463
 */

+ (BiNode *)binarySearchTreeToDoubleLinkedList:(BiNode *)root {
    if (!root) {
        return nil;
    }
    // search left subtree
    BiNode *left = [self binarySearchTreeToDoubleLinkedList:root.node1];
    BiNode *right = [self binarySearchTreeToDoubleLinkedList:root.node2];
    
    if (!left) {
        // at this moment, 'left' is already a double linked list
        [self concatNode:[self getTail:left] withNode:root];
    }
    
    if (!right) {
        [self concatNode:root withNode:right];
    }
    
    return left ? left : root;
}

+ (BiNode *)getTail:(BiNode *)node {
    if (!node) {
        return nil;
    }
    while (node.node2) {
        node = node.node2;
    }
    return node;
}

+ (void)concatNode:(BiNode *)node1 withNode:(BiNode *)node2 {
    node1.node2 = node2;
    node2.node1 = node1;
}

/**
 Oh,no! You have just completed a lengthy document when you have an unfortunate Find / Replace mishap.
 You have accidentally removed all spaces, punctuation, and capitalization in the document. A sentence 
 like "I reset the computer. It still didn't boot!" would become "iresetthecomputeritstilldidntboot".
 You figure that you can add back in the punctation and capitalization later, once you get the 
 individual words properly separated. Most of the words will be in a dictionary, but some strings, 
 like proper names, will not.
 
 Given a dictionary (a list of words), design an algorithm to find the optimal way of 
 "unconcatenating" a sequence of words. In this case, "optimal" is defined to be the parsing which 
 minimizes the number of unrecognized sequences of characters.
 
 For example, the string "jesslookedjustliketimherbrother" would be optimally parsed as 
 "JESS looked just like TIM her brother". This parsing has seven unrecognized characters, which we have
 capitalized for clarity
 */

/**
 Page 468
 */

+ (NSInteger)unconcatenatingSentence:(NSString *)sentence byDictionary:(NSArray<NSString *> *)words {
    NSDictionary *dictionary = [NSDictionary dictionaryWithObjects:words forKeys:words];
    NSMutableDictionary *cache = [NSMutableDictionary dictionary];
    return [self parse:sentence wordStart:0 wordEnd:0 dictionary:dictionary cache:cache];
}

+ (NSInteger)parse:(NSString *)sentence wordStart:(NSInteger)wordStart wordEnd:(NSInteger)wordEnd
        dictionary:(NSDictionary *)dictionary cache:(NSMutableDictionary *)cache {
    if (wordEnd >= sentence.length) {
        return wordEnd - wordStart;
    }
    
    if (cache[@(wordStart)]) {
        return [cache[@(wordStart)] integerValue];
    }
    
    NSString *currentWord = [sentence substringWithRange:NSMakeRange(wordStart, wordEnd-wordStart+1)];
    
    /**
     boolean validPartial = dictionary.contains(currentword, false);
     boolean validExact = validPartial && dictionary.contains(currentWord, true);
     */
    // break current word
    NSInteger bestExact = [self parse:sentence wordStart:wordEnd+1 wordEnd:wordEnd+1 dictionary:dictionary cache:cache];
    
    /**
     if (validExact) {
        bestExact.parsed = currentWord + " " + bestExact.parsed;
     } else {
        bestExact.invalid += currentWord.length();
        bestExact.parsed = currentWord.toUpperCase() + " " + bestExact.parsed;
     }
     */
    if (!dictionary[currentWord]) {
        bestExact += currentWord.length;
    }
    // if (validPartial) {
    NSInteger bestExtend = [self parse:sentence wordStart:wordStart wordEnd:wordEnd+1 dictionary:dictionary cache:cache];
    // }
    NSInteger min = MIN(bestExact, bestExtend);
    cache[@(wordStart)] = @(min);
    return min;
}

@end
