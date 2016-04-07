//
//  CrackingTreesAndGraphs.h
//  interview-algorithm-in-objc
//
//  Created by Bin Yu on 03/04/16.
//  Copyright © 2016 Bin Yu. All rights reserved.
//

#import <Foundation/Foundation.h>

@class BinaryTreeNode;
@class GraphNode;

@interface CrackingTreesAndGraphs : NSObject

+ (BOOL)isBinaryTreeBalanced:(BinaryTreeNode *)binaryTree;
+ (BOOL)betterIsBinaryTreeBalanced:(BinaryTreeNode *)binaryTree;
+ (BOOL)hasRouteBetweenGraphNode:(GraphNode *)thisNode andNode:(GraphNode *)thatNode;
+ (BinaryTreeNode *)binarySearchTreeWithMinimalHeightFrom:(NSArray *)array;
+ (NSArray *)arrayOfLinkedListForEachDepth:(BinaryTreeNode *)tree;
+ (NSArray *)arrayOfLinkedListForEachDepthByDFS:(BinaryTreeNode *)tree;
+ (BOOL)isBinaryTreeBinarySearchTree:(BinaryTreeNode *)root;
+ (BOOL)isBinaryTreeBinarySearchTreeByInOrderTraversal:(BinaryTreeNode *)root;
+ (BinaryTreeNode *)nextInOrderNodeOfNodeInBinarySearchTree:(BinaryTreeNode *)node;
+ (BinaryTreeNode *)firstCommonAncestorOfNode:(BinaryTreeNode *)thisNode andNode:(BinaryTreeNode *)thatNode
                                       inTree:(BinaryTreeNode *)treeRoot;
+ (BinaryTreeNode *)betterFirstCommonAncestorOfNode:(BinaryTreeNode *)thisNode andNode:(BinaryTreeNode *)thatNode
                                             inTree:(BinaryTreeNode *)treeRoot;
+ (BOOL)isTree:(BinaryTreeNode *)t2 subTreeOfTree:(BinaryTreeNode *)t1;
+ (void)printPathsInBinaryTree:(BinaryTreeNode *)rootNode whichSumIs:(NSInteger)sum;

@end
