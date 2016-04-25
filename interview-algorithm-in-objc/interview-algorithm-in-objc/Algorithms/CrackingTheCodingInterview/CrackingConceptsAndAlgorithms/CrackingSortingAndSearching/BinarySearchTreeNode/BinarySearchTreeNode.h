//
//  BinarySearchTreeNode.h
//  interview-algorithm-in-objc
//
//  Created by Bin Yu on 25/04/16.
//  Copyright © 2016 Bin Yu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BinaryTreeNode.h"

@interface BinarySearchTreeNode : BinaryTreeNode

@property(nonatomic, assign) NSInteger leftSize;

- (void)insertNumberNode:(id)data;
- (NSInteger)rankOfNumberNode:(id)data;

@end
