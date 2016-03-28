//
//  LinkedListNode.m
//  interview-algorithm-in-objc
//
//  Created by Bin Yu on 28/03/16.
//  Copyright © 2016 Bin Yu. All rights reserved.
//

#import "LinkedListNode.h"

@implementation LinkedListNode

+ (LinkedListNode *)nodeWithData:(NSInteger)data {
    return [[LinkedListNode alloc] initWithData:data];
}

- (instancetype)initWithData:(NSInteger)data {
    self = [super init];
    if (self) {
        _data = data;
        _next = nil;
    }
    return self;
}

- (void)appendNodeToEnd:(NSInteger)data {
    LinkedListNode *node = [LinkedListNode nodeWithData:data];
    LinkedListNode *endNode = self;
    while (endNode.next) {
        endNode = endNode.next;
    }
    endNode.next = node;
}

+ (LinkedListNode *)deleteNodeInList:(LinkedListNode *)headNode withData:(NSInteger)data {
    LinkedListNode *currentNode = headNode;
    // if delete first node, just move head pointer
    if (currentNode.data == data) {
        return headNode.next;
    }
    // traverse through list one by one
    while (currentNode.next) {
        if (currentNode.next.data == data) {
            currentNode.next = currentNode.next.next;
            return headNode;
        }
        currentNode = currentNode.next;
    }
    return headNode;
}

+ (LinkedListNode *)linkedListWithArray:(NSArray *)array {
    if (!array || !array.count) {
        return nil;
    }
    LinkedListNode *headNode = nil;
    for (NSInteger idx=0; idx<array.count; idx++) {
        if (!headNode) {
            headNode = [LinkedListNode nodeWithData:[array[idx] integerValue]];
            continue;
        }
        [headNode appendNodeToEnd:[array[idx] integerValue]];
    }
    return headNode;
}

- (NSArray *)dataArrayFromList {
    NSMutableArray *array = [NSMutableArray array];
    LinkedListNode *head = self;
    while (head) {
        [array addObject:@(head.data)];
        head = head.next;
    }
    return array;
}

- (LinkedListNode *)nodeAtIndex:(NSInteger)index {
    LinkedListNode *node = self;
    for (NSInteger idx=0; idx<index; idx++) {
        if (!node.next) {
            return nil;
        }
        node = node.next;
    }
    return node;
}

- (NSInteger)count {
    NSInteger counter = 0;
    LinkedListNode *runner = self;
    while (runner) {
        counter++;
        runner = runner.next;
    }
    return counter;
}

#pragma mark - NSObject

- (NSString *)description {
    NSArray *array = [self dataArrayFromList];
    return [array componentsJoinedByString:@" -> "];
}

@end
