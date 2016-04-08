//
//  CrackingBitManipulationTest.m
//  interview-algorithm-in-objc
//
//  Created by Bin Yu on 09/04/16.
//  Copyright © 2016 Bin Yu. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "CrackingBitManipulation.h"

@interface CrackingBitManipulationTest : XCTestCase

@end

@implementation CrackingBitManipulationTest

- (void)setUp {
    [super setUp];
}

- (void)tearDown {
    [super tearDown];
}

- (void)testBitOperations {
    // 100101110 = 2+4+8+32+256 = 302
    int32_t expectNumber = 302;
    int32_t actualNumber = 0;
    actualNumber = [CrackingBitManipulation setBitOfNumber:actualNumber at:1];
    actualNumber = [CrackingBitManipulation setBitOfNumber:actualNumber at:2];
    actualNumber = [CrackingBitManipulation setBitOfNumber:actualNumber at:3];
    actualNumber = [CrackingBitManipulation setBitOfNumber:actualNumber at:5];
    actualNumber = [CrackingBitManipulation setBitOfNumber:actualNumber at:8];
    XCTAssertEqual(actualNumber, expectNumber);
    XCTAssertEqual(actualNumber ^ expectNumber, 0);
    
    XCTAssertTrue([CrackingBitManipulation getBitOfNumber:actualNumber at:8]);
    XCTAssertFalse([CrackingBitManipulation getBitOfNumber:actualNumber at:7]);
    XCTAssertTrue([CrackingBitManipulation getBitOfNumber:actualNumber at:3]);
    XCTAssertFalse([CrackingBitManipulation getBitOfNumber:actualNumber at:4]);
    XCTAssertTrue([CrackingBitManipulation getBitOfNumber:actualNumber at:5]);
    
    XCTAssertEqual([CrackingBitManipulation clearBitOfNumber:actualNumber at:2],
                   302-4);
    XCTAssertEqual([CrackingBitManipulation clearBitOfNumber:actualNumber at:8],
                   302-256);
    XCTAssertEqual([CrackingBitManipulation clearBitsOfNumber:actualNumber fromMostSignificantBitTo:4],
                   302-32-256);
    XCTAssertEqual([CrackingBitManipulation clearBitsOfNumber:actualNumber fromZeroBitTo:3],
                   302-8-4-2);
    XCTAssertEqual([CrackingBitManipulation updateBitsOfNumber:actualNumber at:0 withValue:1],
                   302+1);
    XCTAssertEqual([CrackingBitManipulation updateBitsOfNumber:actualNumber at:4 withValue:1],
                   302+16);
}

@end
