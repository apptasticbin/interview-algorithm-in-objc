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
    XCTAssertEqual(expectNumber, [self integerNumberFromBinaryString:@"100101110"]);
}

- (void)testInsertMIntoN {
    int32_t N = [self integerNumberFromBinaryString:@"100101110"];    // 100101110
    int32_t M = [self integerNumberFromBinaryString:@"1100"];     // 1100
    
    int32_t actualNumber = [CrackingBitManipulation insertBitsOfM:M toN:N fromBit:7 toBit:4];
    int32_t expectNumber = [self integerNumberFromBinaryString:@"111001110"];
    
    XCTAssertEqual(actualNumber, expectNumber);
    
    actualNumber = [CrackingBitManipulation cleanInsertBitsOfM:M toN:N fromBit:7 toBit:4];
    XCTAssertEqual(actualNumber, expectNumber);
}

- (void)testBinaryRepresentationOfFractionNumber {
    double testNumber = 3.5f;
    NSString *binaryString = [CrackingBitManipulation binaryRepresentationOfFractionNumber:testNumber];
    XCTAssertEqualObjects(binaryString, @"0011.1000");
    
    testNumber = [self integerNumberFromBinaryString:@"101100011010101100011011100001"];
    testNumber = testNumber + 0.5;
    binaryString = [CrackingBitManipulation binaryRepresentationOfFractionNumber:testNumber];
    XCTAssertEqualObjects(binaryString, @"00101100011010101100011011100001.1000");
    
    testNumber = testNumber + 0.2093;
    binaryString = [CrackingBitManipulation binaryRepresentationOfFractionNumber:testNumber];
    XCTAssertEqualObjects(binaryString, @"ERROR");
}

- (void)testPreviousAndNextNumberWithSameAmountOfOnes {
    NSInteger testNumber = [self integerNumberFromBinaryString:@"110010111000"];
    NSInteger expectNextSmallestNumber = [self integerNumberFromBinaryString:@"110011000011"];
    NSInteger actualNextSmallestNumber = [CrackingBitManipulation nextSmallestNumberWithSameAmountOfOne:testNumber];
    XCTAssertEqual(actualNextSmallestNumber, expectNextSmallestNumber);
    NSInteger expectPreviousLargestNumber = [self integerNumberFromBinaryString:@"110010110100"];
    NSInteger actualPreviousLargestNumber = [CrackingBitManipulation previousLargestNumberWithSameAmountOfOne:testNumber];
    XCTAssertEqual(actualPreviousLargestNumber, expectPreviousLargestNumber);
    
    testNumber = [self integerNumberFromBinaryString:@"110010111001"];
    expectNextSmallestNumber = [self integerNumberFromBinaryString:@"110010111010"];
    actualNextSmallestNumber = [CrackingBitManipulation nextSmallestNumberWithSameAmountOfOne:testNumber];
    XCTAssertEqual(actualNextSmallestNumber, expectNextSmallestNumber);
    expectPreviousLargestNumber = [self integerNumberFromBinaryString:@"110010110110"];
    actualPreviousLargestNumber = [CrackingBitManipulation previousLargestNumberWithSameAmountOfOne:testNumber];
    XCTAssertEqual(actualPreviousLargestNumber, expectPreviousLargestNumber);
}

- (void)testNumberOfBitsToConvertIntegers {
    NSInteger integerA = [self integerNumberFromBinaryString:@"11001011100"];
    NSInteger integerB = [self integerNumberFromBinaryString:@"10110101111"];
    NSInteger expectResult = 8;
    NSInteger actualResult = [CrackingBitManipulation numberOfBitsToConvertIntegerA:integerA toIntegerB:integerB];
    XCTAssertEqual(actualResult, expectResult);
    
    integerA = [self integerNumberFromBinaryString:@"00000000000"];
    integerB = [self integerNumberFromBinaryString:@"11111111111"];
    expectResult = 11;
    actualResult = [CrackingBitManipulation numberOfBitsToConvertIntegerA:integerA toIntegerB:integerB];
    XCTAssertEqual(actualResult, expectResult);
}

- (void)testSwapOddAndEventBitsOfNumber {
    int32_t testNumber = [self integerNumberFromBinaryString:  @"0100011101010010"];
    int32_t expectResult = [self integerNumberFromBinaryString:@"1000101110100001"];
    int32_t actualResult = [CrackingBitManipulation swapOddAndEventBitsOfNumber:testNumber];
    XCTAssertEqual(actualResult, expectResult);
}

#pragma mark - Private

- (int32_t)integerNumberFromBinaryString:(NSString *)binaryString {
    int32_t number = 0;
    for (NSInteger i=binaryString.length-1, j=0; i >= 0; i--, j++) {
        NSString *bit = [binaryString substringWithRange:NSMakeRange(i, 1)];
        if ([bit isEqualToString:@"1"]) {
            number = [CrackingBitManipulation setBitOfNumber:number at:j];
        }
    }
    return number;
}

@end
