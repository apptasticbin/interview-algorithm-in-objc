//
//  BinaryTreeNode.m
//  interview-algorithm-in-objc
//
//  Created by Bin Yu on 04/04/16.
//  Copyright © 2016 Bin Yu. All rights reserved.
//

#import "BinaryTreeNode.h"
#import "Queue.h"

@implementation BinaryTreeNode

+ (instancetype)treeNodeWithData:(id)data parent:(BinaryTreeNode *)parent {
    return [self treeNodeWithData:data parent:parent leftChild:nil rightChild:nil];
}

+ (instancetype)treeNodeWithData:(id)data parent:(BinaryTreeNode *)parent
                       leftChild:(BinaryTreeNode *)leftChild
                      rightChild:(BinaryTreeNode *)rightChild {
    return [[BinaryTreeNode alloc] initWithData:data parent:parent
                                      leftChild:leftChild
                                     rightChild:rightChild];
}

#pragma mark - Public

+ (void)depthFirstSearch:(BinaryTreeNode *)root action:(BinaryTreeSearchAction)action order:(DepthFirstSearchOrder)order {
    switch (order) {
        case DepthFirstSearchPreOrder:
            [self depthFirstPreOrderSearch:root action:action];
            break;
        case DepthFirstSearchInOrder:
            [self depthFirstInOrderSearch:root action:action];
            break;
        case DepthFirstSearchPostOrder:
            [self depthFirstPostOrderSearch:root action:action];
            break;
    }
}

+ (void)breadthFirstSearch:(BinaryTreeNode *)root action:(BinaryTreeSearchAction)action {
    Queue *nodeQueue = [Queue new];
    [self runAction:action withNode:root];
    [self enqueueNode:root toQueue:nodeQueue];
    while (![nodeQueue isEmpty]) {
        BinaryTreeNode *node = [nodeQueue dequeue];
        [self runAction:action withNode:node.leftChild];
        [self enqueueNode:node.leftChild toQueue:nodeQueue];
        [self runAction:action withNode:node.rightChild];
        [self enqueueNode:node.rightChild toQueue:nodeQueue];
    }
}

#pragma mark - Private

- (instancetype)initWithData:(id)data parent:(BinaryTreeNode *)parent
                   leftChild:(BinaryTreeNode *)leftChild
                  rightChild:(BinaryTreeNode *)rightChild {
    self = [super init];
    if (self) {
        _data = data;
        _parent = parent;
        _leftChild = leftChild;
        _rightChild = rightChild;
    }
    return self;
}

+ (void)depthFirstPreOrderSearch:(BinaryTreeNode *)root action:(BinaryTreeSearchAction)action {
    if (!root) {
        return;
    }
    [self runAction:action withNode:root];
    [self depthFirstPreOrderSearch:root.leftChild action:action];
    [self depthFirstPreOrderSearch:root.rightChild action:action];
}

+ (void)depthFirstInOrderSearch:(BinaryTreeNode *)root action:(BinaryTreeSearchAction)action {
    if (!root) {
        return;
    }
    [self depthFirstInOrderSearch:root.leftChild action:action];
    [self runAction:action withNode:root];
    [self depthFirstInOrderSearch:root.rightChild action:action];
}

+ (void)depthFirstPostOrderSearch:(BinaryTreeNode *)root action:(BinaryTreeSearchAction)action {
    if (!root) {
        return;
    }
    [self depthFirstPostOrderSearch:root.leftChild action:action];
    [self depthFirstPostOrderSearch:root.rightChild action:action];
    [self runAction:action withNode:root];
}

+ (void)runAction:(BinaryTreeSearchAction)action withNode:(BinaryTreeNode *)node {
    if (action && node) {
        action(node);
    }
}

+ (void)enqueueNode:(BinaryTreeNode *)node toQueue:(Queue *)queue {
    if (node) {
        [queue enqueue:node];
    }
}

@end
