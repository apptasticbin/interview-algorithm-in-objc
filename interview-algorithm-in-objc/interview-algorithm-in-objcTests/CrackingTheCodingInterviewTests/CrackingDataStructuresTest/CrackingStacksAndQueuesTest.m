//
//  CrackingStacksAndQueues.m
//  interview-algorithm-in-objc
//
//  Created by Bin Yu on 29/03/16.
//  Copyright © 2016 Bin Yu. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "FixedSizeArrayThreesomeStack.h"
#import "LinkedListNode.h"
#import "Queue.h"
#import "Stack.h"

@interface CrackingStacksAndQueuesTest : XCTestCase

@end

@implementation CrackingStacksAndQueuesTest

- (void)setUp {
    [super setUp];
}

- (void)tearDown {
    [super tearDown];
}

- (void)testStack {
    Stack *stack = [Stack new];
    [stack push:1];
    [stack push:2];
    [stack push:3];
    XCTAssertEqual([stack pop], 3);
    XCTAssertEqual([stack pop], 2);
    XCTAssertEqual([stack pop], 1);
    XCTAssertNil(stack.top);
    XCTAssertThrowsSpecificNamed([stack pop], NSException, @"EmptyStackException");
}

- (void)testQueue {
    Queue *queue = [Queue new];
    [queue enqueue:1];
    [queue enqueue:2];
    [queue enqueue:3];
    XCTAssertNotEqual(queue.first, queue.last);
    XCTAssertEqual(queue.first.data, 1);
    XCTAssertEqual(queue.last.data, 3);
    
    XCTAssertEqual([queue dequeue], 1);
    XCTAssertEqual([queue dequeue], 2);
    XCTAssertEqual(queue.first, queue.last);
    XCTAssertEqual([queue dequeue], 3);
    XCTAssertNil(queue.first);
    XCTAssertNil(queue.last);
    XCTAssertThrowsSpecificNamed([queue dequeue], NSException, @"EmptyQueueException");
}

- (void)testFixedSizeArrayThreesomeStack {
    FixedSizeArrayThreesomeStack *threesomeStack = [FixedSizeArrayThreesomeStack stackWithOneStackCapacity:2];
    XCTAssertTrue([threesomeStack isStackEmpay:0]);
    XCTAssertTrue([threesomeStack isStackEmpay:1]);
    XCTAssertTrue([threesomeStack isStackEmpay:2]);
    
    XCTAssertThrows([threesomeStack isStackEmpay:-1]);
    
    [threesomeStack pushData:1 toStack:0];
    [threesomeStack pushData:2 toStack:0];
    [threesomeStack pushData:3 toStack:1];
    [threesomeStack pushData:4 toStack:2];
    [threesomeStack pushData:5 toStack:2];
    
    XCTAssertEqual([threesomeStack peekOfStack:0], 2);
    XCTAssertEqual([threesomeStack peekOfStack:1], 3);
    XCTAssertEqual([threesomeStack peekOfStack:2], 5);
    
    XCTAssertThrows([threesomeStack pushData:99 toStack:0]);
    XCTAssertThrows([threesomeStack pushData:99 toStack:2]);
    
    XCTAssertEqual([threesomeStack popDataFromStack:1], 3);
    XCTAssertThrows([threesomeStack popDataFromStack:1]);
}

@end
