//
//  BinaryTreeNode.h
//  interview-algorithm-in-objc
//
//  Created by Bin Yu on 04/04/16.
//  Copyright © 2016 Bin Yu. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, DepthFirstSearchOrder) {
    DepthFirstSearchPreOrder = 0,
    DepthFirstSearchInOrder,
    DepthFirstSearchPostOrder
};

@class BinaryTreeNode;
typedef void(^BinaryTreeSearchAction)(BinaryTreeNode *node);

@interface BinaryTreeNode : NSObject

@property(nonatomic, weak) BinaryTreeNode *parent;
@property(nonatomic, strong) BinaryTreeNode *leftChild;
@property(nonatomic, strong) BinaryTreeNode *rightChild;
@property(nonatomic, strong) id data;

+ (instancetype)treeNodeWithData:(id)data parent:(BinaryTreeNode *)parent;
+ (instancetype)treeNodeWithData:(id)data parent:(BinaryTreeNode *)parent
                       leftChild:(BinaryTreeNode *)leftChild
                      rightChild:(BinaryTreeNode *)rightChild;

+ (void)depthFirstSearch:(BinaryTreeNode *)root action:(BinaryTreeSearchAction)action order:(DepthFirstSearchOrder)order;
+ (void)breadthFirstSearch:(BinaryTreeNode *)root action:(BinaryTreeSearchAction)action;
+ (NSInteger)heightOfTree:(BinaryTreeNode *)root;

@end
