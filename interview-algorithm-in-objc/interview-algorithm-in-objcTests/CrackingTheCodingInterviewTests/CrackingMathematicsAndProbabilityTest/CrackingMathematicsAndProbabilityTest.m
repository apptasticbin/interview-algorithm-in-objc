//
//  CrackingMathematicsAndProbabilityTest.m
//  interview-algorithm-in-objc
//
//  Created by Bin Yu on 13/04/16.
//  Copyright © 2016 Bin Yu. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "CrackingMathematicsAndProbability.h"

@interface CrackingMathematicsAndProbabilityTest : XCTestCase

@end

@implementation CrackingMathematicsAndProbabilityTest

- (void)setUp {
    [super setUp];
}

- (void)tearDown {
    [super tearDown];
}

- (void)testIntersectOfLines {
    Line *line1 = [[Line alloc] initWithSlope:2.3f yIntersect:5.5f];
    Line *line2 = [[Line alloc] initWithSlope:2.5f yIntersect:2.1f];
    XCTAssertTrue([CrackingMathematicsAndProbability intersectOfLine:line1 andLine:line2]);
    
    line1 = [[Line alloc] initWithSlope:2.3f yIntersect:5.5f];
    line2 = [[Line alloc] initWithSlope:2.3f yIntersect:2.1f];
    XCTAssertFalse([CrackingMathematicsAndProbability intersectOfLine:line1 andLine:line2]);

    line1 = [[Line alloc] initWithSlope:2.3f yIntersect:5.5f];
    line2 = [[Line alloc] initWithSlope:2.3f yIntersect:5.5f];
    XCTAssertTrue([CrackingMathematicsAndProbability intersectOfLine:line1 andLine:line2]);
}

- (void)testArithmeticMethods {
    NSInteger testNumberA = 4;
    NSInteger testNumberB = 19;
    NSInteger expectResult = -15;
    NSInteger actualResult = [CrackingMathematicsAndProbability substract:testNumberA by:testNumberB];
    XCTAssertEqual(actualResult, expectResult);
    
    testNumberA = 4;
    testNumberB = -19;
    expectResult = 23;
    actualResult = [CrackingMathematicsAndProbability substract:testNumberA by:testNumberB];
    XCTAssertEqual(actualResult, expectResult);
    
    testNumberA = 4;
    testNumberB = -19;
    expectResult = -76;
    actualResult = [CrackingMathematicsAndProbability multiply:testNumberA and:testNumberB];
    XCTAssertEqual(actualResult, expectResult);
    
    testNumberA = -4;
    testNumberB = -19;
    expectResult = 76;
    actualResult = [CrackingMathematicsAndProbability multiply:testNumberA and:testNumberB];
    XCTAssertEqual(actualResult, expectResult);
    
    testNumberA = 0;
    testNumberB = -19;
    expectResult = 0;
    actualResult = [CrackingMathematicsAndProbability divide:testNumberA by:testNumberB];
    XCTAssertEqual(actualResult, expectResult);
    
    testNumberA = -10;
    testNumberB = -19;
    expectResult = 0;
    actualResult = [CrackingMathematicsAndProbability divide:testNumberA by:testNumberB];
    XCTAssertEqual(actualResult, expectResult);
    
    testNumberA = -38;
    testNumberB = -19;
    expectResult = 2;
    actualResult = [CrackingMathematicsAndProbability divide:testNumberA by:testNumberB];
    XCTAssertEqual(actualResult, expectResult);
    
    testNumberA = -38;
    testNumberB = 19;
    expectResult = -2;
    actualResult = [CrackingMathematicsAndProbability divide:testNumberA by:testNumberB];
    XCTAssertEqual(actualResult, expectResult);
    
    testNumberA = 100;
    testNumberB = 0;
    XCTAssertThrows([CrackingMathematicsAndProbability divide:testNumberA by:testNumberB]);
}

- (void)testKthNumberMadeBy357 {
    NSInteger k = 3;
    NSInteger expectResult = 7;
    NSInteger actualResult = [CrackingMathematicsAndProbability kthNumberMadeBy357:k];
    XCTAssertEqual(actualResult, expectResult);
    
    k = 7;
    expectResult = 25;
    actualResult = [CrackingMathematicsAndProbability kthNumberMadeBy357:k];
    XCTAssertEqual(actualResult, expectResult);
}

@end
