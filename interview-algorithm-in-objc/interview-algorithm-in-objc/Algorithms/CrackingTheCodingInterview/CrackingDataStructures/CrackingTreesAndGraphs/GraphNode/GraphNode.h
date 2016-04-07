//
//  DirectedGraphNode.h
//  interview-algorithm-in-objc
//
//  Created by Bin Yu on 05/04/16.
//  Copyright © 2016 Bin Yu. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, GraphNodeVisitState) {
    GraphNodeNotVisited = 0,
    GraphNodeVisiting,
    GraphNodeVisited
};

@class GraphNode;
typedef void(^GraphTraverseAction)(GraphNode *node);

@interface GraphNode : NSObject

@property(nonatomic, strong) NSMutableArray *adjacents;
@property(nonatomic, assign) GraphNodeVisitState visitState;
@property(nonatomic, strong) id data;

+ (instancetype)nodeWithData:(id)data;

+ (void)breadthFirstTraverse:(GraphNode *)node withAction:(GraphTraverseAction)action;
+ (void)depthFirstTraverse:(GraphNode *)node withAction:(GraphTraverseAction)action;

- (void)addAdjacent:(GraphNode *)node;
- (void)addAdjacents:(NSArray *)adjacents;
- (void)removeAdjacent:(GraphNode *)node;
- (void)removeAdjacents:(NSArray *)adjacents;

@end
