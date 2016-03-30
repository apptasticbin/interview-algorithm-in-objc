//
//  CrackingStacksAndQueues.m
//  interview-algorithm-in-objc
//
//  Created by Bin Yu on 29/03/16.
//  Copyright © 2016 Bin Yu. All rights reserved.
//

#import "CrackingStacksAndQueues.h"

@implementation CrackingStacksAndQueues

/**
 Describe how you could use a single array to implement three stacks.
 */

/**
 How would you design a stack which, in addition to push and pop, 
 also hasa function min which returns the minimum element? 
 Push, pop and min should all operate in O(1) time.
 */

/**
 Imagine a (literal) stack of plates. If the stack gets too high, it might topple. 
 Therefore, in real life, we would likely start a new stack when the previous stack exceeds somethreshold. 
 Implement a data structure SetOfStacks that mimics this. SetOfStacks should be composed of several
 stacks and should create a new stack once the previous one exceeds capacity. SetOfStacks.push() and SetOfStacks.pop() 
 should behave identically to a single stack (that is,pop() should return the same values as it would 
 if there were just a single stack).
 
 FOLLOW UP
 
 Implement afunction popAt(int index) which performs a pop operation on a specific sub-stack.
 */

/**
 In the classic problem of the Towers of Hanoi, you have 3 towers and N disks of different
 sizes which can slide onto any tower. The puzzle starts with disks sorted in ascending order 
 of size from top to bottom (i.e., each disk sits on top of an even larger one). You have the 
 following constraints:
 
 (1) Only one disk can be moved at a time.
 (2) A disk is slid off the top of one tower onto the next tower.
 (3) A disk can only be placed on top of a larger disk.
 
 Write a program to move the disksfrom the first tower to the last using stacks
 */

/**
 Implement a MyQueue class which implements a queue using two stacks.
 */

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
