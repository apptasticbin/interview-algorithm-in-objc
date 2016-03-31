//
//  CrackingStacksAndQueues.m
//  interview-algorithm-in-objc
//
//  Created by Bin Yu on 29/03/16.
//  Copyright © 2016 Bin Yu. All rights reserved.
//

#import "CrackingStacksAndQueues.h"
#import "Stack.h"

@implementation CrackingStacksAndQueues

/**
 Describe how you could use a single array to implement three stacks.
 */

- (void)fixedSizeArrayThreesomeStack {
    // check class FixedSizeArrayThreesomeStack
}

/**
 How would you design a stack which, in addition to push and pop, 
 also has a function min which returns the minimum element?
 Push, pop and min should all operate in O(1) time.
 */

- (void)stackWithMinimum {
    /**
     - check StackWithMinimum implementation
     - StackWithMinimum is implementation with more space efficiency
     */
}

/**
 Imagine a (literal) stack of plates. If the stack gets too high, it might topple. 
 Therefore, in real life, we would likely start a new stack when the previous stack exceeds some threshold.
 Implement a data structure SetOfStacks that mimics this. SetOfStacks should be composed of several
 stacks and should create a new stack once the previous one exceeds capacity. SetOfStacks.push() and SetOfStacks.pop() 
 should behave identically to a single stack (that is,pop() should return the same values as it would 
 if there were just a single stack).
 
 FOLLOW UP
 
 Implement a function popAt(int index) which performs a pop operation on a specific sub-stack.
 */

- (void)setOfStacks {
    /**
     - check SetOfStacks implementation
     */
}

/**
 In the classic problem of the Towers of Hanoi, you have 3 towers and N disks of different
 sizes which can slid onto any tower. The puzzle starts with disks sorted in ascending order
 of size from top to bottom (i.e., each disk sits on top of an even larger one). You have the 
 following constraints:
 
 (1) Only one disk can be moved at a time.
 (2) A disk is slid off the top of one tower onto the next rod. (NOT MUST be the rod near by)
 (3) A disk can only be placed on top of a larger disk.
 
 Write a program to move the disks from the first tower to the last using stacks
 */

+ (void)towersOfHanoiPuzzleSolver:(NSArray *)stacks {
    if (stacks.count > 3) {
        @throw [NSException exceptionWithName:@"TooMuchTowersException"
                                       reason:@"Tower amount is more than 3"
                                     userInfo:nil];
    }
    Stack *leftTower = stacks[0];
    leftTower.tag = 1;
    Stack *midTower = stacks[1];
    midTower.tag = 2;
    Stack *rightTower = stacks[2];
    rightTower.tag = 3;
    NSLog(@"\nFromTower: %@\nViaTower: %@\nToTower: %@", leftTower.top, midTower.top, rightTower.top);
    [self switchDisksFromTower:leftTower toTower:rightTower viaTower:midTower diskAmount:leftTower.count];
}

+ (void)switchDisksFromTower:(Stack *)fromTower
                     toTower:(Stack *)toTower
                    viaTower:(Stack *)viaTower
                  diskAmount:(NSInteger)diskAmount {
    if (diskAmount <= 0) {
        return;
    }
    
    [self switchDisksFromTower:fromTower toTower:viaTower viaTower:toTower diskAmount:diskAmount-1];
    [self moveTopFromTower:fromTower toTower:toTower];
    [self switchDisksFromTower:viaTower toTower:toTower viaTower:fromTower diskAmount:diskAmount-1];
}

+ (void)moveTopFromTower:(Stack *)fromTower toTower:(Stack *)toTower {
    if ([fromTower isEmpty]) {
        return;
    }
    if ([toTower isEmpty]) {
        [toTower push:[fromTower pop]];
        NSLog(@"\nMove %ld from tower %ld to tower %ld",
              (long)[toTower peek], (long)fromTower.tag, (long)toTower.tag);
        return;
    }
    NSInteger fromTowerTop = [fromTower peek];
    NSInteger toTowerTop = [toTower peek];
    if (fromTowerTop < toTowerTop) {
        [toTower push:[fromTower pop]];
        NSLog(@"\nMove %ld from tower %ld to tower %ld",
              (long)fromTowerTop, (long)fromTower.tag, (long)toTower.tag);
    }
}

/**
 Implement a MyQueue class which implements a queue using two stacks.
 */

- (void)myQueue {
    
}

/**
 Write a program to sort a stack in ascending order (with biggest items on top). 
 You may use at most one additional stack to hold items, but you may not copy the
 elements into any other data structure (such as an array). The stack supports the
 following operations: push, pop, peek, and isEmpty.
 */

/**
 An animal shelter holds only dogs and cats, and operates on a strictly "first in, first out" basis. 
 People must adopt either the "oldest" (based on arrival time) of all animals at the shelter, or they
 can select whether they would prefer a dog or a cat (and will receive the oldest animal of that type).
 They cannot select which specificanimal they would like. Create the data structures to maintain this 
 system and implement operations such as enqueue, dequeueAny, dequeueDog and dequeueCat.You mayusethe 
 built-in LinkedList data structure.
 */

@end
