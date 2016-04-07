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
#import "GraphNode.h"
#import "LinkedObjectListNode.h"
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

- (void)testHasRouteBetweenGraphNodes {
    NSArray *graphNodes = [self createTestGraphNodes];
    GraphNode *startNode = graphNodes[2];
    GraphNode *endNode = [GraphNode nodeWithData:@(99)];
    XCTAssertFalse([CrackingTreesAndGraphs hasRouteBetweenGraphNode:startNode andNode:endNode]);
    
    [self resetGraphNodes:graphNodes];
    endNode = graphNodes[4];
    XCTAssertTrue([CrackingTreesAndGraphs hasRouteBetweenGraphNode:startNode andNode:endNode]);
}

- (void)testBinarySearchTreeWithMinimalHeight {
    NSArray *dataArray = @[@(1), @(2), @(3), @(4), @(5), @(6)];
    BinaryTreeNode *tree = [CrackingTreesAndGraphs binarySearchTreeWithMinimalHeightFrom:dataArray];
    /**
                3
              /   \
            1       5
             \     / \
              2   4   6
     */
    NSArray *expectArray = @[@(3), @(1), @(5), @(2), @(4), @(6)];
    NSArray *actualArray = [self arrayResultFromTree:tree];
    XCTAssertEqualObjects(expectArray, actualArray);
    
    /**
     - A tree consisting of only a root node has a height of 0
     - n >= power(2, h)
     */
    NSInteger minimumHeight = floor(log2(dataArray.count));
    XCTAssertEqual(minimumHeight, [BinaryTreeNode heightOfTree:tree]);
    
    dataArray = @[@(1), @(2), @(3), @(4), @(5), @(6), @(7)];
    tree = [CrackingTreesAndGraphs binarySearchTreeWithMinimalHeightFrom:dataArray];
    /**
               4
             /   \
            2     6
           / \   / \
          1   3 5   7
     */
    expectArray = @[@(4), @(2), @(6), @(1), @(3), @(5), @(7)];
    actualArray = [self arrayResultFromTree:tree];
    XCTAssertEqualObjects(expectArray, actualArray);
    minimumHeight = floor(log2(dataArray.count));
    XCTAssertEqual(minimumHeight, [BinaryTreeNode heightOfTree:tree]);
}

- (void)testArrayOfLinkedListForEachDepth {
    NSArray *testArray = @[@(1), @(2), @(3),@(4), @(5), @(6)];
    BinaryTreeNode *tree = [self binaryTreeFromArray:testArray];
    NSArray *linkedListArray = [CrackingTreesAndGraphs arrayOfLinkedListForEachDepth:tree];
    
    XCTAssertEqual(linkedListArray.count, 3);
    
    LinkedObjectListNode *depthZeroLinkedList = linkedListArray[0];
    NSArray *resultArray = @[@(1)];
    XCTAssertEqualObjects([depthZeroLinkedList dataArrayFromList], resultArray);
    
    LinkedObjectListNode *depthOneLinkedList = linkedListArray[1];
    resultArray = @[@(2), @(3)];
    XCTAssertEqualObjects([depthOneLinkedList dataArrayFromList], resultArray);
    
    LinkedObjectListNode *depthTwoLinkedList = linkedListArray[2];
    resultArray = @[@(4), @(5), @(6)];
    XCTAssertEqualObjects([depthTwoLinkedList dataArrayFromList], resultArray);
    
    linkedListArray = [CrackingTreesAndGraphs arrayOfLinkedListForEachDepthByDFS:tree];
    
    XCTAssertEqual(linkedListArray.count, 3);
    
    depthZeroLinkedList = linkedListArray[0];
    resultArray = @[@(1)];
    XCTAssertEqualObjects([depthZeroLinkedList dataArrayFromList], resultArray);
    
    depthOneLinkedList = linkedListArray[1];
    resultArray = @[@(2), @(3)];
    XCTAssertEqualObjects([depthOneLinkedList dataArrayFromList], resultArray);
    
    depthTwoLinkedList = linkedListArray[2];
    resultArray = @[@(4), @(5), @(6)];
    XCTAssertEqualObjects([depthTwoLinkedList dataArrayFromList], resultArray);
}

- (void)testIsBinaryTreeBinarySearchTree {
    NSArray *dataArray = @[@(1), @(2), @(3), @(4), @(5), @(6)];
    BinaryTreeNode *tree = [CrackingTreesAndGraphs binarySearchTreeWithMinimalHeightFrom:dataArray];
    XCTAssertTrue([CrackingTreesAndGraphs isBinaryTreeBinarySearchTree:tree]);
    XCTAssertTrue([CrackingTreesAndGraphs isBinaryTreeBinarySearchTreeByInOrderTraversal:tree]);
    
    // because (1) is in the right subtree of root node (2), this breaks binary search tree
    BinaryTreeNode *newRoot = [BinaryTreeNode treeNodeWithData:@(2) parent:nil];
    newRoot.rightChild = tree;
    XCTAssertFalse([CrackingTreesAndGraphs isBinaryTreeBinarySearchTree:newRoot]);
    XCTAssertFalse([CrackingTreesAndGraphs isBinaryTreeBinarySearchTreeByInOrderTraversal:newRoot]);
    
    
    tree = [self binaryTreeFromArray:dataArray];
    XCTAssertFalse([CrackingTreesAndGraphs isBinaryTreeBinarySearchTree:tree]);
    XCTAssertFalse([CrackingTreesAndGraphs isBinaryTreeBinarySearchTreeByInOrderTraversal:tree]);
}

- (void)testNextInOrderNodeOfNodeInBinarySearchTree {
    NSArray *dataArray = @[@(1), @(2), @(3), @(4), @(5), @(6)];
    BinaryTreeNode *tree = [CrackingTreesAndGraphs binarySearchTreeWithMinimalHeightFrom:dataArray];
    /**
            3
          /   \
        1       5
         \     / \
          2   4   6
     */
    BinaryTreeNode *nodeOne = tree.leftChild;
    BinaryTreeNode *nextNode = [CrackingTreesAndGraphs nextInOrderNodeOfNodeInBinarySearchTree:nodeOne];
    XCTAssertEqualObjects(nextNode.data, @(2));
    
    BinaryTreeNode *nodeTwo = tree.leftChild.rightChild;
    nextNode = [CrackingTreesAndGraphs nextInOrderNodeOfNodeInBinarySearchTree:nodeTwo];
    XCTAssertEqualObjects(nextNode.data, @(3));
    
    BinaryTreeNode *nodeFour = tree.rightChild.leftChild;
    nextNode = [CrackingTreesAndGraphs nextInOrderNodeOfNodeInBinarySearchTree:nodeFour];
    XCTAssertEqualObjects(nextNode.data, @(5));
    
    BinaryTreeNode *nodeSix = tree.rightChild.rightChild;
    nextNode = [CrackingTreesAndGraphs nextInOrderNodeOfNodeInBinarySearchTree:nodeSix];
    XCTAssertNil(nextNode);
    
}

- (void)testFirstCommonAncestorOfNodes {
    NSArray *testArray = @[@(1), @(2), @(3),@(4), @(5), @(6)];
    BinaryTreeNode *binaryTree = [self binaryTreeFromArray:testArray];
    /**
     Binary tree:
            1
           / \
         2     3
        / \   /
       4   5 6
     */
    BinaryTreeNode *nodeFour = binaryTree.leftChild.leftChild;
    BinaryTreeNode *nodeSix = binaryTree.rightChild.leftChild;
    
    BinaryTreeNode *commonParent = [CrackingTreesAndGraphs firstCommonAncestorOfNode:nodeFour andNode:nodeSix inTree:binaryTree];
    XCTAssertEqualObjects(commonParent.data, @(1));
    commonParent = [CrackingTreesAndGraphs betterFirstCommonAncestorOfNode:nodeFour andNode:nodeSix inTree:binaryTree];
    XCTAssertEqualObjects(commonParent.data, @(1));
    
    BinaryTreeNode *nodeFive = binaryTree.leftChild.rightChild;
    commonParent = [CrackingTreesAndGraphs firstCommonAncestorOfNode:nodeFour andNode:nodeFive inTree:binaryTree];
    XCTAssertEqualObjects(commonParent.data, @(2));
    commonParent = [CrackingTreesAndGraphs betterFirstCommonAncestorOfNode:nodeFour andNode:nodeFive inTree:binaryTree];
    XCTAssertEqualObjects(commonParent.data, @(2));
    
}

- (void)testSubTreeOfTree {
    NSArray *testArray = @[@(1), @(2), @(3),@(4), @(5), @(6)];
    BinaryTreeNode *bigBinaryTree = [self binaryTreeFromArray:testArray];
    
    testArray = @[@(2), @(4), @(5)];
    BinaryTreeNode *smallBinaryTree = [self binaryTreeFromArray:testArray];
    XCTAssertTrue([CrackingTreesAndGraphs isTree:smallBinaryTree subTreeOfTree:bigBinaryTree]);
    
    testArray = @[@(2), @(99), @(5)];
    smallBinaryTree = [self binaryTreeFromArray:testArray];
    XCTAssertFalse([CrackingTreesAndGraphs isTree:smallBinaryTree subTreeOfTree:bigBinaryTree]);
    
    testArray = @[@(2), @(5)];
    smallBinaryTree = [self binaryTreeFromArray:testArray];
    XCTAssertFalse([CrackingTreesAndGraphs isTree:smallBinaryTree subTreeOfTree:bigBinaryTree]);
    
    testArray = @[@(2), @(4)];
    smallBinaryTree = [self binaryTreeFromArray:testArray];
    XCTAssertFalse([CrackingTreesAndGraphs isTree:smallBinaryTree subTreeOfTree:bigBinaryTree]);
    
    testArray = @[@(3), @(6)];
    smallBinaryTree = [self binaryTreeFromArray:testArray];
    XCTAssertTrue([CrackingTreesAndGraphs isTree:smallBinaryTree subTreeOfTree:bigBinaryTree]);
}

- (void)testPathsInBinaryTreeWithSum {
    NSArray *testArray = @[@(1), @(2), @(3),@(4), @(5), @(6), @(7), @(-4)];
    BinaryTreeNode *binaryTree = [self binaryTreeFromArray:testArray];
    [CrackingTreesAndGraphs printPathsInBinaryTree:binaryTree whichSumIs:3];
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

- (NSArray *)createTestGraphNodes {
    /**
            1 - 5
          /   \
        2       3
          \   /
            4
     */
    GraphNode *graphNode1 = [GraphNode nodeWithData:@(1)];
    GraphNode *graphNode2 = [GraphNode nodeWithData:@(2)];
    GraphNode *graphNode3 = [GraphNode nodeWithData:@(3)];
    GraphNode *graphNode4 = [GraphNode nodeWithData:@(4)];
    GraphNode *graphNode5 = [GraphNode nodeWithData:@(5)];
    
    [graphNode1 addAdjacents:@[graphNode2, graphNode3, graphNode5]];
    [graphNode2 addAdjacents:@[graphNode1, graphNode4]];
    [graphNode3 addAdjacents:@[graphNode1, graphNode4]];
    [graphNode4 addAdjacents:@[graphNode2, graphNode3]];
    [graphNode5 addAdjacents:@[graphNode1]];
    
    return @[graphNode1, graphNode2, graphNode3, graphNode4, graphNode5];
}

- (void)resetGraphNodes:(NSArray *)nodes {
    for (GraphNode *node in nodes) {
        node.visitState = GraphNodeNotVisited;
    }
}

- (NSArray *)arrayResultFromTree:(BinaryTreeNode *)tree {
    NSMutableArray *resultArray = [NSMutableArray array];
    [BinaryTreeNode breadthFirstSearch:tree action:^(BinaryTreeNode *node) {
        [resultArray addObject:node.data];
    }];
    return resultArray;
}

@end
