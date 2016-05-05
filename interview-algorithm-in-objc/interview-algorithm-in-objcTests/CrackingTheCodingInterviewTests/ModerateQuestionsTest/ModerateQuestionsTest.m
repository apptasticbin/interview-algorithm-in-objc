//
//  ModerateQuestionsTest.m
//  interview-algorithm-in-objc
//
//  Created by Bin Yu on 02/05/16.
//  Copyright © 2016 Bin Yu. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "ModerateQuestions.h"

@interface ModerateQuestionsTest : XCTestCase

@end

@implementation ModerateQuestionsTest

- (void)setUp {
    [super setUp];
}

- (void)tearDown {
    [super tearDown];
}

- (void)testSwapNumbersWithoutExtraVariables {
    NSInteger testNumber1 = 4;
    NSInteger testNumber2 = 1;
    
    [ModerateQuestions swapA:&testNumber1 b:&testNumber2];
    XCTAssertEqual(testNumber1, 1);
    XCTAssertEqual(testNumber2, 4);
    
    [ModerateQuestions bitOperationSwapA:&testNumber1 b:&testNumber2];
    XCTAssertEqual(testNumber1, 4);
    XCTAssertEqual(testNumber2, 1);
    
    testNumber1 = 4;
    testNumber2 = -99;
    
    [ModerateQuestions swapA:&testNumber1 b:&testNumber2];
    XCTAssertEqual(testNumber1, -99);
    XCTAssertEqual(testNumber2, 4);
    
    [ModerateQuestions bitOperationSwapA:&testNumber1 b:&testNumber2];
    XCTAssertEqual(testNumber1, 4);
    XCTAssertEqual(testNumber2, -99);
}

- (void)testCheckWonOfNxNTicTacToe {
    NSArray<NSArray *> *testBoard = @[
                                      @[[NSNull null], @(1), @(2)],
                                      @[@(2)         , @(1), @(1)],
                                      @[[NSNull null], @(1), @(2)]
                                      ];
    NSNumber *actualResult = [ModerateQuestions checkWonOfNxNTicTacToe:testBoard];
    NSNumber *expectResult = @(1);
    XCTAssertEqualObjects(actualResult, expectResult);
    
    testBoard = @[
                  @[[NSNull null], @(1), @(2)],
                  @[@(2)         , @(2), @(1)],
                  @[[NSNull null], @(1), @(2)]
                  ];
    actualResult = [ModerateQuestions checkWonOfNxNTicTacToe:testBoard];
    expectResult = nil;
    XCTAssertEqualObjects(actualResult, expectResult);
}

- (void)testTrailingZerosInNFactorial {
    NSInteger testN = 10;
    NSInteger expectResult = 2;
    NSInteger actualResult = [ModerateQuestions trailingZerosInNFactorial:testN];
    XCTAssertEqual(actualResult, expectResult);
    actualResult = [ModerateQuestions trailingZerosInNFactorial:testN];
    XCTAssertEqual(actualResult, expectResult);
    
    testN = 30;
    expectResult = 7;
    actualResult = [ModerateQuestions betterTrailingZerosInNFractorial:testN];
    XCTAssertEqual(actualResult, expectResult);
}

- (void)testNumberOfHisAndPseudoHitsOfGuess {
    NSArray *testSolution = @[@"R", @"G", @"B", @"Y"];
    NSArray *testGuess = @[@"G", @"G", @"R", @"R"];
    NSArray *expectResult = @[@(1), @(1)];
    NSArray *actualResult = [ModerateQuestions numberOfHisAndPseudoHitsOfGuess:testGuess solution:testSolution];
    XCTAssertEqualObjects(expectResult, actualResult);
    
    testSolution = @[@"R", @"G", @"B", @"Y"];
    testGuess = @[@"R", @"G", @"Y", @"B"];
    expectResult = @[@(2), @(2)];
    actualResult = [ModerateQuestions numberOfHisAndPseudoHitsOfGuess:testGuess solution:testSolution];
    XCTAssertEqualObjects(expectResult, actualResult);
}

- (void)testMinimizeRangeToSortIntegers {
    NSArray *testIntegers = @[@(1), @(2), @(4), @(7), @(10), @(11), @(7), @(12), @(6), @(7), @(16), @(18), @(19)];
    NSArray *expectResult = @[@(3), @(9)];
    NSArray *actualResult = [ModerateQuestions minimizeRangeToSort:testIntegers];
    XCTAssertEqualObjects(expectResult, actualResult);
    
    testIntegers = @[@(1), @(2), @(10), @(12), @(4), @(11), @(12), @(13), @(14), @(15), @(16), @(18), @(19)];
    expectResult = @[@(2), @(5)];
    actualResult = [ModerateQuestions minimizeRangeToSort:testIntegers];
    XCTAssertEqualObjects(expectResult, actualResult);
}

- (void)testEnglishPhraseOfInteger {
    NSInteger testInteger = 1103048;
    NSString *actualResult = [ModerateQuestions englishPhraseOfInteger:testInteger];
    NSLog(@"%@", actualResult);
}

- (void)testContiguousSequenceWithLargestSumOfIntegers {
    NSArray *testIntegers = @[@(2), @(-8), @(3), @(-2), @(4), @(-10)];
    NSInteger expectResult = 5; // 3, -1, 4
    NSInteger actualResult = [ModerateQuestions contiguousSequenceWithLargestSumOfIntegers:testIntegers];
    XCTAssertEqual(expectResult, actualResult);
    
    testIntegers = @[@(2), @(3), @(8), @(1), @(2), @(4), @(2), @(3)];
    
}

- (void)testAllPairsOfIntegersWithSpecificSum {
    NSArray *testIntegers = @[@(2), @(-8), @(3), @(-2), @(4), @(-10), @(5), @(1), @(3)];
    NSInteger testSum = 3;
    NSSet *expectResult = [NSSet setWithArray:@[@[@(1), @(2)], @[@(-2), @(5)]]];
    NSSet *actualResult = [ModerateQuestions allPairsOfIntegers:testIntegers withSumOf:testSum];
    XCTAssertEqualObjects(expectResult, actualResult);
    
    actualResult = [ModerateQuestions hashFindPairsFrom:testIntegers sum:testSum];
    XCTAssertEqualObjects(expectResult, actualResult);
}

- (void)testUnconcatenatingSentence {
    NSString *testSentence = @"jesslookedjustliketimherbrother";
    NSArray *testDictionary = @[@"looked", @"just", @"like", @"her", @"brother", @"look", @"he"];
    NSInteger actualResult = [ModerateQuestions unconcatenatingSentence:testSentence byDictionary:testDictionary];
}

@end
