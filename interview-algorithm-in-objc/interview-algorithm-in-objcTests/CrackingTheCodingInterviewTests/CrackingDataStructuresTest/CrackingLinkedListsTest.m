//
//  CrackingLinkedListsTest.m
//  interview-algorithm-in-objc
//
//  Created by Bin Yu on 27/03/16.
//  Copyright © 2016 Bin Yu. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "CrackingLinkedLists.h"
#import "LinkedListNode.h"

@interface CrackingLinkedListsTest : XCTestCase

@end

@implementation CrackingLinkedListsTest

- (void)setUp {
    [super setUp];
}

- (void)tearDown {
    [super tearDown];
}

- (void)testRemoveDuplicatesFromList {
    NSArray *listArray = @[@(9), @(2), @(4), @(5), @(2), @(9), @(1), @(4), @(2)];
    LinkedListNode *list = [LinkedListNode linkedListWithArray:listArray];
    [CrackingLinkedLists removeDuplicatesFromList:list];
    NSArray *resultArray = @[@(9), @(2), @(4), @(5), @(1)];
    XCTAssertEqualObjects([list dataArrayFromList], resultArray);
    
    listArray = @[@(1), @(1), @(1), @(1), @(1), @(1)];
    list = [LinkedListNode linkedListWithArray:listArray];
    [CrackingLinkedLists removeDuplicatesFromList:list];
    resultArray = @[@(1)];
    XCTAssertEqualObjects([list dataArrayFromList], resultArray);
    
    listArray = @[@(9)];
    list = [LinkedListNode linkedListWithArray:listArray];
    [CrackingLinkedLists removeDuplicatesFromList:list];
    resultArray = @[@(9)];
    XCTAssertEqualObjects([list dataArrayFromList], resultArray);
    
    listArray = nil;
    list = [LinkedListNode linkedListWithArray:listArray];
    [CrackingLinkedLists removeDuplicatesFromList:list];
    XCTAssertNil([list dataArrayFromList]);
}

- (void)testFindNodeInListKthFromLastNode {
    NSArray *listArray = @[@(9), @(2), @(4), @(5), @(2), @(9), @(1), @(4), @(2)];
    LinkedListNode *list = [LinkedListNode linkedListWithArray:listArray];
    LinkedListNode *resultNode = [CrackingLinkedLists findNodeInList:list kthFromLastNode:6];
    XCTAssertEqual(resultNode.data, 5);
    
    [CrackingLinkedLists findNodeInListRecursively:list kthFromLastNode:3 result:&resultNode];
    XCTAssertEqual(resultNode.data, 1);
    
    listArray = @[@(5), @(2), @(9), @(1), @(4), @(2)];
    list = [LinkedListNode linkedListWithArray:listArray];
    resultNode = [CrackingLinkedLists findNodeInList:list kthFromLastNode:6];
    XCTAssertEqual(resultNode.data, 5);
    
    listArray = @[@(1), @(4), @(2)];
    list = [LinkedListNode linkedListWithArray:listArray];
    resultNode = [CrackingLinkedLists findNodeInList:list kthFromLastNode:5];
    XCTAssertNil(resultNode);
    
    listArray = @[@(1), @(4), @(2)];
    list = [LinkedListNode linkedListWithArray:listArray];
    resultNode = [CrackingLinkedLists findNodeInList:list kthFromLastNode:1];
    XCTAssertEqual(resultNode.data, 2);
    
    listArray = @[@(1), @(4), @(2)];
    list = [LinkedListNode linkedListWithArray:listArray];
    resultNode = [CrackingLinkedLists findNodeInList:list kthFromLastNode:0];
    XCTAssertEqual(resultNode.data, 2);
}

- (void)testDeleteNode {
    NSArray *listArray = @[@(9), @(4), @(5), @(2), @(1)];
    LinkedListNode *list = [LinkedListNode linkedListWithArray:listArray];
    LinkedListNode *midNode = [list nodeAtIndex:2];
    [CrackingLinkedLists deleteNode:midNode];
    NSArray *resultArray = @[@(9), @(4), @(2), @(1)];
    XCTAssertEqualObjects([list dataArrayFromList], resultArray);
    
    listArray = @[@(9), @(1)];
    list = [LinkedListNode linkedListWithArray:listArray];
    midNode = [list nodeAtIndex:0];
    [CrackingLinkedLists deleteNode:midNode];
    resultArray = @[@(1)];
    XCTAssertEqualObjects([list dataArrayFromList], resultArray);
}

- (void)testPartitionLinkedList {
    NSArray *listArray = @[@(3), @(2), @(4), @(5), @(2), @(9), @(1), @(4), @(2)];
    LinkedListNode *list = [LinkedListNode linkedListWithArray:listArray];
    LinkedListNode *partitionList = [CrackingLinkedLists partitionLinkedList:list byValue:5];
    NSArray *expectResult = @[@(3), @(2), @(4), @(2), @(1), @(4), @(2), @(5), @(9)];
    XCTAssertEqualObjects([partitionList dataArrayFromList], expectResult);
    
    list = [LinkedListNode linkedListWithArray:listArray];
    partitionList = [CrackingLinkedLists partitionLinkedList:list byValue:4];
    expectResult = @[@(3), @(2), @(2), @(1), @(2), @(4), @(5), @(9), @(4)];
    XCTAssertEqualObjects([partitionList dataArrayFromList], expectResult);
    
    listArray = @[@(3), @(1)];
    list = [LinkedListNode linkedListWithArray:listArray];
    partitionList = [CrackingLinkedLists partitionLinkedList:list byValue:3];
    expectResult = @[@(1), @(3)];
    XCTAssertEqualObjects([partitionList dataArrayFromList], expectResult);
    
    listArray = @[@(1), @(1), @(1), @(1), @(1)];
    list = [LinkedListNode linkedListWithArray:listArray];
    partitionList = [CrackingLinkedLists partitionLinkedList:list byValue:3];
    expectResult = @[@(1), @(1), @(1), @(1), @(1)];
    XCTAssertEqualObjects([partitionList dataArrayFromList], expectResult);
}

- (void)testAddNumberLists {
    NSArray *listArray = nil;
    LinkedListNode *firstNumberList = nil;
    LinkedListNode *secondNumberList = nil;
    LinkedListNode *sumNumberList = nil;
    NSArray *resultArray = nil;
    
    // test reverse-orderred number list
    listArray = @[@(7), @(1), @(6)];
    firstNumberList = [LinkedListNode linkedListWithArray:listArray];
    listArray = @[@(5), @(9), @(2)];
    secondNumberList = [LinkedListNode linkedListWithArray:listArray];
    sumNumberList = [CrackingLinkedLists addReverseOrderNumberList:firstNumberList withNumberList:secondNumberList];
    resultArray = @[@(2), @(1), @(9)];
    XCTAssertEqualObjects([sumNumberList dataArrayFromList], resultArray);
    
    sumNumberList = [CrackingLinkedLists addReverseOrderNumberList:firstNumberList withNumberList:secondNumberList carry:0];
    resultArray = @[@(2), @(1), @(9)];
    XCTAssertEqualObjects([sumNumberList dataArrayFromList], resultArray);
    
    listArray = @[@(3), @(2), @(1)];
    firstNumberList = [LinkedListNode linkedListWithArray:listArray];
    listArray = @[@(1), @(9)];
    secondNumberList = [LinkedListNode linkedListWithArray:listArray];
    sumNumberList = [CrackingLinkedLists addReverseOrderNumberList:firstNumberList withNumberList:secondNumberList];
    resultArray = @[@(4), @(1), @(2)];
    XCTAssertEqualObjects([sumNumberList dataArrayFromList], resultArray);
    
    sumNumberList = [CrackingLinkedLists addReverseOrderNumberList:firstNumberList withNumberList:secondNumberList carry:0];
    resultArray = @[@(4), @(1), @(2)];
    XCTAssertEqualObjects([sumNumberList dataArrayFromList], resultArray);
    
    listArray = @[@(3), @(2), @(1)];
    firstNumberList = [LinkedListNode linkedListWithArray:listArray];
    listArray = @[@(1), @(0), @(9)];
    secondNumberList = [LinkedListNode linkedListWithArray:listArray];
    sumNumberList = [CrackingLinkedLists addReverseOrderNumberList:firstNumberList withNumberList:secondNumberList];
    resultArray = @[@(4), @(2), @(0), @(1)];
    XCTAssertEqualObjects([sumNumberList dataArrayFromList], resultArray);
    
    sumNumberList = [CrackingLinkedLists addReverseOrderNumberList:firstNumberList withNumberList:secondNumberList carry:0];
    resultArray = @[@(4), @(2), @(0), @(1)];
    XCTAssertEqualObjects([sumNumberList dataArrayFromList], resultArray);
    
    // test forward-orderred number list
    listArray = @[@(6), @(1), @(7)];
    firstNumberList = [LinkedListNode linkedListWithArray:listArray];
    listArray = @[@(2), @(9), @(5)];
    secondNumberList = [LinkedListNode linkedListWithArray:listArray];
    sumNumberList = [CrackingLinkedLists addForwardOrderNumberList:firstNumberList withNumberList:secondNumberList];
    resultArray = @[@(9), @(1), @(2)];
    XCTAssertEqualObjects([sumNumberList dataArrayFromList], resultArray);
    
    listArray = @[@(1), @(2), @(3)];
    firstNumberList = [LinkedListNode linkedListWithArray:listArray];
    listArray = @[@(9), @(8), @(7)];
    secondNumberList = [LinkedListNode linkedListWithArray:listArray];
    sumNumberList = [CrackingLinkedLists addForwardOrderNumberList:firstNumberList withNumberList:secondNumberList];
    resultArray = @[@(1), @(1), @(1), @(0)];
    XCTAssertEqualObjects([sumNumberList dataArrayFromList], resultArray);
    
    listArray = @[@(5), @(1), @(2), @(3)];
    firstNumberList = [LinkedListNode linkedListWithArray:listArray];
    listArray = @[@(9), @(8), @(7)];
    secondNumberList = [LinkedListNode linkedListWithArray:listArray];
    sumNumberList = [CrackingLinkedLists addForwardOrderNumberList:firstNumberList withNumberList:secondNumberList];
    resultArray = @[@(6), @(1), @(1), @(0)];
    XCTAssertEqualObjects([sumNumberList dataArrayFromList], resultArray);
    
    listArray = @[@(5), @(1), @(2), @(3)];
    firstNumberList = [LinkedListNode linkedListWithArray:listArray];
    listArray = @[@(9)];
    secondNumberList = [LinkedListNode linkedListWithArray:listArray];
    sumNumberList = [CrackingLinkedLists addForwardOrderNumberList:firstNumberList withNumberList:secondNumberList];
    resultArray = @[@(5), @(1), @(3), @(2)];
    XCTAssertEqualObjects([sumNumberList dataArrayFromList], resultArray);
}

@end
