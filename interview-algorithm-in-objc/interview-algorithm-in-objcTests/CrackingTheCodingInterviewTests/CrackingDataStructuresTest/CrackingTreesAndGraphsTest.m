//
//  CrackingTreesAndGraphsTest.m
//  interview-algorithm-in-objc
//
//  Created by Bin Yu on 03/04/16.
//  Copyright © 2016 Bin Yu. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "BinaryTreeNode.h"
#import "CrackingTreesAndGraphs.h"
#import "Queue.h"

@interface CrackingTreesAndGraphsTest : XCTestCase

@end

@implementation CrackingTreesAndGraphsTest

- (void)setUp {
    [super setUp];
}

- (void)tearDown {
    [super tearDown];
}

- (void)testBinaryTree {
    /**
     Binary tree:
            1
           / \
         2     3
        / \   /
       4   5 6
     */
    NSArray *testArray = @[@(1), @(2), @(3),@(4), @(5), @(6)];
    BinaryTreeNode *binaryTree = [self binaryTreeFromArray:testArray];
    NSArray *expectArray = @[@(1), @(2), @(3), @(4), @(5), @(6)];
    NSMutableArray *actualArray = [NSMutableArray array];
    
    [BinaryTreeNode breadthFirstSearch:binaryTree action:^(BinaryTreeNode *node) {
        [actualArray addObject:node.data];
    }];
    
    XCTAssertEqualObjects(actualArray, expectArray);
    [actualArray removeAllObjects];
    
    expectArray = @[@(1), @(2), @(4), @(5), @(3), @(6)];
    [BinaryTreeNode depthFirstSearch:binaryTree action:^(BinaryTreeNode *node) {
        [actualArray addObject:node.data];
    } order:DepthFirstSearchPreOrder];
    XCTAssertEqualObjects(actualArray, expectArray);
    [actualArray removeAllObjects];
    
    expectArray = @[@(4), @(2), @(5), @(1), @(6), @(3)];
    [BinaryTreeNode depthFirstSearch:binaryTree action:^(BinaryTreeNode *node) {
        [actualArray addObject:node.data];
    } order:DepthFirstSearchInOrder];
    XCTAssertEqualObjects(actualArray, expectArray);
    [actualArray removeAllObjects];
    
    expectArray = @[@(4), @(5), @(2), @(6), @(3), @(1)];
    [BinaryTreeNode depthFirstSearch:binaryTree action:^(BinaryTreeNode *node) {
        [actualArray addObject:node.data];
    } order:DepthFirstSearchPostOrder];
    XCTAssertEqualObjects(actualArray, expectArray);
}

- (void)testIsBalancedBinaryTree {
    NSArray *testArray = @[@(1), @(2), @(3),@(4), @(5), @(6)];
    BinaryTreeNode *binaryTree = [self binaryTreeFromArray:testArray];
    XCTAssertTrue([CrackingTreesAndGraphs isBinaryTreeBalanced:binaryTree]);
    XCTAssertTrue([CrackingTreesAndGraphs betterIsBinaryTreeBalanced:binaryTree]);
    
    [BinaryTreeNode depthFirstSearch:binaryTree action:^(BinaryTreeNode *node) {
        NSInteger data = [node.data integerValue];
        if (data == 5) {
            BinaryTreeNode *number7 = [BinaryTreeNode treeNodeWithData:@(7) parent:node];
            BinaryTreeNode *number8 = [BinaryTreeNode treeNodeWithData:@(8) parent:number7];
            number7.leftChild = number8;
            node.rightChild = number7;
        }
    } order:DepthFirstSearchPreOrder];
    
    NSArray *expectArray = @[@(1), @(2), @(3),@(4), @(5), @(6), @(7), @(8)];
    NSMutableArray *actualArray = [NSMutableArray array];
    [BinaryTreeNode breadthFirstSearch:binaryTree action:^(BinaryTreeNode *node) {
        [actualArray addObject:node.data];
    }];
    XCTAssertEqualObjects(actualArray, expectArray);
    XCTAssertFalse([CrackingTreesAndGraphs isBinaryTreeBalanced:binaryTree]);
    XCTAssertFalse([CrackingTreesAndGraphs betterIsBinaryTreeBalanced:binaryTree]);
}

#pragma mark - Private

- (BinaryTreeNode *)binaryTreeFromArray:(NSArray *)array {
    Queue *dataQueue = [Queue queueFromArray:array];
    Queue *nodeQueue = [Queue new];
    if ([dataQueue isEmpty]) {
        return nil;
    }
    BinaryTreeNode *rootNode = [BinaryTreeNode treeNodeWithData:[dataQueue dequeue] parent:nil];
    [nodeQueue enqueue:rootNode];
    while (![dataQueue isEmpty]) {
        while (![nodeQueue isEmpty]) {
            BinaryTreeNode *rootNode = [nodeQueue dequeue];
            id data = [dataQueue dequeue];
            if (data) {
                BinaryTreeNode *leftNode = [BinaryTreeNode treeNodeWithData:data parent:rootNode];
                rootNode.leftChild = leftNode;
                [nodeQueue enqueue:leftNode];
            }
            data = [dataQueue dequeue];
            if (data) {
                BinaryTreeNode *rightNode = [BinaryTreeNode treeNodeWithData:data parent:rootNode];
                rootNode.rightChild = rightNode;
                [nodeQueue enqueue:rightNode];
            }
        }
    }
    return rootNode;
}

@end
