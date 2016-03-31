//
//  CrackingStacksAndQueues.m
//  interview-algorithm-in-objc
//
//  Created by Bin Yu on 29/03/16.
//  Copyright © 2016 Bin Yu. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "CrackingStacksAndQueues.h"
#import "FixedSizeArrayThreesomeStack.h"
#import "LinkedListNode.h"
#import "Queue.h"
#import "SetOfStacks.h"
#import "StackWithMinimum.h"

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

- (void)testStackWithMiminum {
    StackWithMinimum *stack = [StackWithMinimum new];
    [stack push:3];
    [stack push:5];
    [stack push:1];
    [stack push:2];
    XCTAssertEqual([stack min], 1);
    [stack pop];
    XCTAssertEqual([stack min], 1);
    [stack pop];
    XCTAssertEqual([stack min], 3);
    [stack pop];
    XCTAssertEqual([stack min], 3);
    [stack pop];
    XCTAssertThrows([stack min]);
}

- (void)testSetOfStacks {
    SetOfStacks *stack = [[SetOfStacks alloc] initWithThreshold:2];
    XCTAssertEqual(stack.stackBuffer.count, 0);
    [stack push:1];
    XCTAssertEqual(stack.stackBuffer.count, 1);
    [stack push:2];
    XCTAssertEqual(stack.stackBuffer.count, 1);
    [stack push:3];
    XCTAssertEqual(stack.stackBuffer.count, 2);
    [stack push:4];
    XCTAssertEqual(stack.stackBuffer.count, 2);
    [stack push:5];
    XCTAssertEqual(stack.stackBuffer.count, 3);
    
    XCTAssertEqual([stack pop], 5);
    XCTAssertEqual(stack.stackBuffer.count, 2);
    XCTAssertEqual([stack pop], 4);
    XCTAssertEqual(stack.stackBuffer.count, 2);
    XCTAssertEqual([stack pop], 3);
    XCTAssertEqual(stack.stackBuffer.count, 1);
    XCTAssertEqual([stack pop], 2);
    XCTAssertEqual(stack.stackBuffer.count, 1);
    XCTAssertEqual([stack pop], 1);
    XCTAssertEqual(stack.stackBuffer.count, 0);
    XCTAssertThrows([stack pop]);
    
    [stack push:1];
    [stack push:2];
    [stack push:3];
    [stack push:4];
    [stack push:5];
    XCTAssertEqual([stack popAtIndexRecursively:1], 4);
    XCTAssertEqual(stack.stackBuffer.count, 2);
    XCTAssertEqual([stack popAtIndexRecursively:0], 2);
    XCTAssertEqual(stack.stackBuffer.count, 2);
    XCTAssertEqual([stack popAtIndexRecursively:1], 5);
    XCTAssertEqual(stack.stackBuffer.count, 1);
}

- (void)testTowersOfHanoiPuzzleSolver {
    Stack *leftTower = [Stack new];
    Stack *midTower = [Stack new];
    Stack *rightTower = [Stack new];
    [leftTower push:5];
    [leftTower push:4];
    [leftTower push:3];
    [leftTower push:2];
    [leftTower push:1];
    
    [CrackingStacksAndQueues towersOfHanoiPuzzleSolver:@[leftTower, midTower, rightTower]];
    
    XCTAssertTrue([leftTower isEmpty]);
    XCTAssertTrue([midTower isEmpty]);
    XCTAssertFalse([rightTower isEmpty]);
}

@end
