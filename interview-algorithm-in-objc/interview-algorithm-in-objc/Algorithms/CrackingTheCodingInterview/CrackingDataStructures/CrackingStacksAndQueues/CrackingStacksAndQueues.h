//
//  CrackingStacksAndQueues.h
//  interview-algorithm-in-objc
//
//  Created by Bin Yu on 29/03/16.
//  Copyright © 2016 Bin Yu. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Stack;

@interface CrackingStacksAndQueues : NSObject

+ (void)towersOfHanoiPuzzleSolver:(NSArray *)stacks;
+ (void)sortStackInAscendingOrder:(Stack *)stack;
+ (Stack *)betterSortStackInAscendingOrder:(Stack *)stack;
@end
