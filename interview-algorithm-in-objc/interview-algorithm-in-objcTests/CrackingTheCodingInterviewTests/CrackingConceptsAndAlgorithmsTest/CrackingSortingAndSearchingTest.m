//
//  CrackingSortingAndSearchingTest.m
//  interview-algorithm-in-objc
//
//  Created by Bin Yu on 21/04/16.
//  Copyright © 2016 Bin Yu. All rights reserved.
//

#import <XCTest/XCTest.h>
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

@end
