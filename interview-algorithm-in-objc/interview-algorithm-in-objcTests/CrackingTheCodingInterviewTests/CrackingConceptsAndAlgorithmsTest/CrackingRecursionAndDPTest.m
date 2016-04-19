//
//  CrackingRecursionAndDPTest.m
//  interview-algorithm-in-objc
//
//  Created by Bin Yu on 15/04/16.
//  Copyright © 2016 Bin Yu. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "CrackingResursionAndDP.h"
#import "Matrix.h"

@interface CrackingRecursionAndDPTest : XCTestCase

@end

@implementation CrackingRecursionAndDPTest

- (void)setUp {
    [super setUp];
}

- (void)tearDown {
    [super tearDown];
}

- (void)testFactorial {
    NSUInteger testNumber = 5;
    NSUInteger expectResult = 120;
    NSUInteger actualResult = [self factorial:testNumber];
    XCTAssertEqual(actualResult, expectResult);
    
    testNumber = 10;
    expectResult = 3628800;
    actualResult = [self factorial:testNumber];
    XCTAssertEqual(actualResult, expectResult);
}

- (void)testMatrix {
    Matrix *testMatrix1 = [Matrix matrixWithRow:4 column:4];
    Matrix *testMatrix2 = [Matrix matrixWithRow:4 column:4];
    [testMatrix1 setItemAtRow:2 column:2 data:1];
    [testMatrix2 setItemAtRow:2 column:2 data:1];
    XCTAssertEqualObjects(testMatrix1, testMatrix2);
    
    [testMatrix2 setItemAtRow:3 column:1 data:1];
    XCTAssertNotEqualObjects(testMatrix1, testMatrix2);
    
    XCTAssertEqual(1, [testMatrix2 itemAtRow:3 column:1]);
    XCTAssertThrows([testMatrix1 itemAtRow:5 column:3]);
    XCTAssertThrows([testMatrix1 setItemAtRow:5 column:3 data:2]);
    
    NSLog(@"%@", testMatrix2);
}

- (void)testPossibleWaysToRunUpStaircase {
    NSUInteger steps = 3;
    NSUInteger expectResult = 4;
    NSUInteger actualResult = [CrackingResursionAndDP possibleWaysToRunUpStaircase:steps];
    XCTAssertEqual(actualResult, expectResult);
    
    steps = 4;
    expectResult = 7;
    actualResult = [CrackingResursionAndDP possibleWaysToRunUpStaircase:steps];
    XCTAssertEqual(actualResult, expectResult);
    
    steps = 30;
    actualResult = [CrackingResursionAndDP possibleWaysToRunUpStaircase:steps];
    NSLog(@"possible ways of %lu steps: %ld", (unsigned long)steps, (long)actualResult);
}

- (void)testPossiblePathsInGridBoard {
    NSInteger testX = 2;
    NSInteger testY = 2;
    NSInteger expectResult = [self actualPossibleStepsForGrid:testX y:testY];
    NSInteger actualResult = [CrackingResursionAndDP possiblePathsInGridBoard:testX y:testY];
    XCTAssertEqual(expectResult, actualResult);
    
    testX = 5;
    testY = 10;
    expectResult = [self actualPossibleStepsForGrid:testX y:testY];
    actualResult = [CrackingResursionAndDP possiblePathsInGridBoard:testX y:testY];
    XCTAssertEqual(expectResult, actualResult);
    
    testX = 4;
    testY = 4;
    NSArray *testBlockSpots = [NSArray array];
    NSMutableArray *actualPath = [NSMutableArray array];
    
    [CrackingResursionAndDP pathFromTopLeftToBottomRightInGridBoard:testX y:testY
                                                               path:actualPath
                                                         blockSpots:testBlockSpots];
    NSLog(@"%@", actualPath);
}

- (void)testFindMagicIndexIfExistsInSortedArray {
    NSArray *testSortedArray = @[@(-2), @(-1), @(0), @(3), @(5), @(7)];
    NSInteger expectResult = 3;
    NSInteger actualResult = [CrackingResursionAndDP findMagicIndexIfExistsInSortedArray:testSortedArray];
    XCTAssertEqual(expectResult, actualResult);
    
    testSortedArray = @[@(-2), @(-1), @(0), @(4), @(5), @(7)];
    expectResult = -1;
    actualResult = [CrackingResursionAndDP findMagicIndexIfExistsInSortedArray:testSortedArray];
    XCTAssertEqual(expectResult, actualResult);
}

- (void)testFindAllSubsetsOfSet {
    NSArray *testSetArray = @[@(1), @(2), @(3), @(4)];
    NSMutableSet *testSet = [NSMutableSet setWithArray:testSetArray];
    NSArray *actualResultArray = [CrackingResursionAndDP findAllSubsetsOfSet:testSet];
    NSArray *expectResultArray = @[
                                   @[],
                                   @[@(1)],
                                   @[@(2)],
                                   @[@(3)],
                                   @[@(4)],
                                   @[@(1), @(2)],
                                   @[@(1), @(3)],
                                   @[@(1), @(4)],
                                   @[@(2), @(3)],
                                   @[@(2), @(4)],
                                   @[@(3), @(4)],
                                   @[@(1), @(2), @(3)],
                                   @[@(1), @(2), @(4)],
                                   @[@(1), @(3), @(4)],
                                   @[@(2), @(3), @(4)],
                                   @[@(1), @(2), @(3), @(4)]
                                   ];
    NSSet *expectResultSet = [self setOfSubsetsFromArray:expectResultArray];
    NSSet *actualResultSet = [NSSet setWithArray:actualResultArray];
    XCTAssertEqualObjects(actualResultSet, expectResultSet);
    XCTAssertEqual(expectResultArray.count, actualResultArray.count);
}

- (void)testAllPermutationsOfString {
    NSString *testString = @"abcdef";
    NSArray *actualResult = [CrackingResursionAndDP allPermutationsOfString:testString];
    NSUInteger expectResultCount = [self factorial:testString.length];
    XCTAssertEqual(expectResultCount, actualResult.count);
    
    NSSet *actualResultSet = [NSSet setWithArray:actualResult];
    XCTAssertEqual(expectResultCount, actualResultSet.count);
}

- (void)testPairsOfParentheseCombinations {
    NSInteger testPairAmount = 3;
    NSArray *actualResult = [CrackingResursionAndDP nPairsOfParentheseCombinations:testPairAmount];
    XCTAssertEqual(actualResult.count, 5);
    NSLog(@"%@", actualResult);
}

- (void)testPaintFillColorOnScreen {
    // create 5 x 5 screen array
    NSMutableArray *testScreen =
    [NSMutableArray
     arrayWithArray: @[
                       [NSMutableArray arrayWithArray:@[[UIColor redColor], [UIColor redColor], [UIColor redColor], [UIColor redColor], [UIColor redColor]]],
                       [NSMutableArray arrayWithArray:@[[UIColor redColor], [UIColor whiteColor], [UIColor whiteColor], [UIColor whiteColor], [UIColor redColor]]],
                       [NSMutableArray arrayWithArray:@[[UIColor redColor], [UIColor greenColor], [UIColor whiteColor], [UIColor whiteColor], [UIColor redColor]]],
                       [NSMutableArray arrayWithArray:@[[UIColor redColor], [UIColor greenColor], [UIColor whiteColor], [UIColor whiteColor], [UIColor redColor]]],
                       [NSMutableArray arrayWithArray:@[[UIColor redColor], [UIColor redColor], [UIColor redColor], [UIColor redColor], [UIColor redColor]]],
                       ]
     ];
    NSArray *resultScreen = @[
                       @[[UIColor redColor], [UIColor redColor], [UIColor redColor], [UIColor redColor], [UIColor redColor]],
                       @[[UIColor redColor], [UIColor blueColor], [UIColor blueColor], [UIColor blueColor], [UIColor redColor]],
                       @[[UIColor redColor], [UIColor greenColor], [UIColor blueColor], [UIColor blueColor], [UIColor redColor]],
                       @[[UIColor redColor], [UIColor greenColor], [UIColor blueColor], [UIColor blueColor], [UIColor redColor]],
                       @[[UIColor redColor], [UIColor redColor], [UIColor redColor], [UIColor redColor], [UIColor redColor]],
                       ];
    CGPoint testPaintPoint = CGPointMake(1, 1);
    [CrackingResursionAndDP paintFillColor:[UIColor blueColor] atPoint:testPaintPoint onScreen:testScreen];
    XCTAssertEqualObjects(testScreen, resultScreen);
}

- (void)testNumberOfWaysToRepresentNCents {
    NSInteger testCents = 10;
    NSInteger expectRepresentingWays = 4;
    NSInteger actualRepresentingWays = [CrackingResursionAndDP numberOfWaysToRepresentNCents:testCents];
    XCTAssertEqual(expectRepresentingWays, actualRepresentingWays);
    
    testCents = 15;
    expectRepresentingWays = 6;
    actualRepresentingWays = [CrackingResursionAndDP numberOfWaysToRepresentNCents:testCents];
    XCTAssertEqual(expectRepresentingWays, actualRepresentingWays);
    
    for (NSInteger i=20; i<100; i += 3) {
        XCTAssertEqual([CrackingResursionAndDP numberOfWaysToRepresentNCents:i],
                       [CrackingResursionAndDP betterNumberOfWaysToRepresentNCents:i denom:25]);
    }
}

- (void)testQueenCombinationOn8X8ChessBoard {
    NSArray *results = [CrackingResursionAndDP queenCombinationOn8X8ChessBoard];
    for (NSUInteger i=0; i<results.count; i++) {
        NSLog(@"%@", results[i]);
    }
}

- (void)testParenthesizingWaysOfExpressionForDesiredResult {
    NSString *testExpresion = @"1^0|0|1";
    BOOL testDesiredResult = NO;
    NSUInteger expectResult = 2;
    NSUInteger actualResult = [CrackingResursionAndDP parenthesizingWaysOf:testExpresion desiredResult:testDesiredResult];
    XCTAssertEqual(expectResult, actualResult);
    
    /**
     https://zh.wikipedia.org/wiki/%E5%8D%A1%E5%A1%94%E5%85%B0%E6%95%B0
     There is a closed form expressionfor the number of ways of parenthesizing an expression,
     but you wouldn't be expected to know it. It isgiven by the Catalan numbers, where 'n' is the number of operators:
     Cn = (2n)! / ( (n+1)! * n! )
     */
}

#pragma mark - Private

- (NSUInteger)factorial:(NSUInteger)number {
    if (number == 1) {
        return 1;
    }
    return [self factorial:number-1] * number;
}

- (NSUInteger)actualPossibleStepsForGrid:(NSUInteger)x y:(NSUInteger)y {
    return [self factorial:x+y] / [self factorial:x] / [self factorial:y];
}

- (NSSet *)setOfSubsetsFromArray:(NSArray *)array {
    NSMutableSet *setOfSubsets = [NSMutableSet set];
    for (NSArray *subArray in array) {
        [setOfSubsets addObject:[NSSet setWithArray:subArray]];
    }
    return setOfSubsets;
}

@end
