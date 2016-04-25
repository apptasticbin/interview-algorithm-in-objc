//
//  BinarySearchTreeNode.m
//  interview-algorithm-in-objc
//
//  Created by Bin Yu on 25/04/16.
//  Copyright © 2016 Bin Yu. All rights reserved.
//

#import "BinarySearchTreeNode.h"

@interface BinaryTreeNode (Protected)

- (instancetype)initWithData:(id)data parent:(BinaryTreeNode *)parent
                   leftChild:(BinaryTreeNode *)leftChild
                  rightChild:(BinaryTreeNode *)rightChild;
@end

@implementation BinarySearchTreeNode

#pragma mark - Public

+ (instancetype)treeNodeWithData:(id)data parent:(BinaryTreeNode *)parent {
    return [[self alloc] initWithData:data parent:parent leftChild:nil rightChild:nil];
}

- (void)insertNumberNode:(id)data {
    if ([data integerValue] <= [self.data integerValue]) {
        if (!self.leftChild) {
            self.leftChild = [BinarySearchTreeNode treeNodeWithData:data parent:self];
        } else {
            BinarySearchTreeNode *leftChild = (BinarySearchTreeNode *)self.leftChild;
            [leftChild insertNumberNode:data];
        }
        self.leftSize++;
    } else {
        if (!self.rightChild) {
            self.rightChild = [BinarySearchTreeNode treeNodeWithData:data parent:self];
        } else {
            BinarySearchTreeNode *rightChild = (BinarySearchTreeNode *)self.rightChild;
            [rightChild insertNumberNode:data];
        }
    }
}

- (NSInteger)rankOfNumberNode:(id)data {
    NSInteger thisNumber = [self.data integerValue];
    NSInteger thatNumber = [data integerValue];
    if (thisNumber == thatNumber) {
        return self.leftSize;
    } else if(thisNumber > thatNumber) {
        if (!self.leftChild) {
            return -1;
        }
        BinarySearchTreeNode *leftChild = (BinarySearchTreeNode *)self.leftChild;
        return [leftChild rankOfNumberNode:data];
    } else {
        if (!self.rightChild) {
            return -1;
        }
        BinarySearchTreeNode *rightChild = (BinarySearchTreeNode *)self.rightChild;
        NSInteger rightRank = [rightChild rankOfNumberNode:data];
        if (rightRank == -1) {
            return -1;
        } else {
            return self.leftSize + 1 + rightRank;
        }
    }
}

#pragma mark - Private

- (instancetype)initWithData:(id)data parent:(BinaryTreeNode *)parent
                   leftChild:(BinaryTreeNode *)leftChild
                  rightChild:(BinaryTreeNode *)rightChild {
    self = [super initWithData:data parent:parent leftChild:leftChild rightChild:rightChild];
    if (self) {
        _leftSize = 0;
    }
    return self;
}

@end
