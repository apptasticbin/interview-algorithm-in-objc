//
//  CrackingLinkedLists.h
//  interview-algorithm-in-objc
//
//  Created by Bin Yu on 27/03/16.
//  Copyright © 2016 Bin Yu. All rights reserved.
//

#import <Foundation/Foundation.h>

@class LinkedListNode;

@interface CrackingLinkedLists : NSObject

+ (void)removeDuplicatesWithBufferFromList:(LinkedListNode *)headNode;
+ (void)removeDuplicatesFromList:(LinkedListNode *)headNode;
+ (LinkedListNode *)findNodeInList:(LinkedListNode *)headNode kthFromLastNode:(NSInteger)k;
+ (NSInteger)findNodeInListRecursively:(LinkedListNode *)headNode kthFromLastNode:(NSInteger)k result:(LinkedListNode **)resultNode;
+ (void)deleteNode:(LinkedListNode *)node;
+ (LinkedListNode *)partitionLinkedList:(LinkedListNode *)headNode byValue:(NSInteger)value;
+ (LinkedListNode *)addReverseOrderNumberList:(LinkedListNode *)thisList withNumberList:(LinkedListNode *)thatList;
+ (LinkedListNode *)addReverseOrderNumberList:(LinkedListNode *)thisList withNumberList:(LinkedListNode *)thatList carry:(NSInteger)carry;
+ (LinkedListNode *)addForwardOrderNumberList:(LinkedListNode *)thisList withNumberList:(LinkedListNode *)thatList;

@end
