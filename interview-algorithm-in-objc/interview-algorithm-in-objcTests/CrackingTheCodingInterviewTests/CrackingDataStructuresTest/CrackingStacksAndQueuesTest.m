//
//  CrackingStacksAndQueues.m
//  interview-algorithm-in-objc
//
//  Created by Bin Yu on 29/03/16.
//  Copyright © 2016 Bin Yu. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "Animal.h"
#import "AnimalShelter.h"
#import "CrackingStacksAndQueues.h"
#import "FixedSizeArrayThreesomeStack.h"
#import "LinkedListNode.h"
#import "LinkedObjectListNode.h"
#import "MyQueue.h"
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
    [queue enqueue:@(1)];
    [queue enqueue:@(2)];
    [queue enqueue:@(3)];
    XCTAssertNotEqual(queue.first, queue.last);
    XCTAssertEqual(queue.first.data, @(1));
    XCTAssertEqual(queue.last.data, @(3));
    
    XCTAssertEqual([queue dequeue], @(1));
    XCTAssertEqual([queue dequeue], @(2));
    XCTAssertEqual(queue.first, queue.last);
    XCTAssertEqual([queue dequeue], @(3));
    XCTAssertNil(queue.first);
    XCTAssertNil(queue.last);
    XCTAssertNil([queue dequeue]);
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
    
    NSArray *resultArray = @[@(1), @(2), @(3), @(4), @(5)];
    XCTAssertEqualObjects([rightTower.top dataArrayFromList], resultArray);
}

- (void)testMyQueue {
    MyQueue *queue = [MyQueue new];
    [queue enqueue:1];
    [queue enqueue:2];
    [queue enqueue:3];
    [queue enqueue:4];
    XCTAssertTrue([queue.dequeueStack isEmpty]);
    XCTAssertEqual(queue.enqueueStack.count, 4);
    XCTAssertEqual([queue.enqueueStack peek], 4);
    
    XCTAssertEqual([queue dequeue], 1);
    XCTAssertFalse([queue.dequeueStack isEmpty]);
    XCTAssertTrue([queue.enqueueStack isEmpty]);
    XCTAssertEqual(queue.dequeueStack.count, 3);
    XCTAssertEqual([queue dequeue], 2);
    XCTAssertEqual([queue dequeue], 3);
    XCTAssertEqual([queue dequeue], 4);
    
    XCTAssertThrows([queue dequeue]);
}

- (void)testSortStackInAscendingOrder {
    Stack *shuffleStack = [Stack new];
    [shuffleStack push:4];
    [shuffleStack push:2];
    [shuffleStack push:3];
    [shuffleStack push:1];
    [shuffleStack push:5];
    [CrackingStacksAndQueues sortStackInAscendingOrder:shuffleStack];
    NSArray *resultData = @[@(5), @(4), @(3), @(2), @(1)];
    XCTAssertEqualObjects([shuffleStack.top dataArrayFromList], resultData);
    
    shuffleStack = [Stack new];
    [shuffleStack push:4];
    [shuffleStack push:1];
    [shuffleStack push:3];
    [shuffleStack push:2];
    [shuffleStack push:5];
    XCTAssertEqualObjects([[[CrackingStacksAndQueues betterSortStackInAscendingOrder:shuffleStack] top] dataArrayFromList], resultData);
}

- (void)testAnimalShelter {
    AnimalShelter *animalShelter = [AnimalShelter new];
    Animal *animal = nil;
    [animalShelter enqueue:[Animal newCat]];
    [animalShelter enqueue:[Animal newDog]];
    [animalShelter enqueue:[Animal newCat]];
    [animalShelter enqueue:[Animal newCat]];
    [animalShelter enqueue:[Animal newDog]];
    [animalShelter enqueue:[Animal newCat]];
    [animalShelter enqueue:[Animal newDog]];
    XCTAssertEqual(animalShelter.catShelter.count, 4);
    XCTAssertEqual(animalShelter.dogShelter.count, 3);
    
    animal = [animalShelter dequeueAny];
    XCTAssertEqual(animal.order, 0);
    XCTAssertEqual(animal.type, Cat);
    
    animal = [animalShelter dequeueAny];
    XCTAssertEqual(animal.order, 1);
    XCTAssertEqual(animal.type, Dog);
    
    animal = [animalShelter dequeueDog];
    XCTAssertEqual(animal.order, 4);
    XCTAssertEqual(animal.type, Dog);
    
    animal = [animalShelter dequeueAny];
    XCTAssertEqual(animal.order, 2);
    XCTAssertEqual(animal.type, Cat);
    
    animal = [animalShelter dequeueCat];
    XCTAssertEqual(animal.order, 3);
    XCTAssertEqual(animal.type, Cat);
}

@end
