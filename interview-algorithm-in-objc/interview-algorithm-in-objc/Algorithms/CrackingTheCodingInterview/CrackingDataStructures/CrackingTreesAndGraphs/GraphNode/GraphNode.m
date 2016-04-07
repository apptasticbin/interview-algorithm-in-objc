//
//  DirectedGraphNode.m
//  interview-algorithm-in-objc
//
//  Created by Bin Yu on 05/04/16.
//  Copyright © 2016 Bin Yu. All rights reserved.
//

#import "GraphNode.h"
#import "Queue.h"

@implementation GraphNode

- (instancetype)initWithData:(id)data
{
    self = [super init];
    if (self) {
        _data = data;
        _visitState = GraphNodeNotVisited;
        _adjacents = [NSMutableArray array];
    }
    return self;
}

+ (instancetype)nodeWithData:(id)data {
    return [[GraphNode alloc] initWithData:data];
}

+ (void)breadthFirstTraverse:(GraphNode *)node withAction:(GraphTraverseAction)action {
    Queue *nodeQueue = [Queue new];
    [self visitNode:node withAction:action];
    node.visitState = GraphNodeVisiting;
    [nodeQueue enqueue:node];
    while (![nodeQueue isEmpty]) {
        GraphNode *node = [nodeQueue dequeue];
        for (NSInteger i=0; i<node.adjacents.count; i++) {
            GraphNode *adjacentNode = node.adjacents[i];
            if (adjacentNode.visitState == GraphNodeNotVisited) {
                [self visitNode:adjacentNode withAction:action];
                adjacentNode.visitState = GraphNodeVisiting;
                [nodeQueue enqueue:adjacentNode];
            }
        }
        node.visitState = GraphNodeVisited;
    }
}

+ (void)depthFirstTraverse:(GraphNode *)node withAction:(GraphTraverseAction)action {
    if (!node || node.visitState != GraphNodeNotVisited) {
        return;
    }
    [self visitNode:node withAction:action];
    node.visitState = GraphNodeVisiting;
    for (NSInteger i=0; i<node.adjacents.count; i++) {
        GraphNode *adjacentNode = node.adjacents[i];
        [self depthFirstTraverse:adjacentNode withAction:action];
    }
    node.visitState = GraphNodeVisited;
}

- (void)addAdjacent:(GraphNode *)node {
    [self addAdjacents:@[node]];
}

- (void)addAdjacents:(NSArray *)adjacents {
    [self.adjacents addObjectsFromArray:adjacents];
}

- (void)removeAdjacent:(GraphNode *)node {
    [self removeAdjacents:@[node]];
}

- (void)removeAdjacents:(NSArray *)adjacents {
    [self.adjacents removeObjectsInArray:adjacents];
}

#pragma mark - Private

+ (void)visitNode:(GraphNode *)node withAction:(GraphTraverseAction)action {
    if (!node) {
        return;
    }
    if (action) {
        action(node);
    }
}

@end
