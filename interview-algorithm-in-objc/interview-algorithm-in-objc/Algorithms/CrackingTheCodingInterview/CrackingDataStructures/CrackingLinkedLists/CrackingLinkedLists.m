//
//  CrackingLinkedLists.m
//  interview-algorithm-in-objc
//
//  Created by Bin Yu on 27/03/16.
//  Copyright © 2016 Bin Yu. All rights reserved.
//

#import "CrackingLinkedLists.h"
#import "LinkedListNode.h"

@implementation CrackingLinkedLists

/**
 Linked list problems rely so much on the fundamental concepts, 
 so it is essential that you can implement a linked list from scratch
 */

/**
 Write code to remove duplicates from an unsorted linked list.
 
 FOLLOW UP:
 How would you solve this problem if a temporary buffer is not allowed?
 */

+ (void)removeDuplicatesWithBufferFromList:(LinkedListNode *)headNode {
    if (!headNode || !headNode.next) {
        return;
    }
    /**
     - can use NSHashTable
     - O(N)
     */
    NSCountedSet *counter = [NSCountedSet set];
    LinkedListNode *previousNode = nil;
    while (headNode) {
        NSInteger data = headNode.data;
        if ([counter countForObject:@(data)]) {
            previousNode.next = headNode.next;
        } else {
            [counter addObject:@(data)];
            previousNode = headNode;
        }
        headNode = headNode.next;
    }
}

+ (void)removeDuplicatesFromList:(LinkedListNode *)headNode {
    if (!headNode || !headNode.next) {
        return;
    }
    /**
     - without buffer, we use double pointers (Runner)
     - O(1) space, O(N*N) time
     */
    LinkedListNode *current = headNode;
    LinkedListNode *runner = current;
    while (current) {
        if (!runner.next) {
            current = current.next;
            runner = current;
            continue;
        }
        
        if(runner.next.data == current.data) {
            runner.next = runner.next.next;
        } else {
            runner = runner.next;
        }
    }
}

/**
 Implement an algorithm to find the kth to last element of a singly linked list.
 */

/**
 There are a number of other solutions that we haven't addressed. 
 We could store the counter in a static variable. Or, we could create a 
 class that stores both the node and the counter, and return an instance 
 of that class. Regardless of which solution we pick, we need a way to 
 update both the node and the counter in a way that all levels of the 
 recursive stack will see.
 */

+ (LinkedListNode *)findNodeInList:(LinkedListNode *)headNode kthFromLastNode:(NSInteger)k {
    /**
     - Note that for this solution, we have defined k such that passing
     in k = 1 would return the last element, k = 2 would return to the
     second to last element, and so on. It is equally acceptable to
     define k such that k = 0 would return the last element
     - This algorithm takes 0(n) time and 0(1) space.
     */
    if (k < 0) {
        return nil;
    }
    LinkedListNode *current = headNode;
    LinkedListNode *runner = headNode;
    // find kth node from head
    for (NSInteger idx=0; idx<k-1; idx++) {
        // if length of linked list is shorter than k, return nil
        if (!runner.next) {
            return nil;
        }
        runner = runner.next;
    }
    // now move both current and runner pointer
    while (runner.next) {
        runner = runner.next;
        current = current.next;
    }
    return current;
}

+ (NSInteger)findNodeInListRecursively:(LinkedListNode *)headNode kthFromLastNode:(NSInteger)k
                               result:(LinkedListNode **)resultNode {
    /**
     - O(N) space complexity
     - Alternative: 
     (LinkedListNode *)findNodeInListRecursively:(LinkedListNode *)headNode kthFromLastNode:(NSInteger)k
                                        counter:(NSInteger *)counter
     */
    if (!headNode) {
        return 0;
    }
    NSInteger count = [self findNodeInListRecursively:headNode.next kthFromLastNode:k result:resultNode] + 1;
    if (count == k) {
        *resultNode = headNode;
    }
    return count;
}

/**
 Implement an algorithm to delete a node in the middle of a singly linked list, given only access to that node.
 EXAMPLE
 Input: the node c from the linked list a->b->c->d->e
 Result: nothing is returned, but the new linked list looks like a->b->d->e
 */

+ (void)deleteNode:(LinkedListNode *)node {
    if (!node || !node.next) {
        return;
    }
    node.data = node.next.data;
    node.next = node.next.next;
}

/**
 Write code to partition a linked list around a value x, 
 such that all nodes less than x come before all nodes greater than or equal to x.
 */

+ (LinkedListNode *)partitionLinkedList:(LinkedListNode *)headNode byValue:(NSInteger)value {
    if (!headNode || !headNode.next) {
        return nil;
    }
    LinkedListNode *lessStart = nil;
    LinkedListNode *lessEnd = nil;
    LinkedListNode *equalOrGreaterStart = nil;
    LinkedListNode *equalOrGreaterEnd = nil;
    
    while (headNode) {
        if (headNode.data < value) {
            if (!lessStart) {
                lessStart = headNode;
                lessEnd = headNode;
            } else {
                lessEnd.next = headNode;
                lessEnd = lessEnd.next;
            }
        } else {
            if (!equalOrGreaterStart) {
                equalOrGreaterStart = headNode;
                equalOrGreaterEnd = headNode;
            } else {
                equalOrGreaterEnd.next = headNode;
                equalOrGreaterEnd = equalOrGreaterEnd.next;
            }
        }
        headNode = headNode.next;
    }
    lessEnd.next = equalOrGreaterStart;
    equalOrGreaterEnd.next = nil;
    return lessStart;
}

/**
 You have two numbers represented by a linked list, where each node contains a single digit. 
 The digits are stored in reverse order, such that the 1's digit is at the head of the list.
 Write a function that adds the two numbers and returns the sum as a linked list.
 
 EXAMPLE
 Input:(7-> 1 -> 6) + (5 -> 9 -> 2). That is, 617 + 295.
 Output: 2 -> 1 -> 9. That is, 912.
 
 FOLLOW UP:
 Suppose the digits are stored in forward order. Repeat the above problem. 
 
 EXAMPLE
 Input:(6 -> 1 -> 7) + (2 -> 9 -> 5). That is, 617 + 295.
 Output: 9 -> 1 -> 2. That is, 912.
 */

+ (LinkedListNode *)addReverseOrderNumberList:(LinkedListNode *)thisList withNumberList:(LinkedListNode *)thatList {
    if (!thisList || !thatList) {
        return nil;
    }
    LinkedListNode *resultList = nil;
    
    NSInteger extra = 0;
    while (thisList || thatList || extra) {
        NSInteger modulus = 0;
        NSInteger thisNumber = 0;
        NSInteger thatNumber = 0;
        NSInteger sum = 0;
        if (thisList) {
            thisNumber = thisList.data;
        }
        if (thatList) {
            thatNumber = thatList.data;
        }
        sum = thisNumber + thatNumber + extra;
        modulus = sum % 10;
        extra = sum / 10;
        
        if (!resultList) {
            resultList = [LinkedListNode nodeWithData:modulus];
        } else {
            [resultList appendNodeToEnd:modulus];
        }
        
        thisList = thisList.next;
        thatList = thatList.next;
    }
    
    return resultList;
}

+ (LinkedListNode *)addReverseOrderNumberList:(LinkedListNode *)thisList withNumberList:(LinkedListNode *)thatList carry:(NSInteger)carry {
    if (!thisList && !thatList && !carry) {
        return nil;
    }
    NSInteger value = 0;
    if (thisList) {
        value += thisList.data;
    }
    if (thatList) {
        value += thatList.data;
    }
    if (carry) {
        value += carry;
    }
    LinkedListNode *resultList = [LinkedListNode nodeWithData:value % 10];
    resultList.next = [self addReverseOrderNumberList:thisList.next withNumberList:thatList.next carry:value / 10];
    
    return resultList;
}

+ (LinkedListNode *)addForwardOrderNumberList:(LinkedListNode *)thisList withNumberList:(LinkedListNode *)thatList {
    /**
     - also, we can create class to wrap the partial results
     class PartialResult {
        NSInteger value;
        NSInteger carry;
     }
     - because we are using forwarding traversing, so we MUST pad ZEROs on shorter number list
     */
    NSInteger thisLength = [thisList count];
    NSInteger thatLength = [thatList count];
    
    if (thisLength < thatLength) {
        thisList = [self padZerosToNumberList:thisList count:thatLength-thisLength];
    } else {
        thatList = [self padZerosToNumberList:thatList count:thisLength-thatLength];
    }
    
    NSInteger carry = 0;
    LinkedListNode *resultList = [self addHelperForNumberList:thisList withNumberList:thatList carry:&carry];
    if (carry) {
        LinkedListNode *tmp = resultList;
        resultList = [LinkedListNode nodeWithData:carry];
        resultList.next = tmp;
    }
    return resultList;
}

+ (LinkedListNode *)padZerosToNumberList:(LinkedListNode *)theList count:(NSInteger)count {
    for (NSInteger i=0; i<count; i++) {
        LinkedListNode *zeroNode = [LinkedListNode nodeWithData:0];
        zeroNode.next = theList;
        theList = zeroNode;
    }
    return theList;
}

+ (LinkedListNode *)addHelperForNumberList:(LinkedListNode *)thisList withNumberList:(LinkedListNode *)thatList carry:(NSInteger *)carry {
    if (!thisList && !thatList) {
        return nil;
    }
    LinkedListNode *nextNumber = [self addHelperForNumberList:thisList.next withNumberList:thatList.next carry:carry];
    NSInteger value = *carry;
    if (thisList) {
        value += thisList.data;
    }
    if (thatList) {
        value += thatList.data;
    }
    LinkedListNode *resultNumber = [LinkedListNode nodeWithData:value % 10];
    resultNumber.next = nextNumber;
    
    *carry = value / 10;
    return resultNumber;
}

/**
 Given a circular linked list, implement an algorithm which returns the node at the beginning of the loop.
 
 DEFINITION:
 Circular linked list: A (corrupt) linked list in which a node's next pointer points to an earlier node, 
 so as to make a loop in the linked list.

 EXAMPLE:
 Input:A -> B -> C -> D -> E -> C [the same C as earlier]
 Output:C
 */

- (LinkedListNode *)findBeginningLoopNodeInList:(LinkedListNode *)headList {
    return nil;
}

/**
 Implement a function to check if a linked list is a palindrome.
 */

- (BOOL)isListAPalindrome:(LinkedListNode *)headNode {
    return YES;
}

@end
