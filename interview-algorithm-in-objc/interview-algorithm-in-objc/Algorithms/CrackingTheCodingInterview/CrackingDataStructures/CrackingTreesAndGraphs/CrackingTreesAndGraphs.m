//
//  CrackingTreesAndGraphs.m
//  interview-algorithm-in-objc
//
//  Created by Bin Yu on 03/04/16.
//  Copyright © 2016 Bin Yu. All rights reserved.
//

#import "CrackingTreesAndGraphs.h"
#import "BinaryTreeNode.h"
#import "GraphNode.h"
#import "LinkedObjectListNode.h"

/**
 - Graph: https://en.wikipedia.org/wiki/Graph_(abstract_data_type)
 - Graph traversal: https://en.wikipedia.org/wiki/Graph_traversal
 - Binary tree: https://en.wikipedia.org/wiki/Binary_tree
 - Tree traversal: https://en.wikipedia.org/wiki/Tree_traversal
 - A tree is a connected graph with no cycles.
 - A forest is a graph with no cycles, i.e. the disjoint union of one or more trees.
 - tree traversal (also known as tree search) is a form of graph traversal and refers 
 to the process of visiting (checking and/or updating) each node in a tree data structure,
 exactly once.
 - Depth-first search (DFS): Trees can be traversed in pre-order, in-order, or post-order
 - Breadth-first search (BFS): Trees are traversed in level-order, where we visit every node 
 on a level before going to a lower level.
 - Self-balancing binary search tree: https://en.wikipedia.org/wiki/Self-balancing_binary_search_tree
 These structures provide efficient implementations for mutable ordered lists, and can be used 
 for other abstract data structures such as associative arrays, priority queues and sets.
 - the minimum height of a tree with n nodes is log2(n)
 - AVL tree (Georgy Adelson-Velsky and Evgenii Landis' tree, named after the inventors) is a 
 self-balancing binary search tree. https://en.wikipedia.org/wiki/AVL_tree
 - In an AVL tree, the heights of the two child subtrees of any node differ by at most one; 
 if at any time they differ by more than one, rebalancing is done to restore this property. 
 Lookup, insertion, and deletion all take O(log n) time in both the average and worst cases, 
 where n is the number of nodes in the tree prior to the operation.
 - Red-black tree: https://en.wikipedia.org/wiki/Red%E2%80%93black_tree
 - Binary search trees (BST), sometimes called ordered or sorted binary trees, are a particular 
 type of containers: data structures that store "items" (such as numbers, names etc.) in memory.
 They allow fast lookup, addition and removal of items, and can be used to implement either dynamic 
 sets of items, or lookup tables that allow finding an item by its key (e.g., finding the phone number 
 of a person by name).
 - Heap: https://en.wikipedia.org/wiki/Heap_(data_structure)
 A heap can be classified further as either a "max heap" or a "min heap". In a max heap, the keys 
 of parent nodes are always greater than or equal to those of the children and the highest key is in 
 the root node. In a min heap, the keys of parent nodes are less than or equal to those of the children
 and the lowest key is in the root node.
 In a heap, the highest (or lowest) priority element is always stored at the root.
 - Binary Heap: https://en.wikipedia.org/wiki/Binary_heap
 - Trie: https://en.wikipedia.org/wiki/Trie
 */

@implementation CrackingTreesAndGraphs

/**
 Implement a function to check if a binary tree is balanced. For the purposes of this question, 
 a balanced tree is defined to be a tree such that the heights of the two subtrees of any node 
 never differ by more than one.
 */

/**
 - it's not very efficient.
 - On each node, we recurse through its entire subtree.
 This means that getHeight is called repeatedly on the same nodes.
 The algorithm is therefore O(N*N)
*/
+ (BOOL)isBinaryTreeBalanced:(BinaryTreeNode *)binaryTree {
    if (!binaryTree) {
        return YES;
    }
    NSInteger heightDiff =
    [BinaryTreeNode heightOfTree:binaryTree.leftChild] - [BinaryTreeNode heightOfTree:binaryTree.rightChild];
    if (ABS(heightDiff) > 1) {
        return NO;
    }
    return [self isBinaryTreeBalanced:binaryTree.leftChild] &&
    [self isBinaryTreeBalanced:binaryTree.rightChild];
}

/**
 0(N) time and 0(H) space, where H is the height of the tree
 */

+ (BOOL)betterIsBinaryTreeBalanced:(BinaryTreeNode *)binaryTree {
    return [self checkHeight:binaryTree] != -1;
}

+ (NSInteger)checkHeight:(BinaryTreeNode *)root {
    if (!root) {
        return 0;
    }
    NSInteger leftHeight = [self checkHeight:root.leftChild];
    if (leftHeight == -1) {
        return -1;
    }
    NSInteger rightHeight = [self checkHeight:root.rightChild];
    if (rightHeight == -1) {
        return -1;
    }
    NSInteger heightDiff = leftHeight - rightHeight;
    if (ABS(heightDiff) > 1) {
        return -1;
    }
    return MAX(leftHeight, rightHeight) + 1;
}

/**
 Given a directed graph, design an algorithm to find out whether there is a route between two nodes.
 */

/**
 - A directed graph is called a simple digraph if it has no multiple arrows (two or more edges that 
 connect the same two vertices in the same direction) and no loops (edges that connect vertices to themselves).
 - A directed graph is called a directed multigraph or multidigraph if it may have multiple arrows (and sometimes loops).
 */

+ (BOOL)hasRouteBetweenGraphNode:(GraphNode *)thisNode andNode:(GraphNode *)thatNode {
    __block BOOL hasRoute = NO;
    [GraphNode breadthFirstTraverse:thisNode withAction:^(GraphNode *node) {
        /**
         - TODO: add '*stop' flag to jump out of traverse
         - depthFirstTraverse also works.
         - depth first search is a bit simpler to implement since it can be done with simple recursion. 
         Breadth first search can also be useful to find the shortest path, whereas depth first search 
         may traverse one adjacent node very deeply before ever going onto the immediate neigh- bors
         */
        if (node == thatNode) {
            hasRoute = YES;
        }
    }];
    return hasRoute;
}

/**
 Given a sorted (increasing order) array with unique integer elements, write an algorithm
 to create a binary search tree with minimal height.
 */

/**
 - binary search uses the same way to decide 'middle' index
 */

+ (BinaryTreeNode *)binarySearchTreeWithMinimalHeightFrom:(NSArray *)array {
    return [self binarySearchTreeWithArray:array startIndex:0 endIndex:array.count - 1];
}

+ (BinaryTreeNode *)binarySearchTreeWithArray:(NSArray *)array startIndex:(NSInteger)startIndex endIndex:(NSInteger)endIndex {
    if (startIndex > endIndex) {
        return nil;
    }
    NSInteger midIndex = (startIndex + endIndex) / 2;
    BinaryTreeNode *node = [BinaryTreeNode treeNodeWithData:array[midIndex] parent:nil];
    node.leftChild = [self binarySearchTreeWithArray:array startIndex:startIndex endIndex:midIndex-1];
    node.rightChild = [self binarySearchTreeWithArray:array startIndex:midIndex+1 endIndex:endIndex];
    return node;
}

/**
 Given a binary tree, design an algorithm which creates a linked list of all the nodes at 
 each depth (e.g., if you have a tree with depth D, you'll have D linked lists).
 */

+ (NSArray *)arrayOfLinkedListForEachDepth:(BinaryTreeNode *)tree {
    /**
     - TODO: it is better to have a modified breadth search traversal method
     */
    __block NSMutableArray *linkedListArray = [NSMutableArray array];
    __block NSInteger depth = 0;
    __block NSInteger counter = 0;
    __block LinkedObjectListNode *list = nil;
    [BinaryTreeNode breadthFirstSearch:tree action:^(BinaryTreeNode *node) {
        if (counter < pow(2, depth)) {
            if (!list) {
                list = [LinkedObjectListNode nodeWithData:node.data];
            } else {
                [list appendNodeToEnd:node.data];
            }
            counter++;
        } else {
            [linkedListArray addObject:list];
            depth++;
            counter = 1;
            list = [LinkedObjectListNode nodeWithData:node.data];
        }
    }];
    [linkedListArray addObject:list];
    return linkedListArray;
}

+ (NSArray *)arrayOfLinkedListForEachDepthByDFS:(BinaryTreeNode *)tree {
    NSMutableArray *linkedListArray = [NSMutableArray array];
    [self arrayOfLinkedListOfTree:tree linkedListArray:linkedListArray level:0];
    return linkedListArray;
}

+ (void)arrayOfLinkedListOfTree:(BinaryTreeNode *)root linkedListArray:(NSMutableArray *)array level:(NSInteger)level {
    if (!root) {
        return;
    }
    LinkedObjectListNode *levelList = nil;
    if (array.count == level) {
        levelList = [LinkedObjectListNode nodeWithData:root.data];
        [array addObject:levelList];
    } else {
        levelList = array[level];
        [levelList appendNodeToEnd:root.data];
    }
    [self arrayOfLinkedListOfTree:root.leftChild linkedListArray:array level:level + 1];
    [self arrayOfLinkedListOfTree:root.rightChild linkedListArray:array level:level + 1];
}

/**
 Implement a function to check if a binary tree is a binary search tree.
 */

+ (BOOL)isBinaryTreeBinarySearchTree:(BinaryTreeNode *)root {
    /**
     - Following tree is NOT NOT NOT binary search tree,
     because 20 is smaller than 25, which is on 20's left subtree
            20
          /    \
        10      30
          \
            25
     - More precisely, the condition of binary search tree is that: 
     ALL left nodes must be less than or equal to the current node, 
     which must be less than all the right nodes.
     */
    return [self isBinaryTreeBinarySearchTree:root minValue:LONG_MIN maxValue:LONG_MAX];
}

+ (BOOL)isBinaryTreeBinarySearchTree:(BinaryTreeNode *)root minValue:(NSInteger)min maxValue:(NSInteger)max {
    if (!root) {
        return YES;
    }
    NSInteger data = [root.data integerValue];
    if (data <= min || data > max) {
        return NO;
    }
    return [self isBinaryTreeBinarySearchTree:root.leftChild minValue:min maxValue:[root.data integerValue]] &&
    [self isBinaryTreeBinarySearchTree:root.rightChild minValue:[root.data integerValue] maxValue:max];
}

+ (BOOL)isBinaryTreeBinarySearchTreeByInOrderTraversal:(BinaryTreeNode *)root {
    /**
     - using In-Order depth traversal, in order to make use of it's special traversal order
     - keep the last visited node in external static variable
     */
    BinaryTreeNode *lastVisitedNode = nil;
    return [self isBinaryTreeBinarySearchTreeByInOrderTraversal:root lastVisitedNode:&lastVisitedNode];
}

+ (BOOL)isBinaryTreeBinarySearchTreeByInOrderTraversal:(BinaryTreeNode *)root lastVisitedNode:(BinaryTreeNode **)lastVisitedNode {
    if (!root) {
        return YES;
    }
    if (![self isBinaryTreeBinarySearchTreeByInOrderTraversal:root.leftChild lastVisitedNode:lastVisitedNode]) {
        return NO;
    }
    if (*lastVisitedNode && [root.data integerValue] < [(*lastVisitedNode).data integerValue]) {
        return NO;
    }
    *lastVisitedNode = root;
    if (![self isBinaryTreeBinarySearchTreeByInOrderTraversal:root.rightChild lastVisitedNode:lastVisitedNode]) {
        return NO;
    }
    return YES;
}

/**
 Write an algorithm to find the 'next' node (i.e., in-order successor) of a given node in a binary
 search tree. You may assume that each node has a link to its parent.
 */

+ (BinaryTreeNode *)nextInOrderNodeOfNodeInBinarySearchTree:(BinaryTreeNode *)node {
    /**
     - This is not the most algorithmically complex problem in the world, but it can be tricky to code perfectly. 
     - In a problem like this, it's useful to sketch out pseudocode to carefully outline the different cases.
     */
    if (!node) {
        nil;
    }
    if (node.rightChild) {
        return [self leftMostNodeOfNode:node.rightChild];
    }
    while (node.parent && node.parent.leftChild != node) {
        node = node.parent;
    }
    return node.parent;
}

+ (BinaryTreeNode *)leftMostNodeOfNode:(BinaryTreeNode *)node {
    if (!node) {
        return nil;
    }
    while (node.leftChild) {
        node = node.leftChild;
    }
    return node;
}

/**
 Design an algorithm and write code to find the first common ancestor of two nodes in a binary tree. 
 Avoid storing additional nodes in a data structure. NOTE: This is not necessarily a binary search tree.
 */

+ (BinaryTreeNode *)firstCommonAncestorOfNode:(BinaryTreeNode *)thisNode andNode:(BinaryTreeNode *)thatNode
                                       inTree:(BinaryTreeNode *)treeRoot {
    if (!treeRoot) {
        return nil;
    }
    if (treeRoot == thisNode || treeRoot == thatNode) {
        return treeRoot;
    }
    BOOL isThisNodeOnLeft = [self checkNode:thisNode isInSubtreeOfNode:treeRoot.leftChild];
    BOOL isThatNodeOnLeft = [self checkNode:thatNode isInSubtreeOfNode:treeRoot.leftChild];
    if (isThisNodeOnLeft != isThatNodeOnLeft) {
        return treeRoot;
    }
    BinaryTreeNode *nextRoot = isThisNodeOnLeft ? treeRoot.leftChild : treeRoot.rightChild;
    return [self firstCommonAncestorOfNode:thisNode andNode:thatNode inTree:nextRoot];
}

+ (BOOL)checkNode:(BinaryTreeNode *)childNode isInSubtreeOfNode:(BinaryTreeNode *)parentNode {
    if (!childNode || !parentNode) {
        return NO;
    }
    if (childNode == parentNode) {
        return YES;
    }
    return [self checkNode:childNode isInSubtreeOfNode:parentNode.leftChild] ||
    [self checkNode:childNode isInSubtreeOfNode:parentNode.rightChild];
}

+ (BinaryTreeNode *)betterFirstCommonAncestorOfNode:(BinaryTreeNode *)thisNode andNode:(BinaryTreeNode *)thatNode
                                             inTree:(BinaryTreeNode *)treeRoot {
    BOOL isAncestor = NO;
    BinaryTreeNode *commonAncestor =
    [self betterFirstCommonAncestorOfNode:thisNode andNode:thatNode inTree:treeRoot isAncestor:&isAncestor];
    if (isAncestor) {
        return commonAncestor;
    }
    return nil;
}

+ (BinaryTreeNode *)betterFirstCommonAncestorOfNode:(BinaryTreeNode *)thisNode andNode:(BinaryTreeNode *)thatNode
                                             inTree:(BinaryTreeNode *)treeRoot isAncestor:(BOOL *)isAncestor {
    if (!treeRoot) {
        *isAncestor = NO;
        return nil;
    }
    
    if (treeRoot == thisNode && treeRoot == thatNode) {
        *isAncestor = YES;
        return treeRoot;
    }
    
    BinaryTreeNode *rx =
    [self betterFirstCommonAncestorOfNode:thisNode andNode:thatNode inTree:treeRoot.leftChild
                                                    isAncestor:isAncestor];
    if (*isAncestor) {
        return rx;
    }
    
    BinaryTreeNode *ry =
    [self betterFirstCommonAncestorOfNode:thisNode andNode:thatNode inTree:treeRoot.rightChild
                               isAncestor:isAncestor];
    if (*isAncestor) {
        return ry;
    }
    
    if (rx && ry) {
        *isAncestor = YES;
        return treeRoot;
    } else if (treeRoot == thisNode || treeRoot == thatNode) {
        *isAncestor = rx || ry ? YES : NO;
        return treeRoot;
    } else {
        *isAncestor = NO;
        return rx ? rx : ry;
    }
}

/**
 You have two very large binary trees: T1, with millions of nodes, and T2, with hundreds of nodes.
 Create an algorithm to decide if T2 is a subtree of T1.
 
 A tree T2 is a subtree of T1 if there exists a node n in T1 such that the subtree of n is identical to T2. 
 That is, if you cut off the tree at node n, the two trees would be identical.
 */

+ (BOOL)isTree:(BinaryTreeNode *)t2 subTreeOfTree:(BinaryTreeNode *)t1 {
    /**
     (My) Solution:
     - Pre-order DFS to find the position of root node of t2 in t1, that is, n (maybe more than one n in T1)
     - traverse n and t2 at the same time with DFS; make sure every node in n and t2 are same
     - 0(log(n) + log(m))
     
     Simple Solution (But not good):
     - check if Pre-order and In-order traversal string of t2 is 'substring' of 
     Pre-order and In-order traversal string of t1
     - 0(n + m) memory
     */
    if (!t2) {
        return NO;
    }
    return [self findNode:t2 inTree:t1];
}

+ (BOOL)findNode:(BinaryTreeNode *)node inTree:(BinaryTreeNode *)tree {
    if (!tree) {
        return NO;
    }
    if ([node.data isEqualToNumber:tree.data]) {
        if ([self matchTree:node withTree:tree]) {
            return YES;
        }
    }
    return [self findNode:node inTree:tree.leftChild] ||
    [self findNode:node inTree:tree.rightChild];
}

+ (BOOL)matchTree:(BinaryTreeNode *)thisTree withTree:(BinaryTreeNode *)thatTree {
    if (!thisTree && !thatTree) {
        return YES;
    }
    
    if (!thisTree || !thatTree) {
        return NO;
    }
    
    if (![thisTree.data isEqualToNumber:thatTree.data]) {
        return NO;
    }
    return [self matchTree:thisTree.leftChild withTree:thatTree.leftChild] &&
    [self matchTree:thisTree.rightChild withTree:thatTree.rightChild];
}

/**
 You are given a binary tree in which each node contains a value. Design an algorithm to print all 
 paths which sum to a given value. The path does not need to start or end at the root or a leaf.
 */

+ (void)printPathsInBinaryTree:(BinaryTreeNode *)rootNode whichSumIs:(NSInteger)sum {
    NSMutableArray *pathArray = [NSMutableArray array];
    NSInteger treeDepth = [BinaryTreeNode heightOfTree:rootNode]+1;
    // HACK: we MUST initialize array will null, in order to use subscript index
    for (NSInteger i=0; i<treeDepth; i++) {
        [pathArray addObject:[NSNull null]];
    }
    [self printPathInBinaryTree:rootNode whichSubIs:sum toArray:pathArray level:0];
}

+ (void)printPathInBinaryTree:(BinaryTreeNode *)rootNode whichSubIs:(NSInteger)sum toArray:(NSMutableArray *)pathArray level:(NSInteger)level {
    /**
     TIP: we SHOULD NOT stop traversing when path sum equals to sum, e.g.:
     1 + 3 = 4
     1 + 3 - 2 + 5 - 3 = 4
     */
    if (!rootNode) {
        return;
    }
    pathArray[level] = rootNode.data;
    NSInteger pathSum = 0;
    for (NSInteger i=level; i>=0; i--) {
        pathSum += [pathArray[i] integerValue];
        if (pathSum == sum) {
            [self printPath:pathArray start:i end:level];
        }
    }
    
    [self printPathInBinaryTree:rootNode.leftChild whichSubIs:sum toArray:pathArray level:level+1];
    [self printPathInBinaryTree:rootNode.rightChild whichSubIs:sum toArray:pathArray level:level+1];
    
    pathArray[level] = @(LONG_MIN);
}

+ (void)printPath:(NSArray *)pathArray start:(NSInteger)start end:(NSInteger)end {
    NSArray *realPathArray = [pathArray subarrayWithRange:NSMakeRange(start, end-start+1)];
    NSLog(@"Path: %@", [realPathArray componentsJoinedByString:@" -> "]);
}

@end
