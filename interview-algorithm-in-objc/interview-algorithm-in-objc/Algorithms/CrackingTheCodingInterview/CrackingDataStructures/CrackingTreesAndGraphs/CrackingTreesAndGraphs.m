//
//  CrackingTreesAndGraphs.m
//  interview-algorithm-in-objc
//
//  Created by Bin Yu on 03/04/16.
//  Copyright © 2016 Bin Yu. All rights reserved.
//

#import "CrackingTreesAndGraphs.h"
#import "BinaryTreeNode.h"

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
 Given a sorted (increasing order) array with unique integer elements, write an algorithm
 to create a binary search tree with minimal height.
 */

/**
 Given a binary tree, design an algorithm which creates a linked list of all the nodes at 
 each depth (e.g., if you have a tree with depth D, you'll have D linked lists).
 */

/**
 Implement a function to check if a binary tree is a binary search tree.
 */

/**
 Write an algorithm to find the 'next' node (i.e., in-order successor) of a given node in a binary
 search tree. You may assume that each node has a link to its parent.
 */

/**
 Design an algorithm and write code to find the first common ancestor of two nodes in a binary tree. 
 Avoid storing additional nodes in a data structure. NOTE: This is not necessarily a binary search tree.
 */

/**
 You have two very large binary trees: T1, with millions of nodes, and T2, with hundreds of nodes. 
 Create an algorithm to decide if T2 is a subtree of T1.
 
 A tree T2 is a subtree of T1 if there exists a node n in T1 such that the subtree of n is identical to T2. 
 That is, if you cut off the tree at node n, the two trees would be identical.
 */

/**
 You are given a binary tree in which each node contains a value. Design an algorithm to print all 
 paths which sum to a given value. The path does not need to start or end at the root or a leaf.
 */

@end
