//
//  HardQuestionsTest.m
//  interview-algorithm-in-objc
//
//  Created by Bin Yu on 06/05/16.
//  Copyright © 2016 Bin Yu. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "Hard.h"

@interface HardQuestionsTest : XCTestCase

@end

@implementation HardQuestionsTest

- (void)setUp {
    [super setUp];
}

- (void)tearDown {
    [super tearDown];
}

- (void)testAddNumbers {
    NSInteger testA = 5;
    NSInteger testB = 10;
    NSInteger expectResult = 15;
    NSInteger actualResult = [Hard addNumber:testA andNumber:testB];
    XCTAssertEqual(expectResult, actualResult);
    
    actualResult = [Hard recursionAddNumber:testA andNumber:testB];
    XCTAssertEqual(expectResult, actualResult);
    
    testA = 5;
    testB = -10;
    expectResult = -5;
    actualResult = [Hard addNumber:testA andNumber:testB];
    XCTAssertEqual(expectResult, actualResult);
    
    actualResult = [Hard recursionAddNumber:testA andNumber:testB];
    XCTAssertEqual(expectResult, actualResult);
    
    testA = -5;
    testB = 10;
    expectResult = 5;
    actualResult = [Hard addNumber:testA andNumber:testB];
    XCTAssertEqual(expectResult, actualResult);
    
    actualResult = [Hard recursionAddNumber:testA andNumber:testB];
    XCTAssertEqual(expectResult, actualResult);
}

- (void)testCountNumberOf2sBetween0AndN {
    NSInteger testNumber = 25;
    NSInteger expectResult = 9;
    NSInteger actualResult = [Hard bruteForceCountNumberOf2sBetween0AndN:testNumber];
    XCTAssertEqual(expectResult, actualResult);
    
    actualResult = [Hard betterCountNumberOf2sBetween0AndN:testNumber];
    XCTAssertEqual(expectResult, actualResult);
}

- (void)testFindLongestWordMadeOfOtherWordsInList {
    NSArray *testWordList = @[@"cat", @"banana", @"dog", @"nana", @"walk", @"walker", @"dogwalker", @"catiscuteanimal"];
    NSString *expectResult = @"dogwalker";
    NSString *actualResult = [Hard findLongestWordMadeOfOtherWordsInList:testWordList];
    XCTAssertEqualObjects(expectResult, actualResult);
}

- (void)testSearchSmallStringinString {
    NSString *testString = @"thisisateststringis";
    NSString *testSmallString = @"is";
    NSArray *expectResult = @[@(2), @(4), @(17)];
    NSArray *actualResult = [Hard searchSmallString:testSmallString inString:testString];
    XCTAssertEqualObjects(expectResult, actualResult);
}

- (void)testTransformWordToAnotherWordBasedOnDictionary {
    NSString *testFromString = @"DAMP";
    NSString *testToString = @"LIKE";
    NSArray<NSString *> *testDictionary = @[@"DAMP", @"LAMP", @"LIMP", @"LIME", @"LIKE"];
    NSString *expectResult = @"DAMP -> LAMP -> LIMP -> LIME -> LIKE";
    NSString *actualResult = [Hard betterTransformWord:testFromString toWord:testToString inDictionary:testDictionary];
    XCTAssertEqualObjects(expectResult, actualResult);
    
    testDictionary = @[@"DAMP", @"LAMP", @"NONE", @"LIME", @"LIKE"];
    actualResult = [Hard betterTransformWord:testFromString toWord:testToString inDictionary:testDictionary];
    XCTAssertNil(actualResult);

}

@end
