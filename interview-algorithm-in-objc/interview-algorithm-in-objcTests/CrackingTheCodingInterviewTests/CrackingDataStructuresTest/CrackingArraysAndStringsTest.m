//
//  CrackingArraysAndStringsTest.m
//  interview-algorithm-in-objc
//
//  Created by Bin Yu on 23/03/16.
//  Copyright © 2016 Bin Yu. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "CrackingArraysAndStrings.h"

@interface CrackingArraysAndStringsTest : XCTestCase

@end

@implementation CrackingArraysAndStringsTest

- (void)setUp {
    [super setUp];
}

- (void)tearDown {
    [super tearDown];
}

#pragma mark - Array And Strings

/**
 Implement an algorithm to determine if a string has all unique characters.
 What if you cannot use additional data structures?
 */
- (void)testStringHasAllUniqueCharacters {
    NSString *testString = @"abcd";
    XCTAssertTrue([CrackingArraysAndStrings stringHasAllUniqueCharacters:testString]);
    
    testString = @"abcdaabc";
    XCTAssertFalse([CrackingArraysAndStrings stringHasAllUniqueCharacters:testString]);
    
    testString = @"";
    XCTAssertFalse([CrackingArraysAndStrings stringHasAllUniqueCharacters:testString]);
    
    testString = nil;
    XCTAssertFalse([CrackingArraysAndStrings stringHasAllUniqueCharacters:testString]);
    
    testString = @"aaabbbcccddd";
    XCTAssertFalse([CrackingArraysAndStrings stringHasAllUniqueCharacters:testString]);
}

- (void)testStringHasAllUniqueCharactersBetter {
    NSString *testString = @"abcdABCD1234";
    XCTAssertTrue([CrackingArraysAndStrings stringHasAllUniqueCharactersBetter:testString]);
    
    testString = @"abcdaabc";
    XCTAssertFalse([CrackingArraysAndStrings stringHasAllUniqueCharactersBetter:testString]);
    
    testString = @"";
    XCTAssertFalse([CrackingArraysAndStrings stringHasAllUniqueCharactersBetter:testString]);
    
    testString = nil;
    XCTAssertFalse([CrackingArraysAndStrings stringHasAllUniqueCharactersBetter:testString]);
    
    testString = @"aaabbbAAcccddd";
    XCTAssertFalse([CrackingArraysAndStrings stringHasAllUniqueCharactersBetter:testString]);
}

- (void)testReverseString {
    /**
     http://stackoverflow.com/questions/1011455/is-it-possible-to-modify-a-string-of-char-in-c
     */
    char normalStr[] = "abcdef";
    [CrackingArraysAndStrings reverse:normalStr];
    XCTAssertEqualObjects([NSString stringWithUTF8String:normalStr], @"fedcba");
    
    char *nullStr = NULL;
    [CrackingArraysAndStrings reverse:nullStr];

    char oneCharStr[] = "1";
    [CrackingArraysAndStrings reverse:oneCharStr];
    XCTAssertEqualObjects([NSString stringWithUTF8String:oneCharStr], @"1");
    
    char oddCountStr[] = "a12";
    [CrackingArraysAndStrings reverse:oddCountStr];
    XCTAssertEqualObjects([NSString stringWithUTF8String:oddCountStr], @"21a");
}

- (void)testStringPermutation {
    [self doTestStringPermutation:^BOOL(NSString *permutationString, NSString *normalString) {
        return [CrackingArraysAndStrings string:permutationString isPermutationOfString:normalString];
    }];
}

- (void)testSimpleStringPermutation {
    [self doTestStringPermutation:^BOOL(NSString *permutationString, NSString *normalString) {
        return [CrackingArraysAndStrings simpleString:permutationString isPermutationOfString:normalString];
    }];

}

- (void)testCountedStringPermutation {
    [self doTestStringPermutation:^BOOL(NSString *permutationString, NSString *normalString) {
        return [CrackingArraysAndStrings countedString:permutationString isPermutationOfString:normalString];
    }];
}

- (void)testEscapeSpacesInString {
    char theString[50] = "Mr John Smith";
    [CrackingArraysAndStrings escapeSpacesInString:theString withLength:strlen(theString)];
    XCTAssertEqualObjects([NSString stringWithCString:theString encoding:NSASCIIStringEncoding],
                          @"Mr%20John%20Smith");
    
    char fullSpaceString[50] = "      ";
    [CrackingArraysAndStrings escapeSpacesInString:fullSpaceString withLength:strlen(fullSpaceString)];
    XCTAssertEqualObjects([NSString stringWithCString:fullSpaceString encoding:NSASCIIStringEncoding],
                          @"%20%20%20%20%20%20");
    
    char pendSpaceString[50] = "   My name is Bin   ";
    [CrackingArraysAndStrings escapeSpacesInString:pendSpaceString withLength:strlen(pendSpaceString)];
    XCTAssertEqualObjects([NSString stringWithCString:pendSpaceString encoding:NSASCIIStringEncoding],
                          @"%20%20%20My%20name%20is%20Bin%20%20%20");
    
    char emptyString[50] = "";
    [CrackingArraysAndStrings escapeSpacesInString:emptyString withLength:strlen(emptyString)];
    XCTAssertEqualObjects([NSString stringWithCString:emptyString encoding:NSASCIIStringEncoding],
                          @"");
}

- (void)testCompressString {
    char *normalString = "aabcccccaaa";
    XCTAssertEqualObjects([NSString stringWithCString:[CrackingArraysAndStrings compressString:normalString]
                                             encoding:NSASCIIStringEncoding],
                          @"a2b1c5a3");
    
    normalString = "aabcccccaaaf";
    XCTAssertEqualObjects([NSString stringWithCString:[CrackingArraysAndStrings compressString:normalString]
                                             encoding:NSASCIIStringEncoding],
                          @"a2b1c5a3f1");
    
    normalString = "abcde";
    XCTAssertEqualObjects([NSString stringWithCString:[CrackingArraysAndStrings compressString:normalString]
                                             encoding:NSASCIIStringEncoding],
                          @"abcde");
    
    normalString = "aab";
    XCTAssertEqualObjects([NSString stringWithCString:[CrackingArraysAndStrings compressString:normalString]
                                             encoding:NSASCIIStringEncoding],
                          @"aab");
    
    normalString = "aaaaaaaaaallllllllllllooonnnnggggss";
    XCTAssertEqualObjects([NSString stringWithCString:[CrackingArraysAndStrings compressString:normalString]
                                             encoding:NSASCIIStringEncoding],
                          @"a10l12o3n4g4s2");
}

- (void)testRotateImageMatrix {
    int **normalMatrix = [self createMatrixWithM:3 andN:3];
    [self printMatrix:normalMatrix withM:3 andN:3];
    
    [CrackingArraysAndStrings rotateImageMatrix:normalMatrix withN:3];
    NSArray *resultArray = @[@(7), @(4), @(1),
                             @(8), @(5), @(2),
                             @(9), @(6), @(3)];
    XCTAssertEqualObjects([self matrixToArray:normalMatrix withM:3 andN:3], resultArray);
    
    int **singleMatrix = [self createMatrixWithM:1 andN:1];
    [self printMatrix:singleMatrix withM:1 andN:1];
    
    [CrackingArraysAndStrings rotateImageMatrix:singleMatrix withN:1];
    resultArray = @[@(1)];
    XCTAssertEqualObjects([self matrixToArray:singleMatrix withM:1 andN:1], resultArray);
    
    int **doubleMatrix = [self createMatrixWithM:2 andN:2];
    [self printMatrix:doubleMatrix withM:2 andN:2];
    
    [CrackingArraysAndStrings rotateImageMatrix:doubleMatrix withN:2];
    resultArray = @[@(3), @(1),
                    @(4), @(2)];
    XCTAssertEqualObjects([self matrixToArray:doubleMatrix withM:2 andN:2], resultArray);
}

- (void)testSetMatrixZeros {
    int **normalMatrix = [self createMatrixWithM:4 andN:5];
    normalMatrix[1][2] = 0;
    normalMatrix[1][4] = 0;
    normalMatrix[3][0] = 0;
    [self printMatrix:normalMatrix withM:4 andN:5];
    [CrackingArraysAndStrings setRelativeRowAndColumnOfMatrix:normalMatrix toZeroWithRow:4 andColumn:5];
    NSArray *resultArray = @[@(0),  @(2),  @(0),  @(4),  @(0),
                             @(0),  @(0),  @(0),  @(0),  @(0),
                             @(0), @(12), @(0),  @(14), @(0),
                             @(0),  @(0),  @(0),  @(0),  @(0)];
    [self printMatrix:normalMatrix withM:4 andN:5];
    XCTAssertEqualObjects([self matrixToArray:normalMatrix withM:4 andN:5], resultArray);
}

- (void)testStringRotation {
    NSString *normalString = @"this is a test string";
    NSString *rotationString = @" a test stringthis is";
    XCTAssertTrue([CrackingArraysAndStrings isString:rotationString rotationOfString:normalString]);
    
    rotationString = @" a test stringthis iA";
    XCTAssertFalse([CrackingArraysAndStrings isString:rotationString rotationOfString:normalString]);
    
    rotationString = @" a test stri";
    XCTAssertFalse([CrackingArraysAndStrings isString:rotationString rotationOfString:normalString]);
    
    rotationString = nil;
    XCTAssertFalse([CrackingArraysAndStrings isString:rotationString rotationOfString:normalString]);
}

#pragma mark - Private

- (void)doTestStringPermutation:(BOOL(^)(NSString *, NSString *))permutationMethod {
    XCTAssertTrue(permutationMethod);
    
    NSString *normalString = @"abcd1234";
    NSString *permutationString = @"a34bc21d";
    XCTAssertTrue(permutationMethod(permutationString, normalString));
    
    permutationString = @"34bc21";
    XCTAssertFalse(permutationMethod(permutationString, normalString));
    
    permutationString = @"a34bc228";
    XCTAssertFalse(permutationMethod(permutationString, normalString));
    
    permutationString = nil;
    XCTAssertFalse(permutationMethod(permutationString, normalString));
    
    normalString = @"aabBccdd";
    permutationString = @"abaBdccd";
    XCTAssertTrue(permutationMethod(permutationString, normalString));
    
    permutationString = @"ababdccd";
    XCTAssertFalse(permutationMethod(permutationString, normalString));
}

- (int **)createMatrixWithM:(int)M andN:(int)N {
    if (N<=0) {
        return NULL;
    }
    int counter = 1;
    int **matrix = (int **)malloc(sizeof(int *) * N);
    for (int i=0; i<M; i++) {
        matrix[i] = (int *)malloc(sizeof(int) * N);
        for (int c=0; c<N; c++) {
            matrix[i][c] = counter++;
        }
    }
    return matrix;
}

- (void)printMatrix:(int **)matrix withM:(int)M andN:(int)N {
    for (int i=0; i<M; i++) {
        for (int j=0; j<N; j++) {
            printf("%d ", matrix[i][j]);
        }
        printf("\n");
    }
}

- (NSArray *)matrixToArray:(int **)matrix withM:(int)M andN:(int)N{
    NSMutableArray *array = [NSMutableArray array];
    for (int i=0; i<M; i++) {
        for (int j=0; j<N; j++) {
            [array addObject:@(matrix[i][j])];
        }
    }
    return array;
}

@end
