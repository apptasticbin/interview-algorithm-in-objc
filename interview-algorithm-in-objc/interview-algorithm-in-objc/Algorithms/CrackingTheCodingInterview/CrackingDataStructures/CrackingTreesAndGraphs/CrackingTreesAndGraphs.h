//
//  CrackingTreesAndGraphs.h
//  interview-algorithm-in-objc
//
//  Created by Bin Yu on 03/04/16.
//  Copyright © 2016 Bin Yu. All rights reserved.
//

#import <Foundation/Foundation.h>

@class BinaryTreeNode;

@interface CrackingTreesAndGraphs : NSObject

+ (BOOL)isBinaryTreeBalanced:(BinaryTreeNode *)binaryTree;
+ (BOOL)betterIsBinaryTreeBalanced:(BinaryTreeNode *)binaryTree;

@end
