//
//  CrackingSortingAndSearchingTest.m
//  interview-algorithm-in-objc
//
//  Created by Bin Yu on 21/04/16.
//  Copyright © 2016 Bin Yu. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "RankingNumbers.h"
#import "CrackingSortingAndSearching.h"

@interface CrackingSortingAndSearchingTest : XCTestCase

@end

@implementation CrackingSortingAndSearchingTest

- (void)setUp {
    [super setUp];
}

- (void)tearDown {
    [super tearDown];
}

- (void)testCommonSortingAlgorithms {
    NSMutableArray *testIntegers = [@[@(4), @(1), @(2), @(9), @(0), @(8), @(7), @(3), @(5), @(320), @(32)] mutableCopy];
    NSArray *expectResult = @[@(0), @(1), @(2), @(3), @(4), @(5), @(7), @(8), @(9), @(32), @(320)];
    [CrackingSortingAndSearching bubbleSort:testIntegers];
    XCTAssertEqualObjects(testIntegers, expectResult);
    
    testIntegers = [@[@(4), @(1), @(2), @(9), @(0), @(8), @(7), @(3), @(5), @(320), @(32)] mutableCopy];
    [CrackingSortingAndSearching selectionSort:testIntegers];
    XCTAssertEqualObjects(testIntegers, expectResult);
    
    testIntegers = [@[@(4), @(1), @(2), @(9), @(0), @(8), @(7), @(3), @(5), @(320), @(32)] mutableCopy];
    [CrackingSortingAndSearching mergeSort:testIntegers];
    XCTAssertEqualObjects(testIntegers, expectResult);
    
    testIntegers = [@[@(4), @(1), @(2), @(9), @(0), @(8), @(7), @(3), @(5), @(320), @(32)] mutableCopy];
    [CrackingSortingAndSearching quickSort:testIntegers];
    XCTAssertEqualObjects(testIntegers, expectResult);
    
    testIntegers = [@[@(4), @(1), @(2), @(9), @(0), @(8), @(7), @(3), @(5), @(320), @(32)] mutableCopy];
    [CrackingSortingAndSearching radixSort:testIntegers];
    XCTAssertEqualObjects(testIntegers, expectResult);
    
    NSInteger expectIndex = 3;
    NSInteger actualIndex = [CrackingSortingAndSearching binarySearch:testIntegers value:3];
    XCTAssertEqual(expectIndex, actualIndex);
    
    expectIndex = -1;
    actualIndex = [CrackingSortingAndSearching binarySearch:testIntegers value:99];
    XCTAssertEqual(expectIndex, actualIndex);
}


- (void)testMergeArrayBintoArrayA {
    NSMutableArray *testArrayA = [@[@(0), @(3), @(20), @(25), @(45), @(77), @(99),
                            [NSNull null], [NSNull null], [NSNull null], [NSNull null], [NSNull null], [NSNull null]] mutableCopy];
    NSArray *testArrayB = @[@(5), @(22), @(46), @(90)];
    [CrackingSortingAndSearching mergeArrayB:testArrayB intoArrayA:testArrayA];
    NSArray *expectArrayA = @[@(0), @(3), @(5), @(20), @(22), @(25), @(45), @(46), @(77), @(90), @(99), [NSNull null], [NSNull null]];
    XCTAssertEqualObjects(testArrayA, expectArrayA);
    
    testArrayA = [@[@(3), @(6), @(20), @(25), @(45), @(77), @(99),
                    [NSNull null], [NSNull null], [NSNull null], [NSNull null], [NSNull null], [NSNull null]] mutableCopy];
    testArrayB = @[@(0), @(1), @(2)];
    [CrackingSortingAndSearching mergeArrayB:testArrayB intoArrayA:testArrayA];
    expectArrayA = @[@(0), @(1), @(2), @(3), @(6), @(20), @(25), @(45), @(77), @(99), [NSNull null], [NSNull null], [NSNull null]];
    XCTAssertEqualObjects(testArrayA, expectArrayA);
}

- (void)testSortAnagramArray {
    NSMutableArray *testAnagramArray = [@[@"abc", @"123", @"efg", @"231", @"bac", @"fge", @"zze", @"bca", @"ezz"] mutableCopy];
    [CrackingSortingAndSearching sortAnagramArray:testAnagramArray];
    NSArray *expectArray = @[@"abc", @"bac", @"bca", @"231", @"123", @"fge", @"efg", @"zze", @"ezz"];
    XCTAssertEqualObjects(testAnagramArray, expectArray);
    
    testAnagramArray = [@[@"abc", @"123", @"efg", @"231", @"bac", @"fge", @"zze", @"bca", @"ezz"] mutableCopy];
    [CrackingSortingAndSearching hashSortAnagramArray:testAnagramArray];
    expectArray = @[@"123", @"231", @"abc", @"bac", @"bca", @"efg", @"fge", @"zze", @"ezz"];
    XCTAssertEqualObjects(testAnagramArray, expectArray);
}

- (void)testIndexOfNumberInRotatedSortedArray {
    NSArray *testIntegers = @[@(15), @(16), @(19), @(20), @(25), @(1), @(3), @(4), @(5), @(7), @(10), @(14)];
    NSInteger testNumber = 5;
    NSInteger expectResult = 8;
    NSInteger actualResult = [CrackingSortingAndSearching indexOfNumber:testNumber inRotatedSortedArray:testIntegers];
    XCTAssertEqual(expectResult, actualResult);

    testNumber = 1;
    expectResult = 5;
    actualResult = [CrackingSortingAndSearching indexOfNumber:testNumber inRotatedSortedArray:testIntegers];
    XCTAssertEqual(expectResult, actualResult);
    actualResult = [CrackingSortingAndSearching anotherIndexOfNumber:testNumber inRotatedSortedArray:testIntegers];
    XCTAssertEqual(expectResult, actualResult);
    
    testNumber = 14;
    expectResult = 11;
    actualResult = [CrackingSortingAndSearching indexOfNumber:testNumber inRotatedSortedArray:testIntegers];
    XCTAssertEqual(expectResult, actualResult);
    actualResult = [CrackingSortingAndSearching anotherIndexOfNumber:testNumber inRotatedSortedArray:testIntegers];
    XCTAssertEqual(expectResult, actualResult);
    
    testIntegers = @[@(14), @(14), @(19), @(20), @(25), @(1), @(3), @(4), @(5), @(7), @(10), @(14)];
    testNumber = 14;
    expectResult = 11;
    actualResult = [CrackingSortingAndSearching indexOfNumber:testNumber inRotatedSortedArray:testIntegers];
    XCTAssertEqual(expectResult, actualResult);
    actualResult = [CrackingSortingAndSearching anotherIndexOfNumber:testNumber inRotatedSortedArray:testIntegers];
    XCTAssertEqual(expectResult, actualResult);
    
    testIntegers = @[@(14), @(14), @(19), @(20), @(25), @(1), @(3), @(4), @(5), @(7), @(10), @(14)];
    testNumber = 14;
    expectResult = 11;
    actualResult = [CrackingSortingAndSearching anotherIndexOfNumber:testNumber inRotatedSortedArray:testIntegers];
    XCTAssertEqual(expectResult, actualResult);
    
    testIntegers = @[@(13), @(14), @(14), @(14), @(25), @(1), @(3), @(4), @(5), @(7), @(10), @(12)];
    testNumber = 14;
    expectResult = 2;
    actualResult = [CrackingSortingAndSearching anotherIndexOfNumber:testNumber inRotatedSortedArray:testIntegers];
    XCTAssertEqual(expectResult, actualResult);
}

- (void)testLocationStringInSortedArrayWithEmptyStrings {
    NSArray *testStrings = @[@"at", @"", @"", @"", @"ball", @"", @"", @"car", @"", @"", @"dad", @"", @""];
    NSString *testString = @"ball";
    NSInteger expectResult = 4;
    NSInteger actualResult = [CrackingSortingAndSearching locationOfString:testString inSortedArrayWithEmptyStrings:testStrings];
    XCTAssertEqual(expectResult, actualResult);
    
    testString = @"car";
    expectResult = 7;
    actualResult = [CrackingSortingAndSearching locationOfString:testString inSortedArrayWithEmptyStrings:testStrings];
    XCTAssertEqual(expectResult, actualResult);
    
    testString = @"";
    expectResult = -1;
    actualResult = [CrackingSortingAndSearching locationOfString:testString inSortedArrayWithEmptyStrings:testStrings];
    XCTAssertEqual(expectResult, actualResult);
}

- (void)testFindValueInMatrix {
    NSArray *testMatrix = @[@[@(15), @(20), @(40), @(85)],
                            @[@(20), @(35), @(80), @(95)],
                            @[@(30), @(55), @(95), @(105)],
                            @[@(40), @(80), @(100), @(120)]];
    NSInteger testNumber = 55;
    XCTAssertTrue([CrackingSortingAndSearching findValue:testNumber inMatrix:testMatrix]);
    testNumber = 56;
    XCTAssertFalse([CrackingSortingAndSearching findValue:testNumber inMatrix:testMatrix]);
}

- (void)testLongestPossibleSequenceOfPeopleInTower {
    // (65, 100) (70, 150) (56, 90) (75, 190) (60, 95) (68, 110)
    NSArray *testPeople = @[[NSValue valueWithCGPoint:CGPointMake(65, 100)],
                            [NSValue valueWithCGPoint:CGPointMake(70, 150)],
                            [NSValue valueWithCGPoint:CGPointMake(56, 90)],
                            [NSValue valueWithCGPoint:CGPointMake(75, 190)],
                            [NSValue valueWithCGPoint:CGPointMake(60, 95)],
                            [NSValue valueWithCGPoint:CGPointMake(68, 110)]];
    // (56, 90) (60, 95) (65, 100) (68, 110) (70, 150) (75, 190)
    NSArray *expectResult = @[[NSValue valueWithCGPoint:CGPointMake(56, 90)],
                              [NSValue valueWithCGPoint:CGPointMake(60, 95)],
                              [NSValue valueWithCGPoint:CGPointMake(65, 100)],
                              [NSValue valueWithCGPoint:CGPointMake(68, 110)],
                              [NSValue valueWithCGPoint:CGPointMake(70, 150)],
                              [NSValue valueWithCGPoint:CGPointMake(75, 190)]];
    NSArray *actualResult = [CrackingSortingAndSearching longestPossibleSequenceOfPeopleInTower:testPeople];
    XCTAssertEqualObjects(actualResult, expectResult);
    
    testPeople = @[[NSValue valueWithCGPoint:CGPointMake(65, 100)],
                   [NSValue valueWithCGPoint:CGPointMake(70, 150)],
                   [NSValue valueWithCGPoint:CGPointMake(99, 90)],
                   [NSValue valueWithCGPoint:CGPointMake(75, 190)],
                   [NSValue valueWithCGPoint:CGPointMake(60, 95)],
                   [NSValue valueWithCGPoint:CGPointMake(68, 110)]];
    // (56, 90) (60, 95) (65, 100) (68, 110) (70, 150) (75, 190)
    expectResult = @[[NSValue valueWithCGPoint:CGPointMake(60, 95)],
                     [NSValue valueWithCGPoint:CGPointMake(65, 100)],
                     [NSValue valueWithCGPoint:CGPointMake(68, 110)],
                     [NSValue valueWithCGPoint:CGPointMake(70, 150)],
                     [NSValue valueWithCGPoint:CGPointMake(75, 190)]];
    actualResult = [CrackingSortingAndSearching longestPossibleSequenceOfPeopleInTower:testPeople];
    XCTAssertEqualObjects(actualResult, expectResult);
}

- (void)testRankingNumbers {
    NSArray *testNumbers = @[@(5), @(1), @(4), @(4), @(5), @(9), @(7), @(13), @(3)];
    RankingNumbers *rankingNumbers = [RankingNumbers new];
    for (NSInteger i=0; i<testNumbers.count; i++) {
        [rankingNumbers track:[testNumbers[i] integerValue]];
    }
    
    NSInteger testNumber = 4;
    NSInteger expectResult = 3;
    NSInteger actualResult = [rankingNumbers rankOfNumber:testNumber];
    XCTAssertEqual(expectResult, actualResult);
    
    testNumber = 5;
    expectResult = 5;
    actualResult = [rankingNumbers rankOfNumber:testNumber];
    XCTAssertEqual(expectResult, actualResult);
    
    testNumber = 9;
    expectResult = 7;
    actualResult = [rankingNumbers rankOfNumber:testNumber];
    XCTAssertEqual(expectResult, actualResult);
}

@end
