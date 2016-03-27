//
//  CrackingDataStructures.m
//  interview-algorithm-in-objc
//
//  Created by Bin Yu on 23/03/16.
//  Copyright © 2016 Bin Yu. All rights reserved.
//

#import "CrackingDataStructures.h"

@implementation CrackingDataStructures


#pragma mark - Array And Strings

/**
 Implement an algorithm to determine if a string has all unique characters. 
 What if you cannot use additional data structures?
 
 Narrow the scope:
 - assume character set is ASCII
 - assume lower case only
 */
+ (BOOL)stringHasAllUniqueCharacters:(NSString *)theString {
    if (!theString || ![theString length]) {
        return NO;
    }
    if ([theString length] > 256) {
        return NO;
    }
    /** 
     - for C string, there is '\0' at the end
     https://www.objc.io/issues/9-strings/unicode/
     - unichar is UTF-16 => unsigned short = 2 x char
     - UTF-8
     */
    const char *cString = [theString cStringUsingEncoding:NSASCIIStringEncoding];
    NSUInteger checker = 0;
    for (NSUInteger idx=0; idx<strlen(cString); idx++) {
        char character = cString[idx];
        NSUInteger val = character - 'a';
        if (checker && (checker & (1 << val))) {
            return NO;
        }
        checker |= (1 << val);
    }
    return YES;
}

+ (BOOL)stringHasAllUniqueCharactersBetter:(NSString *)theString {
    if (!theString || ![theString length]) {
        return NO;
    }
    NSCountedSet *characterCounter = [NSCountedSet set];
    for (NSUInteger idx=0; idx<[theString length]; idx++) {
        unichar character = [theString characterAtIndex:idx];
        if ([characterCounter countForObject:@(character)]) {
            return NO;
        }
        [characterCounter addObject:@(character)];
    }
    return YES;
}

/**
 Implement a function void reverse(char* str) in C or C++ which reverses a null- terminated string.
 */

+ (void)reverse:(char *)str {
    // check NULL pointer
    if (!str) {
        return;
    }
    // no reversing needed for empty string or string with single character
    int len = strlen(str);
    if (len <= 1) {
        return;
    }
    int count = len / 2;
    for (int idx=0; idx<count; idx++) {
        char tmp = str[idx];
        str[idx] = str[len-1-idx];
        str[len-1-idx] = tmp;
    }
}

+ (void)reverseBetter:(char *)str {
    char *end =str;
    char tmp;
    if (str){
        while (*end) {
            // find end of the string
            ++end;
        }
        // set one char back, since last char is null
        --end;
        /* 
         swap characters from start of string with the end of the * string,
         until the pointers meet in middle. 
         */
        while (str < end) {
            tmp = *str;
            *str++ = *end;
            *end-- =tmp;
        }
    }
}

/**
 Given two strings, write a method to decide if one is a permutation of the other.
 */

+ (BOOL)string:(NSString *)permutationString isPermutationOfString:(NSString *)theString {
    if (!permutationString || !theString || permutationString.length != theString.length) {
        return NO;
    }
    
    NSUInteger theSum = 0;
    NSUInteger permutationSum = 0;
    
    for (NSUInteger idx=0; idx<theString.length; idx++) {
        theSum += [theString characterAtIndex:idx];
        permutationSum += [permutationString characterAtIndex:idx];
    }
    
    return theSum == permutationSum;
}

+ (BOOL)simpleString:(NSString *)permutationString isPermutationOfString:(NSString *)theString {
    if (!permutationString || !theString || permutationString.length != theString.length) {
        return NO;
    }
    NSString *sortedTheString = [self stringSortedFrom:theString];
    NSString *sortedPermutationString = [self stringSortedFrom:permutationString];
    return [sortedTheString isEqualToString:sortedPermutationString];
}

+ (NSString *)stringSortedFrom:(NSString *)theString {
    unichar characters[theString.length+1];
    [theString getCharacters:characters];
    NSMutableArray *characterArray = [NSMutableArray array];
    for (NSUInteger idx=0; idx<theString.length; idx++) {
        [characterArray addObject:@(characters[idx])];
    }
    [characterArray sortUsingComparator:^NSComparisonResult(NSNumber *obj1, NSNumber *obj2) {
        return [obj1 compare:obj2];
    }];
    for (NSUInteger idx=0; idx<theString.length; idx++) {
        characters[idx] = [characterArray[idx] unsignedShortValue];
    }
    return [NSString stringWithCharacters:characters length:theString.length];
}

/**
 - In your interview, you should always check with your interviewer about the size of the character set.
 - We can assume the character set to be ASCII (256 characters)
 - Or we can make general solution as following if possible
 */
+ (BOOL)countedString:(NSString *)permutationString isPermutationOfString:(NSString *)theString {
    if (!permutationString || !theString || permutationString.length != theString.length) {
        return NO;
    }
    NSCountedSet *counter = [NSCountedSet set];
    for (NSUInteger idx=0; idx<theString.length; idx++) {
        [counter addObject:@([theString characterAtIndex:idx])];
    }
    for (NSUInteger idx=0; idx<permutationString.length; idx++) {
        NSNumber *characterObject = @([permutationString characterAtIndex:idx]);
        if (![counter countForObject:characterObject]) {
            return NO;
        }
        [counter removeObject:characterObject];
    }
    return YES;
}

/**
 Write a method to replace all spaces in a string with'%20'. 
 You may assume that the string has sufficient space at the end of the string to 
 hold the additional characters, and that you are given the "true" length of the string. 
 (Note: if implementing in Java, please use a character array so that you can perform this operation in place.)
 
 EXAMPLE:
 Input: "Mr John Smith"
 Output: "Mr%20John%20Smith"
 */

/**
 - In the first scan, we count how many spaces there are in the string. 
 This is used to compute how long the final string should be.
 - In the second pass, which is done in reverse order, we actually edit the string. 
 When we see a space, we copy %20 into the next spots. If there is no space, then we 
 copy the original character.
 */

+ (void)escapeSpacesInString:(char *)theString withLength:(int)length {
    int spaceCounter = 0;
    char *endPtr = theString;
    char *escapedEndPtr = NULL;
    char *spaceEscapeCharacters = "%20";
    char spaceCharacter = ' ';
    
    if (!theString) {
        return;
    }
    // get amount of space characters in string
    while (*endPtr) {
        if (*endPtr == spaceCharacter) {
            spaceCounter++;
        }
        endPtr++;
    }
    // calculate new string length
    int escapedLength = length + spaceCounter * 2;
    /**
     - move characters from backward; insert escape characters
     - including '\0'
     */
    
    escapedEndPtr = theString + escapedLength;
    while (endPtr >= theString) {
        if (*endPtr != spaceCharacter) {
            *escapedEndPtr = *endPtr;
        } else {
            *escapedEndPtr-- = spaceEscapeCharacters[2];
            *escapedEndPtr-- = spaceEscapeCharacters[1];
            *escapedEndPtr = spaceEscapeCharacters[0];
        }
        endPtr--;
        escapedEndPtr--;
    }
}

/**
 Implement a method to perform basic string compression using the counts of repeated characters.
 For example, the string aabcccccaaa would become a2b1c5a3. 
 If the "compressed" string would not become smaller than the original string, 
 your method should return the original string.
 */

+ (char *)compressString:(char *)theString {
    if (!theString || !strlen(theString)) {
        return NULL;
    }
    int compressedCount = [self compressedCountOfString:theString];
    if (strlen(theString) <= compressedCount) {
        return theString;
    }
    /**
     create string on heap
     WARNING: remember to +1 for '\0' character in c string.
     */
    char *compressedString = (char *)malloc(sizeof(char) * compressedCount + 1);
    memset(compressedString, 0, sizeof(char) * compressedCount + 1);
    
    char *headPtr = theString;
    char *compressedHeadPtr = compressedString;
    
    char currentChar = *headPtr;
    int count=0;
    
    while (*headPtr) {
        if (currentChar == *headPtr) {
            count++;
        } else {
            [self setCharacter:currentChar andCount:count inCompressedString:&compressedHeadPtr];
            currentChar = *headPtr;
            count = 1;
        }
        headPtr++;
    }
    [self setCharacter:currentChar andCount:count inCompressedString:&compressedHeadPtr];
    return compressedString;
}

+ (void)setCharacter:(char)character andCount:(int)count inCompressedString:(char **)compressedString {
    char *compressedHeadPtr = *compressedString;
    *compressedHeadPtr++ = character;
    char *intChar = [self intToStr:count];
    while (*intChar) {
        *compressedHeadPtr++ = *intChar++;
    }
    *compressedString = compressedHeadPtr;
}

+ (int)compressedCountOfString:(char *)theString {
    if (!theString || !strlen(theString)) {
        return 0;
    }
    int compressedLength = 0;
    int count = 0;
    char *headPtr = theString;
    char lastChar = headPtr[0];
    while (*headPtr) {
        if (lastChar == *headPtr) {
            count++;
        } else {
            compressedLength += 1 + [self countOfNumber:count];
            count = 1;
            lastChar = *headPtr;
        }
        headPtr++;
    }
    compressedLength += 1 + [self countOfNumber:count];
    return compressedLength;
}

+ (char *)intToStr:(int)i {
    char *ch = (char *)malloc(sizeof(char) * 20);
    memset(ch, 0, sizeof(char)*20);
    sprintf(ch, "%d", i);
    return ch;
}

+ (int)countOfNumber:(int)number {
    return strlen([self intToStr:number]);
}

/**
 Given an image represented by an NxN matrix, where each pixel in the image is 4 bytes, 
 write a method to rotate the image by 90 degrees. Can you do this in place?
 */

+ (void)rotateImageMatrix:(int **)imageMatrix withN:(int)N {
    if (!imageMatrix || N <= 1) {
        return;
    }
    for (int layerIdx=0; layerIdx<N/2; layerIdx++) {
        /**
         int topRow = layerIdx;
         int rightCol = N-layerIdx-1;
         int bottomRow = N-layerIdx-1;
         int leftCol = layerIdx;
         // rotate top and right
         for (int i=0; i<N-1; i++) {
            [self swipeA:imageMatrix[topRow]+i andB:imageMatrix[i]+rightCol];
            [self swipeA:imageMatrix[topRow]+i andB:imageMatrix[bottomRow]+N-1-i];
            [self swipeA:imageMatrix[topRow]+i andB:imageMatrix[N-i-1]+leftCol];
         }
         */
        int first = layerIdx;
        int last = N - layerIdx - 1;
        for (int i=first; i<last; i++) {
            int offset = i - first;
            int top = imageMatrix[first][i];
            imageMatrix[first][i] = imageMatrix[last - offset][first];
            imageMatrix[last-offset][first] = imageMatrix[last][last-offset];
            imageMatrix[last][last-offset] = imageMatrix[i][last];
            imageMatrix[i][last] = top;
        }
    }
}

+ (void)swipeA:(int *)a andB:(int *)b {
    int tmp = *a;
    *a = *b;
    *b = tmp;
}

/**
 Write an algorithm such that if an element in an MxN matrix is 0, 
 its entire row and column are set to 0.
 */

+ (void)setRelativeRowAndColumnOfMatrix:(int **)matrix toZeroWithRow:(int)M andColumn:(int)N {
    if (!matrix || !M || !N) {
        return;
    }
    /**
     To make this somewhat more space efficient, 
     we could use a bit vector instead of a boolean array.
     */
    bool *zeroRows = (bool *)malloc(sizeof(bool) * M);
    bool *zeroColumns = (bool *)malloc(sizeof(bool) * N);
    memset(zeroRows, 0, sizeof(bool) * M);
    memset(zeroColumns, 0, sizeof(bool) * N);
    // scan the matrix
    for (int row=0; row<M; row++) {
        for (int col=0; col<N; col++) {
            if (!matrix[row][col]) {
                zeroRows[row] = true;
                zeroColumns[col] = true;
            }
        }
    }
    // set row to zero
    for (int row=0; row<M; row++) {
        for (int col=0; col<N; col++) {
            if (zeroRows[row] || zeroColumns[col]) {
                matrix[row][col] = 0;
            }
        }
    }
}

/**
 Assume you have a method isSubstring which checks if one word is a substring of another. 
 Given two strings, s1 and s2, write code to check if s2 is a rotation of s1 using only
 one call to isSubstring (e.g.,"waterbottle"is a rotation of "erbottlewat").
 */

+ (BOOL)isString:(NSString *)thisString rotationOfString:(NSString *)thatString {
    /**
     - ask rotation point
     - xy -> yx
     - yx is ALWAYS substring of xyxy
     - S2 is ALWAYS substring of S1S1
     */
    if (!thisString || !thatString || (thisString.length != thatString.length)) {
        return NO;
    }
    NSString *doubleThatString = [thatString stringByAppendingString:thatString];
    return [doubleThatString containsString:thisString];
}

@end
