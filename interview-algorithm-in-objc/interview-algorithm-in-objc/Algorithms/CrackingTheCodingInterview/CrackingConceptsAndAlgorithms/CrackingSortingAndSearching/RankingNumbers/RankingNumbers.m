//
//  RankingNumbers.m
//  interview-algorithm-in-objc
//
//  Created by Bin Yu on 25/04/16.
//  Copyright © 2016 Bin Yu. All rights reserved.
//

#import "RankingNumbers.h"
#import "BinarySearchTreeNode.h"

@interface RankingNumbers ()

@property (nonatomic, strong) BinarySearchTreeNode *numbersTree;

@end

@implementation RankingNumbers

/**
 - keep numbers sorted during insertion is CORRECT :)
 - However, this is very inefficient for inserting elements (that is, the track(int x) function). 
 We need a data structure which is good at keeping relative ordering, as well as updating when we insert 
 new elements. 
 - A binary search tree can do just that.

 */
- (void)track:(NSInteger)number {
    if (!self.numbersTree) {
        self.numbersTree = [BinarySearchTreeNode treeNodeWithData:@(number) parent:nil];
    } else {
        [self.numbersTree insertNumberNode:@(number)];
    }
}

- (NSInteger)rankOfNumber:(NSInteger)number {
    return [self.numbersTree rankOfNumberNode:@(number)];
}

#pragma mark - Private

@end
